if [[ -n $__ZSH_CONFIG_LOADED ]]; then
  return
fi
typeset -r __ZSH_CONFIG_LOADED=1

source $HOME/.config/zsh/init/env.zsh
source $HOME/.config/zsh/init/path.zsh
source $HOME/.config/zsh/init/plugins.zsh
source $HOME/.config/zsh/functions/nvm-lazy.zsh
source $HOME/.config/zsh/init/completions.zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
source $HOME/.config/zsh/aliases/main.zsh
source $HOME/.config/zsh/keybindings/main.zsh
source $HOME/.config/zsh/config/main.zsh
