eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval "$(omp completions zsh)"
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
source <(ng completion script)
