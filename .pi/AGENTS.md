# AGENTS.md

## Project Overview

**Dotfiles** — personal macOS configuration managed as a git repository at `~/.config/`. Remote: `git@github.com:kaleem-peeroo/dotfiles.git` (branch: `master`).

Tech stack: pure config files — no build system, no runtime dependencies. Configs in TOML, Lua, shell, JSON, YAML, and INI.

Tools configured:
- **Shell**: zsh (`.zshrc`, oh-my-zsh, powerlevel10k, zoxide, fzf)
- **Terminals**: alacritty, kitty, wezterm, iterm2
- **Window manager**: aerospace (macOS tiling WM, alt-modifier keybindings)
- **Menu bar**: sketchybar with 17 custom shell plugins
- **Editor**: nvim (lua/), lazy.nvim, 40+ plugin configs, 12 themes
- **Terminal multiplexer**: tmux (tpm, 8 plugins, C-a prefix)
- **AI coding**: opencode (pi-coding-agent at `opencode/` with custom skills)
- **File manager**: yazi (TUI with zoom plugin)
- **Data browser**: visidata (Python config, custom aggregators)
- **Others**: lazygit, ncspot, qBittorrent, zathura, raycast, iina, wandb

**Scale**: ~11,900 total lines across config files. Most actively maintained: sketchybar (10/30 recent commits), tmux (4), nvim (3)

## Directory Structure

```
aerospace/           — AeroSpace tiling WM config (aerospace.toml)
alacritty/           — Alacritty terminal config + themes/
cagent/              — Config for cagent
gh/                  — GitHub CLI config (config.yml, hosts.yml)
kitty/               — Kitty terminal config
lazygit/             — Lazygit TUI config
ncspot/              — Spotify TUI client config
nvim/                — Neovim config (~280 lines)
  init.lua           — Entry point, lazy.nvim bootstrap
  lua/
    options.lua      — Vim options
    keymaps.lua      — Key mappings
    plugins/         — 40+ per-plugin config files
    themes/          — 12 color themes
nvim/pack/github/    — Legacy vim-pack plugin dir (just copilot.vim)
opencode/            — pi-coding-agent config (opencode.json, package.json)
  skills/            — Custom agent skills (caveman, find-skills)
sketchybar/          — macOS menu bar config (~200 lines)
  colors.sh          — 8 color scheme presets (teal, gray, purple, red, blue, green, orange, yellow)
  sketchybarrc       — Main bar config (items, layout, styling)
  plugins/           — 17 widget plugins (aerospace, battery, cpu, discord, network, spotify, etc.)
tmux/                — Tmux config + tpm plugins/ (8 plugins: yank, navigator, battery, cpu, network, continuum, resurrect, sessionx)
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
ga         # git add
gcl        # git clone
lg         # lazygit

# Config reload commands
tmux: source-file ~/.config/tmux/tmux.conf  # or prefix + r
sketchybar: sketchybar --reload
aerospace: reload-config via mode service (alt-; then r)
nvim: :Lazy! sync; :Lazy! check

# Terminal multiplexer
tmn <name>  # tmux new -s
tma <name>  # tmux attach-session -t
tmls        # tmux ls
tmkill      # tmux kill-session -t

# Other aliases found in .zshrc
v           # nvim
c           # cargo
sc          # source
py          # python3
m           # make
mt          # make test
mr          # make run
mp          # multipass
vd          # visidata with custom config
```

## Code Style & Conventions

- **Commit messages**: `<tool-name>: <description>` format. Lowercase after colon, present/past tense both used. Single-line only, no body. Examples:
  ```
  sketchybar: reorderded network and discord indicators
  nvim: disable copilot, fix neotest python path, fix obsidian vault path
  tmux: updated extended keys to work with csi-u for pi
  zshrc: Added PI_CODING_AGENT_DIR config dir
  ```
