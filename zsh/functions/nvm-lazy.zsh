_nvm_lazy_load() {
  local cmds=(nvm node npm npx ng)
  for cmd in $cmds; do
    eval "
    $cmd() {
      unset -f nvm node npm npx ng
      [ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\"
      $cmd \"\$@\"
    }
    "
  done
}
_nvm_lazy_load
