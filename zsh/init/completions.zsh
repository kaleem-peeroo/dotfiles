eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval "$(omp completions zsh)"
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
local _ng_bins=("$NVM_DIR"/versions/node/*/bin/ng(N))
if (( ${#_ng_bins} )); then
  source <(ng completion script)
fi

source $HOME/.config/zsh/functions/yank-output.zsh
source $HOME/.config/zsh/functions/tab-accept.zsh

# fzf-tab: show descriptions, colorize, disable menu so prefix is captured.
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -la --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z::' fzf-preview 'ls -la --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
