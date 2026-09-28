alias ls="eza --icons=always -a --hyperlink"
alias g="git"
alias sc="source"
alias py="python3"
alias e="exit"
alias v="nvim"
alias m="make"
alias mt="make t"
alias mr="make run"
alias cr="cargo run"
alias mp="multipass"
alias lg="lazygit"
alias pi='NODE_NO_WARNINGS=1 pi'
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias scvenv='source ~/venv/bin/activate'
alias confnvim='nvim ~/.config/nvim/'
alias reload="unset __ZSH_CONFIG_LOADED && exec zsh"
alias sync_zshrc="cp ~/.zshrc ~/.config/.zshrc"

alias ..="cd .."
alias ...="cd ../.."
alias home="cd ~"

alias gpull="git pull"
alias gpush="git push"
alias diffw="git diff --color-words='[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+'"
alias gs="git status"
alias gcl="git clone"
alias ga="git add"
alias gc="git commit -m"
alias gl="git log"

alias sshgrid="ssh grid"
alias get_grid_files="scp -r kpeeroo@access.grid5000.fr:/home/kpeeroo/nancy/\*.csv ."

alias tmn='tmux new -s'
alias tmls='tmux ls'
alias tmkill='tmux kill-session -t'
alias tma='tmux attach-session -t'

alias hd="herdr"

alias apm="cd ~/AutoPerf/; source .venv/bin/activate; ./bash_scripts/monitor.sh"
alias apd="cd ~/AutoPerf/; source .venv/bin/activate; ./bash_scripts/download.sh"
alias apl="cd ~/AutoPerf/; source .venv/bin/activate; ./bash_scripts/logs.sh"
alias ape="cd ~/AutoPerf/; source .venv/bin/activate; ./bash_scripts/ess.sh"

alias firstmate='~/.config/zsh/scripts/firstmate-up.sh'
#
# Claude CLI top-10 sessions by USD cost
alias claude-top-costs="grep -h '\"totalCostUSD\"' ~/.claude/projects/*/*.jsonl 2>/dev/null \
  | jq -r '[.sessionId, (.totalCostUSD | \"$\" + (.*100 | round / 100 | tostring)), (.modelUsage | to_entries | map(.value.cacheReadInputTokens // 0) | add // 0)] | @tsv' \
  | sort -t$'\t' -k2,2 -nr \
  | head -n 10 \
  | awk 'BEGIN { print \"SESSION_ID\tCOST_USD\tCACHE_READ_TOKENS\" } { print }' \
  | column -ts $'\t'"
