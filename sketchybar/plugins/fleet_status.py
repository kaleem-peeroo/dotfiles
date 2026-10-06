#!/usr/bin/env python3
"""Fleet status for the bar. Refreshes the cache (at most every 60s) and prints a summary as JSON.

Source A: open PRs on GitHub (gh GraphQL). Source B: working workers (firstmate bearings snapshot).
Read-only toward all repos. On a failed fetch the last cache is kept.
"""
import json
import os
import subprocess
import sys
import time

TTL = 60
STALE = 300
FM_DIR = os.environ.get("FM_DIR", os.path.expanduser("~/Software/firstmate"))
CACHE = os.path.join(os.environ.get("TMPDIR", "/tmp"), "fleet_status.json")
LOCK = CACHE + ".lock"
QUERY = (
    '{ search(query:"is:pr is:open author:@me org:Deliverance-AI", type:ISSUE, first:50) { nodes { '
    "... on PullRequest { number title url isDraft mergeStateStatus repository{nameWithOwner} "
    "commits(last:1){nodes{commit{statusCheckRollup{state}}}} } } } }"
)


def rollup_state(node):
    try:
        return node["commits"]["nodes"][0]["commit"]["statusCheckRollup"]["state"]
    except (KeyError, IndexError, TypeError):
        return None


def classify(node):
    if not isinstance(node, dict) or not node.get("number"):
        return None
    rollup = rollup_state(node)
    if node.get("isDraft"):
        return "draft"
    if node.get("mergeStateStatus") == "DIRTY":
        return "conflicts"
    if rollup in ("FAILURE", "ERROR"):
        return "red"
    if rollup in ("PENDING", "EXPECTED"):
        return "running"
    if node.get("mergeStateStatus") == "CLEAN" and rollup == "SUCCESS":
        return "ready"
    return "waiting"


def group_prs(nodes):
    groups = {k: [] for k in ("ready", "red", "conflicts", "running", "waiting", "draft")}
    for node in nodes:
        kind = classify(node)
        if kind:
            groups[kind].append({
                "repo": (node.get("repository") or {}).get("nameWithOwner", "?"),
                "number": node["number"],
                "title": node.get("title") or "",
                "url": node.get("url") or "",
            })
    return groups


def fetch_prs():
    out = subprocess.run(["gh", "api", "graphql", "-f", f"query={QUERY}"],
                         capture_output=True, text=True, timeout=30, check=True).stdout
    return group_prs(json.loads(out)["data"]["search"]["nodes"])


def fetch_workers():
    out = subprocess.run([os.path.join(FM_DIR, "bin/fm-bearings-snapshot.sh"), "--json"],
                         cwd=FM_DIR, capture_output=True, text=True, timeout=60, check=True).stdout
    return [{"id": w.get("id", ""), "name": w.get("name") or w.get("id", "worker")}
            for w in json.loads(out)["in_flight"] if w.get("state") == "working"]


def load():
    try:
        with open(CACHE) as f:
            data = json.load(f)
        return data if isinstance(data, dict) else {}
    except (OSError, ValueError):
        return {}


def save(cache):
    tmp = f"{CACHE}.{os.getpid()}"
    with open(tmp, "w") as f:
        json.dump(cache, f)
    os.replace(tmp, CACHE)


def refresh(cache, now):
    due = [(k, fn) for k, fn in (("prs", fetch_prs),)  # ponytail: workers (fetch_workers) unused while only Ready is shown
           if now - cache.get(k + "_at", 0) >= TTL]
    if not due:
        return cache
    try:  # one refresher at a time; the other items just read the cache
        if os.path.exists(LOCK) and now - os.path.getmtime(LOCK) > 120:
            os.remove(LOCK)
        os.close(os.open(LOCK, os.O_CREAT | os.O_EXCL))
    except OSError:
        return cache
    try:
        cache = load()  # another run may have refreshed while we waited
        for key, fn in due:
            if now - cache.get(key + "_at", 0) < TTL:
                continue
            try:
                cache[key] = fn()
                cache[key + "_at"] = now
            except Exception:  # offline, logged out, bad JSON: keep last value
                pass
        save(cache)
    finally:
        try:
            os.remove(LOCK)
        except OSError:
            pass
    return cache


def row(pr, tag=""):
    return {"text": f"{pr['repo']} #{pr['number']} {pr['title']}{tag}", "url": pr["url"], "counted": not tag}


def summarize(cache, now):
    prs = cache.get("prs") if isinstance(cache.get("prs"), dict) else None
    workers = cache.get("workers") if isinstance(cache.get("workers"), list) else []
    ages = [now - cache[k] for k in ("prs_at",) if isinstance(cache.get(k), (int, float))]
    stale = any(a > STALE for a in ages)
    if prs is None:
        return {"counts": None, "stale": stale, "rows": {}, "updated": ""}
    g = lambda k: prs.get(k) or []
    rows = {
        "ready": [row(p) for p in g("ready")] + [row(p, "  (waiting)") for p in g("waiting")]
                 + [row(p, "  (draft)") for p in g("draft")],
        "red": [row(p) for p in g("red")] + [row(p, "  (conflicts)") for p in g("conflicts")],
        "running": [row(p) for p in g("running")]
                   + [{"text": f"worker {w.get('name', '')}", "url": "", "counted": True} for w in workers],
    }
    counts = {
        "ready": len(g("ready")),
        "red": len(g("red")) + len(g("conflicts")),
        "running": len(g("running")) + len(workers),
    }
    updated = time.strftime("%H:%M:%S", time.localtime(cache.get("prs_at", now)))
    return {"counts": counts, "stale": stale, "rows": rows, "updated": updated}


if __name__ == "__main__":
    try:
        now = int(time.time())
        print(json.dumps(summarize(refresh(load(), now), now)))
    except Exception:
        print(json.dumps({"counts": None, "stale": True, "rows": {}, "updated": ""}))
        sys.exit(0)
