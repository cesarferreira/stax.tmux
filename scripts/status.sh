#!/usr/bin/env bash
BRANCH_ICON=$'\xef\x90\x98'
if [ -f /tmp/stax-status ]; then
    printf '%s' "$(cat /tmp/stax-status)"
    exit 0
fi
output=$(stax tmux status 2>/dev/null)
if [ -n "$output" ]; then
    printf '%s %s' "$BRANCH_ICON" "$output"
else
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [ -n "$branch" ] && printf '%s %s' "$BRANCH_ICON" "$branch"
fi
