# AGENTS.md

## Project Overview

**Dotfiles** — personal macOS configuration managed as a git repository at `~/.config/`. Remote: `git@github.com:kaleem-peeroo/dotfiles.git` (branch: `master`).

Tech stack: pure config files — no build system, no runtime dependencies. Configs in TOML, Lua, shell, JSON, YAML, and INI.

Tools configured:
- **Shell**: zsh (`.zshrc`, oh-my-zsh, powerlevel10k, zoxide, fzf)
- **Terminals**: alacritty, kitty, wezterm, iterm2
- **Window manager**: aerospace (macOS tiling WM)
- **Menu bar**: sketchybar with custom plugins
- **Editor**: nvim (lua-based, lazy.nvim plugin manager, 40+ plugins)
- **Terminal multiplexer**: tmux (tpm plugins, vim-tmux-navigator)
- **AI coding**: opencode (pi-coding-agent config at `opencode/`)
- **File manager**: yazi (TUI file manager with plugins)
- **Data browser**: visidata (custom config with aggregators)
- **Others**: lazygit, ncspot, qBittorrent, zathura, raycast, iina, wandb

## Directory Structure

```
aerospace/        — AeroSpace tiling WM config (aerospace.toml)
alacritty/        — Alacritty terminal config + themes/
gh/               — GitHub CLI config (config.yml, hosts.yml)
kitty/            — Kitty terminal config
lazygit/          — Lazygit TUI config
ncspot/           — Spotify TUI client config
nvim/             — Neovim config (lua/)
  init.lua        — Entry point, lazy.nvim bootstrap
  lua/
    options.lua   — Vim options
    keymaps.lua   — Key mappings
    plugins/      — Per-plugin configs (40+ files)
    themes/       — Color themes (12 themes)
opencode/         — pi-coding-agent config (AGENTS.md, skills/)
  skills/         — Custom agent skills (caveman, find-skills)
sketchybar/       — macOS menu bar config
  colors.sh       — Color scheme presets (6 schemes)
  sketchybarrc    — Main bar config
  plugins/        — Widget plugins
tmux/             — Tmux config + tpm plugins/
visidata/         — VisiData CSV/data browser config
yazi/             — Yazi file manager config + plugins/
wezterm/          — WezTerm terminal config
zathura/          — PDF viewer config
iina/             — Video player config
qBittorrent/      — Torrent client config
raycast/          — Raycast launcher config
```

## Commands

No build/test/lint commands — this is config-only. Relevant workflows:

```bash
# Sync zshrc to this repo
alias sync_zshrc="cp ~/.zshrc ~/.config/.zshrc;"

# Git (common aliases via .zshrc)
g          # git
gs         # git status
gl         # git log
gc "<msg>" # git commit -m
gpull      # git pull
gpush      # git push
diffw      # git diff --color-words
lg         # lazygit

# Terminal multiplexer
tmn <name>  # tmux new -s
tma <name>  # tmux attach-session -t
tmls        # tmux ls
tmkill      # tmux kill-session -t
```

## Code Style & Conventions

- **Commit messages**: `tool: description` format. Lowercase after colon. Present tense ("added", "updated", "fixed"). Examples:
  ```
  sketchybar: reorderded network and discord indicators
  tmux: updated extended keys to work with csi-u for pi
  zshrc: Added PI_CODING_AGENT_DIR config dir
  ```
- **zshrc**: Aliases grouped with `# ? SECTION` comments. Uses `export` for env vars. `eval "$(...)"` for shell integrations. vi mode via `bindkey -v`.
- **nvim**: Plugin configs in `lua/plugins/<name>.lua`. One file per plugin. Themes in `lua/themes/`. Uses lazy.nvim for lazy-loading.
- **sketchybar**: Shell-based config. Colors as hex `0xffRRGGBB` in `colors.sh` with comment-toggled presets.
- **aerospace**: TOML. Comments explain normalization, orientation auto-detection.
- **visidata**: Python config. Imports custom modules (dedupe, confidence_intervals). Custom aggregators (`mean_ci95`).
- **No Makefile, package.json (except opencode), or build tooling.**

## Architecture Notes

- **`~/.config` IS the git repo** — files are symlinked or directly at `~/.config/<tool>/`. The `.zshrc` is copied into the repo via `sync_zshrc` alias (it lives at `~/.zshrc` but gets synced to `~/.config/.zshrc`).
- **nvim** uses lazy.nvim with `{ import = "plugins" }` and `{ import = "themes" }` — all plugin configs auto-load from `lua/plugins/` and `lua/themes/`.
- **opencode** (pi-coding-agent) uses custom skills in `opencode/skills/`. Has its own `AGENTS.md` with coding guidelines.
- **tmux** prefix is `C-a` (not default `C-b`). Uses tpm for plugin management. vi copy mode.
- **aerospace** has gaps, normalization, and mouse-follows-focus enabled. Integrates with sketchybar via `exec-on-workspace-change`.
- **Color schemes**: 6 preset schemes in sketchybar `colors.sh` (teal, gray, purple, red, blue, green, orange, yellow). Purple is active.
- **Alacritty** imports theme from `~/.config/alacritty/themes/coolnight.toml`. Opacity 0.8 with blur.

## Testing

No test framework. Config changes verified manually by reloading the tool:
- `tmux`: prefix + `r` to reload config
- `aerospace`: restarts with macOS or manually
- `sketchybar`: `sketchybar --reload`
- `nvim`: `:Lazy! sync` then `:Lazy! check`
- No CI/CD — repo pushed to GitHub manually.

## Git Workflow

- **Branch**: `master` only (no feature branches observed)
- **Remote**: `origin git@github.com:kaleem-peeroo/dotfiles.git`
- **Commit style**: `<tool-name>: <imperative-description>`. No body lines in recent commits. Single-line commits.
- **No PRs, no tags, no releases.** Direct pushes to master.
- **`.gitignore` excludes**: nvim plugin dirs, lazy-lock.json, github-copilot, raycast extensions, simple-update-notifier, tmux plugins, visidata `__pycache__`.
