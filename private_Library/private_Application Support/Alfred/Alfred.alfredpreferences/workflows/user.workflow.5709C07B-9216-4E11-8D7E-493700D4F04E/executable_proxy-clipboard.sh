#!/bin/zsh

set -euo pipefail

readonly HTTP_PROXY_URL="http://127.0.0.1:7897"
readonly ALL_PROXY_URL="socks5://127.0.0.1:7897"

usage() {
  print -u2 -- "Usage: $0 [on|off]"
}

normalize_action() {
  local raw_action="${1:-}"

  case "${raw_action:l}" in
    on|enable|open)
      print -- "on"
      ;;
    off|disable|close|unset)
      print -- "off"
      ;;
    *)
      return 1
      ;;
  esac
}

build_command() {
  local action="$1"

  case "$action" in
    on)
      print -- "export http_proxy=$HTTP_PROXY_URL https_proxy=$HTTP_PROXY_URL all_proxy=$ALL_PROXY_URL HTTP_PROXY=$HTTP_PROXY_URL HTTPS_PROXY=$HTTP_PROXY_URL ALL_PROXY=$ALL_PROXY_URL"
      ;;
    off)
      print -- "unset http_proxy https_proxy all_proxy HTTP_PROXY HTTPS_PROXY ALL_PROXY"
      ;;
    *)
      return 1
      ;;
  esac
}

copy_to_clipboard() {
  local command="$1"
  printf '%s' "$command" | pbcopy
}

notify() {
  local title="$1"
  local message="$2"

  /usr/bin/osascript - "$title" "$message" <<'APPLESCRIPT' || true
on run argv
	display notification (item 2 of argv) with title (item 1 of argv)
end run
APPLESCRIPT
}

main() {
  local action
  local command

  action="$(normalize_action "${1:-}")" || {
    usage
    return 1
  }

  command="$(build_command "$action")"
  copy_to_clipboard "$command"

  if [[ "$action" == "on" ]]; then
    notify "Proxy Command Ready" "已复制代理开启命令到剪贴板"
  else
    notify "Proxy Command Ready" "已复制代理关闭命令到剪贴板"
  fi
}

main "$@"