- **Most active tools in git history**: sketchybar (10 commits), tmux (4), nvim (3), opencode (2), zshrc (2)
- **zshrc**: Aliases grouped with `# ? SECTION` comments. Uses `export` for env vars. `eval "$(...)"` for shell integrations. vi mode via `bindkey -v` (commented out). Uses oh-my-zsh with `zstyle ':omz:update' mode auto`.
- **nvim**: Plugin configs in `lua/plugins/<name>.lua`. One file per plugin. Themes in `lua/themes/`. Uses lazy.nvim with `{ import = "plugins" }` and `{ import = "themes" }`.
- **sketchybar**: Shell-based. Colors as hex `0xffRRGGBB` in `colors.sh`. Schemes are block-commented, active one uncommented. 8 presets. Currently Purple Scheme.
- **aerospace**: TOML. All keybindings use `alt` modifier. Named workspaces (obsidian, email, spotify). Vim-style hjkl navigation. Service mode (alt-;) for advanced ops.
- **tmux**: Prefix is `C-a` (not default `C-b`). vim copy mode. Extended keys in csi-u format. Status bar at bottom with battery, RAM, network, CPU indicators. Catppuccin mocha colors.
- **visidata**: Python config. Imports custom modules (dedupe, confidence_intervals). Custom aggregators (`mean_ci95`).
- **No Makefile, package.json (except opencode), or build tooling.**

## Architecture Notes

- **`~/.config` IS the git repo** — files are directly at `~/.config/<tool>/`. The `.zshrc` is copied into the repo via `sync_zshrc` alias (it lives at `~/.zshrc` but gets synced to `~/.config/.zshrc`). Only 3 top-level files: `.zshrc`, `.inputrc`, `.gitignore`.
- **sketchybar ↔ aerospace integration**: Workspace changes trigger `exec-on-workspace-change` in aerospace which fires `aerospace_workspace_change` event to sketchybar. The `space.sh` plugin and `aerospace.sh` plugin handle display. Borders also integrated via `after-startup-command`. This is the key cross-tool integration — changing one likely requires updating the other.
- **nvim** uses lazy.nvim with auto-import — adding a new plugin config to `lua/plugins/` or theme to `lua/themes/` auto-loads it. Copilot is dual-configured: `copilot_cmp.lua` + `zbirenbaum_copilot.lua` for completions, plus legacy `pack/github/start/copilot.vim`.
- **tmux ↔ nvim integration**: vim-tmux-navigator installed in both tmux (via tpm) and nvim (separate `lua/plugins/vim-tmux-navigator.lua`). Enables seamless pane navigation between nvim and tmux panes.
- **opencode** (pi-coding-agent): Node-based runtime. Custom skills in `opencode/skills/` (caveman, find-skills). Has its own `opencode/AGENTS.md`.
- **Color scheme system**: 8 complete presets (teal, gray, purple, red, blue, green, orange, yellow) in `sketchybar/colors.sh`. Only one active at a time via comment toggling. Currently Purple: `0xff140c42` / `0xff2b1c84` / `0xffeb46f9`.
- **aerospace**: Gaps with top-only outer gap (30). Normalization flatten + opposite-orientation enabled. Mouse follows focus on monitor and window change. Service mode (alt-;) with volume controls, reset layout, floating toggle.
- **.gitignore** full list: `nvim/pack/github/start/`, `nvim/lazy-lock.json`, `github-copilot/`, `raycast/extensions/`, `simple-update-notifier/`, `tmux/plugins/`, `visidata/__pycache__`.

## Testing

No test framework. Config changes verified manually by reloading the tool:
- **tmux**: prefix + `r` or `source-file ~/.config/tmux/tmux.conf`
- **aerospace**: enters service mode with `alt-; r` to reload-config
- **sketchybar**: `sketchybar --reload`
- **nvim**: `:Lazy! sync` then `:Lazy! check` for plugin updates; `:LuaCacheClear` if needed
- **No CI/CD** — repo pushed to GitHub manually.

## Git Workflow

- **Branch**: `master` only (no feature branches — all commits direct to master)
- **Remote**: `origin git@github.com:kaleem-peeroo/dotfiles.git`
- **Commit style**: `<tool-name>: <imperative-description>`. Single-line only, no body. No tags, no releases.
- **30 commits on master** (repo spans ~2 years). Earliest commits show opencode setup, recent commits focus on sketchybar (most active).
- **Push pattern**: Direct to `origin/master`. No PR workflow.
