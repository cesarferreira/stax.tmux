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
sync_key="$(tmux show-option -gqv '@stax-sync-key')"
sync_key="${sync_key:-M-s}"

# Register keybindings only if the key is non-empty
[ -n "$popup_key" ] && tmux bind-key "$popup_key" \
  display-popup -E -w 80% -h 80% 'stax watch --current'
[ -n "$up_key" ] && tmux bind-key "$up_key" \
  run-shell 'stax up > /dev/null 2>&1 || true'
[ -n "$down_key" ] && tmux bind-key "$down_key" \
  run-shell 'stax down > /dev/null 2>&1 || true'
[ -n "$sync_key" ] && tmux bind-key "$sync_key" \
  run-shell 'stax sync > /dev/null 2>&1 || true'

# Status bar: call stax tmux status every status-interval seconds
tmux set-option -g status-interval 5
tmux set-option -g status-right "#($CURRENT_DIR/scripts/status.sh)  %H:%M"
