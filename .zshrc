source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# export ZSH_THEME="powerlevel10k/powerlevel10k"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

zstyle ':omz:update' mode auto      # update automatically without asking
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="dd/mm/yyyy"

plugins=(
    git
)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

PATH="/Users/kaleem/chktex-1.7.8:${PATH}"
PATH="/usr/local/mysql/bin:${PATH}"
PATH="/Library/TeX/texbin:${PATH}"
PATH="/opt/homebrew/bin:${PATH}"
PATH="/opt/homebrew/bin/python3:${PATH}"
export PATH

# alias ls="ls -alh --color=always"
alias ls="eza --icons=always -a --hyperlink"
alias g="git"
alias sc="source"
alias py="python3"
alias ..="cd .."
alias ...="cd ../.."
alias home="cd ~"
alias e="exit"
alias lg="lazygit"

export _3pk1=10.210.44.247
export _5pk1=10.210.55.24

alias 3pi="$_3pk1"
alias 5pi="$_5pk1"
 
alias ssh3pi="ssh acwh025@3pk1"
alias ssh5pi="ssh acwh025@5pk1"

alias sshros="ssh city@10.210.8.178"

export nbip=10.210.8.178
alias sshnb="ssh city@$nbip"

# AutoPerf Scripts
# AP Monitor
alias apm="cd ~/AutoPerf/; source .venv/bin/activate; ./bash_scripts/monitor.sh"
# AP Downloader
alias apd="cd ~/AutoPerf/; source .venv/bin/activate; ./bash_scripts/download.sh"
# AP Logs Downloader
alias apl="cd ~/AutoPerf/; source .venv/bin/activate; ./bash_scripts/logs.sh"
# AP ESS Downloader
alias ape="cd ~/AutoPerf/; source .venv/bin/activate; ./bash_scripts/ess.sh"

export vps=51.195.222.194
alias sshvps="ssh ubuntu@$vps"

export nato_drone="192.168.1.107"
alias sshdrone="ssh sapience@192.168.1.107"

# ? Grid5000
alias sshgrid="ssh kpeeroo@access.grid5000.fr"
alias get_grid_files="scp -r kpeeroo@access.grid5000.fr:/home/kpeeroo/nancy/\*.csv ."

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

# ? AI Aware Server
alias sshcc="ssh root@82.165.200.179"

# ? TMUX Aliases
alias tmn='tmux new -s'
alias tmls='tmux ls'
alias tmkill='tmux kill-session -t'
alias tma='tmux attach-session -t'

alias sync_zshrc="cp ~/.zshrc ~/.config/.zshrc;"

alias scvenv='source ~/venv/bin/activate'

# nvim aliases
alias confnvim='nvim ~/.config/nvim/'

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 

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

