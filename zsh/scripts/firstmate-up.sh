#!/usr/bin/env bash
set -euo pipefail

FM_DIR="${FM_DIR:-$HOME/projects/firstmate}"
FM_REPO="https://github.com/kunchenguid/firstmate"

# --- OS + Homebrew detection ------------------------------------------------
OS="$(uname -s)"
case "$OS" in
  Darwin)  BREW="/opt/homebrew/bin/brew"; [[ -x "$BREW" ]] || BREW="/usr/local/bin/brew" ;;
  Linux)   BREW="$(command -v brew || true)" ;;
  *) echo "firstmate-up: unsupported OS: $OS"; exit 1 ;;
esac

if [[ -z "$BREW" || ! -x "$BREW" ]]; then
  read -rp "firstmate-up: Homebrew not found. Install it now? [y/N] " -n 1 ans || true
  echo
  [[ "$ans" =~ ^[Yy]$ ]] || { echo "firstmate-up: aborting (Homebrew required)."; exit 1; }
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  BREW="$(command -v brew 2>/dev/null || true)"
  for cand in "$BREW" /opt/homebrew/bin/brew /usr/local/bin/brew "$HOME/.linuxbrew/bin/brew" /home/linuxbrew/.linuxbrew/bin/brew; do
    [[ -n "$cand" && -x "$cand" ]] && BREW="$cand" && break
  done
  [[ -x "$BREW" ]] || { echo "firstmate-up: could not locate Homebrew after install."; exit 1; }
  eval "$("$BREW" shellenv)"
fi

# --- Tool installation ------------------------------------------------------
install() {
  local tool="$1"
  command -v "$tool" >/dev/null 2>&1 || { echo "firstmate-up: installing $tool"; "$BREW" install "$tool"; }
}
install gh
if ! command -v opencode >/dev/null 2>&1; then
  echo "firstmate-up: installing opencode (anomalyco tap)"
  "$BREW" tap anomalyco/tap && "$BREW" install anomalyco/tap/opencode
fi

gh auth status >/dev/null 2>&1 || { echo "firstmate-up: run 'gh auth login' first"; exit 1; }

# --- Clone-or-launch --------------------------------------------------------
if [[ -d "$FM_DIR/.git" ]]; then
  if [[ "${1:-}" == "--update" ]]; then
    echo "firstmate-up: updating firstmate"
    git -C "$FM_DIR" pull --ff-only
  fi
elif [[ -d "$FM_DIR" ]] && [[ -n "$(ls -A "$FM_DIR")" ]]; then
  echo "firstmate-up: $FM_DIR exists but is not a firstmate clone; remove it or set FM_DIR elsewhere."
  exit 1
else
  echo "firstmate-up: bootstrapping firstmate at $FM_DIR"
  mkdir -p "$(dirname "$FM_DIR")"
  git clone "$FM_REPO" "$FM_DIR"
fi

[[ -f "$FM_DIR/AGENTS.md" && -d "$FM_DIR/.opencode/plugins" ]] || {
  echo "firstmate-up: $FM_DIR is incomplete (missing AGENTS.md or .opencode/plugins)"
  exit 1
}

cd "$FM_DIR"
exec opencode
