# Ctrl-F: fuzzy-yank a word from the last command's output.
#
# Stage 1: re-run the last command, pipe its output through fzf, pick a line.
# Stage 2: pipe that line's words through fzf, pick a word.
# The chosen word is appended to the buffer at the cursor.
#
# Commands matching _zsh_yank_denylist are never re-run (they may be
# destructive, interactive, or paginated).

_zsh_yank_denylist=(
  rm mv sudo docker\ rm docker\ rmi git\ push git\ clean ssh scp rsync dd
  mkfs fdisk kill pkill shutdown reboot systemctl brew\ uninstall npm\ publish
  vim vi nano less more top htop man git\ log git\ diff git\ show
)

_zsh_yank_is_blocked() {
  local cmd=$1
  [[ -n $cmd ]] || return 1
  local pat
  for pat in "${_zsh_yank_denylist[@]}"; do
    [[ "$cmd" == "$pat"* ]] && return 0
  done
  return 1
}

_zsh_yank_last_command() {
  fc -ln -1 2>/dev/null
}

_zsh_yank_capture() {
  eval -- "$1" </dev/null 2>/dev/null
}

_zsh_yank_pick() {
  local -a items=("$@")
  (( ${#items} )) || return 1
  print -rl -- "${items[@]}" | fzf --height 40% --reverse
}

_zsh_yank_select_word() {
  local cmd=${1:-$(_zsh_yank_last_command)} line word
  local -a lines words

  [[ -n $cmd ]] || return 1
  _zsh_yank_is_blocked "$cmd" && return 0

  lines=("${(@f)$(_zsh_yank_capture "$cmd")}")
  line=$(_zsh_yank_pick "${lines[@]}") || return 1
  [[ -n $line ]] || return 0

  words=("${(z)line}")
  word=$(_zsh_yank_pick "${words[@]}") || return 1
  [[ -n $word ]] || return 0

  print -r -- "$word"
}

if [[ -o zle ]]; then
  function _zsh_yank() {
    LBUFFER+="$(_zsh_yank_select_word)"
    zle reset-prompt
  }
  zle -N _zsh_yank
fi
