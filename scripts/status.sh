#!/usr/bin/env bash
BRANCH_ICON=$'\xef\x90\x98'
DIM='#[fg=colour244]'
RESET='#[default]'
if [ -f /tmp/stax-status ]; then
    printf '%s' "$(cat /tmp/stax-status)"
    exit 0
fi
output=$(stax tmux status 2>/dev/null)
if [ -n "$output" ]; then
    printf '%s%s%s%s' "$DIM" "$BRANCH_ICON" "$output" "$RESET"
else
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [ -n "$branch" ] && printf '%s%s%s%s' "$DIM" "$BRANCH_ICON" "$branch" "$RESET"
fi
