# AGENTS.md

## Project Overview

**Dotfiles** — personal macOS configuration managed as a git repository at `~/.config/`. Remote: `git@github.com:kaleem-peeroo/dotfiles.git` (branch: `master`).

Tech stack: pure config files — no build system, no runtime dependencies. Configs in TOML, Lua, shell, JSON, YAML, and INI.

Tools configured:
- **Shell**: zsh (`.zshrc`, oh-my-zsh, powerlevel10k, zoxide, fzf)
- **Terminals**: alacritty, kitty, wezterm, iterm2
- **Window manager**: aerospace (macOS tiling WM, alt-modifier keybindings)
- **Menu bar**: sketchybar with 16 custom shell plugins
- **Editor**: nvim (lua/), lazy.nvim, 46 plugin configs, 13 themes
- **Terminal multiplexer**: tmux (tpm, 8 plugins, C-a prefix)
- **AI coding**: opencode (pi-coding-agent at `opencode/` with custom skills)
- **File manager**: yazi (TUI with zoom plugin)
- **Data browser**: visidata (Python config, custom aggregators)
- **Others**: lazygit, ncspot, qBittorrent, zathura, raycast, iina, wandb

**Scale**: ~11,900 total lines across config files (nvim: 1,277, sketchybar: 669). Most actively maintained: sketchybar, tmux, nvim.

## Directory Structure

```
aerospace/           — AeroSpace tiling WM config (aerospace.toml)
alacritty/           — Alacritty terminal config + themes/
cagent/              — Config for cagent
gh/                  — GitHub CLI config (config.yml, hosts.yml)
kitty/               — Kitty terminal config
lazygit/             — Lazygit TUI config
ncspot/              — Spotify TUI client config
nvim/                — Neovim config (~1,277 lines)
  init.lua           — Entry point, lazy.nvim bootstrap
  lua/
    options.lua      — Vim options
    keymaps.lua      — Key mappings
    plugins/         — 46 per-plugin config files
    themes/          — 13 color themes
nvim/pack/github/    — Legacy vim-pack plugin dir (just copilot.vim)
opencode/            — pi-coding-agent config (opencode.json, package.json)
  skills/            — Custom agent skills (caveman, find-skills)
sketchybar/          — macOS menu bar config (~670 lines)
  colors.sh          — 8 color scheme presets
  sketchybarrc       — Default (non-notch) bar config
  sketchybarrc.notch — Notch-aware config (q/e positions, notch_width=180)
  sketchybarrc.nonotch — Legacy non-notch config
  plugins/           — 16 widget scripts
tmux/                — Tmux config + tpm plugins/
visidata/            — VisiData CSV/data browser config (Python)
yazi/                — Yazi file manager config + plugins/
  yazi.toml          — Main config
  package.toml       — Plugin declarations
wezterm/             — WezTerm terminal config (wezterm.lua, 20 lines)
zathura/             — PDF viewer config
iina/                — Video player config
qBittorrent/         — Torrent client config
raycast/             — Raycast launcher + extensions (4 extension dirs)
```

## Commands

No build/test/lint — pure config. Key workflows:

```bash
# Sync zshrc to repo
alias sync_zshrc="cp ~/.zshrc ~/.config/.zshrc;"

# Git
gs         # git status
gl         # git log
gc "msg"   # git commit -m
gpull      # git pull
gpush      # git push
diffw      # git diff --color-words
lg         # lazygit

# Reload commands
tmux:         prefix + r  (or source-file ~/.config/tmux/tmux.conf)
sketchybar:   sketchybar --reload
aerospace:    alt-; r (service mode → reload-config)
nvim:         :Lazy! sync; :Lazy! check

# Terminal
tmn <name>    # tmux new -s
tma <name>    # tmux attach-session -t
tmkill        # tmux kill-session -t

# Shell aliases
v   nvim        | c   cargo
sc  source      | py  python3
m   make        | vd  visidata (with config)
```

## Code Style & Conventions

- **Commit messages**: `<tool-name>: <description>` format. Lowercase after colon, present/past tense both used. Single-line only, no body. Examples:
  ```
  sketchybar: reorderded network and discord indicators
  nvim: disable copilot, fix neotest python path, fix obsidian vault path
  tmux: updated extended keys to work with csi-u for pi
  zshrc: Added PI_CODING_AGENT_DIR config dir
  ```
