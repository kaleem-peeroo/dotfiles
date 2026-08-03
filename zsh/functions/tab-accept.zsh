# Tab: accept the grey autosuggestion when visible, otherwise fall back to
# fzf-tab completion. Mirrors the yank-output widget pattern.

_zsh_tab_accept_action() {
  [[ -n $POSTDISPLAY && $CURSOR -eq $#BUFFER ]]
}

_zsh_tab_accept() {
  if _zsh_tab_accept_action; then
    zle autosuggest-accept
  else
    zle fzf-tab-complete
  fi
}

if [[ -o zle ]]; then
  zle -N _zsh_tab_accept
fi
