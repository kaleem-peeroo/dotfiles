# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

zstyle ':omz:update' mode auto      # update automatically without asking
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="dd/mm/yyyy"

plugins=(
    git
)
unset MAILCHECK

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

PATH="/Users/kaleem/chktex-1.7.8:${PATH}"
PATH="/usr/local/mysql/bin:${PATH}"
PATH="/Library/TeX/texbin:${PATH}"
PATH="/opt/homebrew/bin:${PATH}"
PATH="/opt/homebrew/bin/python3:${PATH}"
export PATH

export XDG_CONFIG_HOME="$HOME/.config"

# alias ls="ls -alh --color=always"
alias ls="eza --icons=always -a --hyperlink"
alias g="git"
alias sc="source"
alias py="python3"
alias ..="cd .."
alias ...="cd ../.."
alias home="cd ~"
alias e="exit"
alias q="exit"
alias lg="lazygit"

export _3pk1=10.210.44.247
export _5pk1=10.210.55.24

alias 3pi="$_3pk1"
alias 5pi="$_5pk1"
 
alias ssh3pi="ssh acwh025@3pk1"
alias ssh5pi="ssh acwh025@5pk1"

alias sshros="ssh city@10.210.8.178"

alias hpc="kitten ssh kaleempeeroo@mac-mini"

export nbip=10.210.8.178
alias sshnb="ssh city@$nbip"

# ? GIT
alias gpull="git pull"
alias gpush="git push"
alias diffw="git diff --color-words='[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+'"
alias gs="git status"
alias gcl="git clone"
alias ga="git add"
alias gc="git commit -m"
alias gl="git log"

alias v="nvim"

alias m="make"
alias mt="make test"
alias mr="make run"

alias mp="multipass"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# ? TMUX Aliases
alias tmn='tmux new -s'
alias tmls='tmux ls'
alias tmkill='tmux kill-session -t'
alias tma='tmux attach-session -t'

# ? Rust
alias c='cargo'

alias sync_zshrc="cp ~/.zshrc ~/.config/.zshrc;"

alias sv='source ~/venv/bin/activate'

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

alias vd="source ~/venv/bin/activate && visidata --config \"$XDG_CONFIG_HOME/visidata/config.py\""

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

bindkey '^\t' end-of-line

set -o ignoreeof

###########
# vi mode #
###########
bindkey -v
#
# bindkey '^j' vi-cmd-mode
# bindkey -M vicmd "^V" edit-command-line
#
# export KEYTIMEOUT=1
#
bindkey "^N" history-search-forward
bindkey "^P" history-search-backward
#
# autoload -U edit-command-line
# zle -N edit-command-line
# bindkey '^x' edit-command-line

# bindkey '^I' complete-word
bindkey '^I' autosuggest-accept

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias zathura="zathura --plugins-dir $(brew --prefix zathura-pdf-poppler)/lib/zathura"

# Local-only secrets (gitignored)
[ -f ~/.secrets/opencode.env ] && source ~/.secrets/opencode.env
