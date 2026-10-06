#!/usr/bin/env python3
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "plugins"))
import fleet_status as fs


def pr(draft=False, merge="CLEAN", rollup="SUCCESS", number=1):
    commits = {"nodes": [{"commit": {"statusCheckRollup": {"state": rollup} if rollup else None}}]}
    return {"number": number, "title": "t", "url": "u", "isDraft": draft, "mergeStateStatus": merge,
            "repository": {"nameWithOwner": "o/r"}, "commits": commits}


cases = [
    ("clean green", pr(), "ready"),
    ("draft wins", pr(draft=True, merge="DIRTY", rollup="FAILURE"), "draft"),
    ("dirty is conflicts", pr(merge="DIRTY"), "conflicts"),
    ("failure is red", pr(rollup="FAILURE"), "red"),
    ("error is red", pr(rollup="ERROR"), "red"),
    ("pending is running", pr(merge="BLOCKED", rollup="PENDING"), "running"),
    ("expected is running", pr(merge="BLOCKED", rollup="EXPECTED"), "running"),
    ("blocked success is waiting", pr(merge="BLOCKED"), "waiting"),
    ("behind is waiting", pr(merge="BEHIND"), "waiting"),
    ("clean without checks is waiting", pr(rollup=None), "waiting"),
    ("empty node", {}, None),
    ("null node", None, None),
]
for desc, node, want in cases:
    got = fs.classify(node)
    assert got == want, f"{desc}: want {want}, got {got}"

nodes = [pr(number=1), pr(number=2, rollup="FAILURE"), pr(number=3, merge="DIRTY"), {}, None]
groups = fs.group_prs(nodes)
assert [p["number"] for p in groups["ready"]] == [1]
assert [p["number"] for p in groups["red"]] == [2]
assert [p["number"] for p in groups["conflicts"]] == [3]

now = 1000
cache = {"prs": groups, "prs_at": now - 10, "workers": [{"name": "w", "id": "i"}], "workers_at": now - 10}
out = fs.summarize(cache, now)
assert out["counts"] == {"ready": 1, "red": 2, "running": 1}, out["counts"]
assert out["stale"] is False
assert out["rows"]["running"][0]["url"] == ""

cache["prs_at"] = now - 301
assert fs.summarize(cache, now)["stale"] is True

assert fs.summarize({}, now)["counts"] is None
assert fs.summarize({"prs": "garbage", "prs_at": "x"}, now)["counts"] is None

print("passed")
