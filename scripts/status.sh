#!/usr/bin/env bash
if [ -f /tmp/stax-status ]; then
    printf '%s' "$(cat /tmp/stax-status)"
    exit 0
fi
output=$(stax tmux status 2>/dev/null)
if [ -n "$output" ]; then
    printf '%s' "$output"
else
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [ -n "$branch" ] && printf '⎇ %s' "$branch"
fi
