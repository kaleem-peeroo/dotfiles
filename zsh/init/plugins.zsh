ZSH_THEME=""

zstyle ':omz:update' mode auto
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd/mm/yyyy"
plugins=(git fzf-tab)
source $ZSH/oh-my-zsh.sh

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"