- **Commit freq**: sketchybar dominates (10/20 recent), tmux (4), nvim (3), opencode/zshrc (2 each)
- **zshrc**: Aliases grouped with `# ? SECTION` comments. `export` for env vars, `eval "$(...)"` for shell integrations. Uses oh-my-zsh (`zstyle ':omz:update' mode auto`). vi-mode commented out.
- **nvim**: Plugin configs in `lua/plugins/<name>.lua` (46 files), themes in `lua/themes/` (13 files). Auto-loads via lazy.nvim `{ import = "plugins" }` / `{ import = "themes" }`.
- **sketchybar**: Shell-based. Colors as `0xffRRGGBB` in `colors.sh` — 8 presets, active one uncommented. Currently Purple: `0xff140c42 / 0xff2b1c84 / 0xffeb46f9`.
  - Badge-count plugins use `lsappinfo info -only StatusLabel <bundle-id>`
  - App-font icons via `icon.font="sketchybar-app-font:Regular:16.0"` + `icon=":icon_name:"`
  - Known bundle IDs: Discord `com.hnc.Discord`, Outlook `com.microsoft.Outlook`, Teams `com.microsoft.teams2`
- **aerospace**: TOML, `alt` modifier. Named workspaces (obsidian, email, spotify). Vim-style hjkl. Service mode (alt-;) for reload/reset.
- **tmux**: Prefix `C-a` (not `C-b`). vim copy mode, csi-u extended keys. Bottom status bar with battery/RAM/network/CPU. Catppuccin mocha.
- **visidata**: Python. Custom modules (dedupe, confidence_intervals). Custom `mean_ci95` aggregator.
- **No Makefile, package.json (except opencode), or build tooling.**

## Architecture Notes

- **`~/.config` IS the git repo** — files are directly at `~/.config/<tool>/`. The `.zshrc` is copied into the repo via `sync_zshrc` alias (it lives at `~/.zshrc` but gets synced to `~/.config/.zshrc`). Only 3 top-level files: `.zshrc`, `.inputrc`, `.gitignore`.
- **sketchybar has 3 config files**: `sketchybarrc` (default/non-notch), `sketchybarrc.notch` (notch-aware with `q`/`e` positions + `notch_width=180`), `sketchybarrc.nonotch` (legacy). Switch via `cp` or symlink per README.
- **sketchybar ↔ aerospace**: `exec-on-workspace-change` in aerospace fires `aerospace_workspace_change` event to sketchybar. Handled by `space.sh` + `aerospace.sh` plugins. Borders via `after-startup-command`. Key cross-tool coupling.
- **Badge-count plugin pattern** (discord, outlook, teams): `lsappinfo info -only StatusLabel <bundle-id>` parsed for `"label"="N"`, falls back to "0" when empty. Uses `$WHITE` for no-unreads, brand color for unreads.
- **App-font icons**: `sketchybar-app-font.ttf` provides SF Symbols–style app logos. Use `icon.font="sketchybar-app-font:Regular:16.0"` + `icon=":name:"`. Icon names defined in `plugins/icon_map_fn.sh`.
- **nvim**: lazy.nvim auto-imports from `lua/plugins/` (46 files) and `lua/themes/` (13 files). Copilot dual-configured: `copilot_cmp.lua` + `zbirenbaum_copilot.lua`, plus legacy `pack/github/start/copilot.vim`.
- **tmux ↔ nvim**: vim-tmux-navigator in both (tmux via tpm, nvim via `lua/plugins/vim-tmux-navigator.lua`).
- **opencode**: Node-based. Custom skills in `opencode/skills/` (caveman, find-skills). Own `opencode/AGENTS.md`.
- **aerospace**: Gaps with top-only outer gap (30). Flatten + opposite-orientation normalization. Mouse follows focus. Service mode (alt-;) with volume, reset, floating.
- **.gitignore**: `nvim/pack/github/start/`, `nvim/lazy-lock.json`, `github-copilot/`, `raycast/extensions/`, `simple-update-notifier/`, `tmux/plugins/`, `visidata/__pycache__`.

## Testing

No test framework. Config changes verified manually by reloading the tool:
- **tmux**: prefix + `r` or `source-file ~/.config/tmux/tmux.conf`
- **aerospace**: enters service mode with `alt-; r` to reload-config
- **sketchybar**: `sketchybar --reload`
- **nvim**: `:Lazy! sync` then `:Lazy! check` for plugin updates; `:LuaCacheClear` if needed
- **No CI/CD** — repo pushed to GitHub manually.

## Git Workflow

- **Branch**: `master` only — all commits direct
- **Remote**: `origin git@github.com:kaleem-peeroo/dotfiles.git`
- **Commit style**: `<tool-name>: <imperative-description>`. Single-line, no body. No tags/releases.
- **257 commits** spanning ~2 years. Earliest: nvim/tmux setup. Recent: sketchybar active dev.
- **Push**: Direct to `origin/master`. No PR workflow.
