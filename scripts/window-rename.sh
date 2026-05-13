#!/usr/bin/env bash
# Source this file in your .zshrc / .bashrc to enable automatic tmux window
# renaming when you change branches:
#
#   source ~/.tmux/plugins/stax.tmux/scripts/window-rename.sh

__stax_tmux_window_rename() {
  [ -z "$TMUX" ] && return
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return
  [ "$branch" = "HEAD" ] && return  # detached HEAD — skip
  tmux rename-window "$branch" 2>/dev/null
}

if [ -n "$ZSH_VERSION" ]; then
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd __stax_tmux_window_rename
elif [ -n "$BASH_VERSION" ]; then
  PROMPT_COMMAND="__stax_tmux_window_rename${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
fi
