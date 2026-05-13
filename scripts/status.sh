#!/usr/bin/env bash
output=$(stax tmux status 2>/dev/null)
if [ -n "$output" ]; then
    printf '%s' "$output"
else
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [ -n "$branch" ] && printf '⎇ %s' "$branch"
fi
