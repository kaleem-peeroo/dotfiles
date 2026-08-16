#!/bin/bash

detect_machine() {
  local computer_name="${1:-$(scutil --get ComputerName 2>/dev/null)}"
  case "$computer_name" in
    *MacBook*) printf '%s\n' macbook ;;
    *)         printf '%s\n' macmini ;;
  esac
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  detect_machine
fi
