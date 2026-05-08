# Interactive shell tools safe to sync publicly.

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --cmd j)"
fi

if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh)"
fi

# Yazi wrapper: quit with `q` to sync the shell CWD, or `Q` to keep it unchanged.
function y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")" || return 1
  command yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp" 2>/dev/null)" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && [ -d "$cwd" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Warp-like history completion for zsh.
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
