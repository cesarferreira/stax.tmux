#!/usr/bin/env bash
# stax.tmux — TPM plugin for stax (https://github.com/cesarferreira/stax)
# Install via TPM: set -g @plugin 'cesarferreira/stax.tmux'

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Read configurable key bindings (empty string disables the binding)
popup_key="$(tmux show-option -gqv '@stax-popup-key')"
popup_key="${popup_key:-S}"
up_key="$(tmux show-option -gqv '@stax-up-key')"
up_key="${up_key:-]}"
down_key="$(tmux show-option -gqv '@stax-down-key')"
down_key="${down_key:-[}"
rs_key="$(tmux show-option -gqv '@stax-rs-key')"
rs_key="${rs_key:-M-r}"

# Bind a key: M- keys are bound without prefix (-n), others require prefix
bind_key() {
  local key="$1"; shift
  case "$key" in
    M-*) tmux bind-key -n "$key" "$@" ;;
    *)   tmux bind-key    "$key" "$@" ;;
  esac
}

# Register keybindings only if the key is non-empty
[ -n "$popup_key" ] && bind_key "$popup_key" \
  display-popup -E -w 80% -h 80% 'stax watch --current'
[ -n "$up_key" ] && bind_key "$up_key" \
  run-shell -b 'printf "⬆ moving up..." > /tmp/stax-status && tmux refresh-client -S; stax up > /dev/null 2>&1 || true; rm -f /tmp/stax-status && tmux refresh-client -S'
[ -n "$down_key" ] && bind_key "$down_key" \
  run-shell -b 'printf "⬇ moving down..." > /tmp/stax-status && tmux refresh-client -S; stax down > /dev/null 2>&1 || true; rm -f /tmp/stax-status && tmux refresh-client -S'
[ -n "$rs_key" ] && bind_key "$rs_key" \
  run-shell -b 'printf "⟳ syncing..." > /tmp/stax-status && tmux refresh-client -S; stax rs > /dev/null 2>&1 || true; rm -f /tmp/stax-status && tmux refresh-client -S'

# Status bar: call stax tmux status every status-interval seconds
tmux set-option -g status-interval 5
tmux set-option -g status-right "#($CURRENT_DIR/scripts/status.sh)  %H:%M"
