# stax.tmux

A [TPM](https://github.com/tmux-plugins/tpm) plugin for [stax](https://github.com/cesarferreira/stax) — adds a live status bar segment, keybindings, and automatic window rename.

## Requirements

- [stax](https://github.com/cesarferreira/stax) installed and on `$PATH`
- tmux 3.0+
- [TPM](https://github.com/tmux-plugins/tpm)

## Installation

Add to `~/.tmux.conf`:

```tmux
set -g @plugin 'cesarferreira/stax.tmux'
```

Then install: `prefix + I`

## Status Bar

The plugin sets `status-right` to show:

```
feat/login-flow [3/5] #42  ● passing  14:22
```

Fields: branch name (truncated at 20 chars) · stack position · PR number · CI state.

## Keybindings

| Key | Action |
|-----|--------|
| `prefix + S` | Open stack popup (`stax watch --current`) |
| `prefix + ]` | `stax down` (toward trunk) |
| `prefix + [` | `stax up` (away from trunk) |
| `prefix + M-s` | `stax sync` |

Override any binding before loading the plugin:

```tmux
set -g @stax-popup-key 'S'    # set to '' to disable
set -g @stax-up-key ']'
set -g @stax-down-key '['
set -g @stax-sync-key 'M-s'
```

## Window Auto-Rename

To automatically rename the tmux window to the current branch name, add to your `~/.zshrc` or `~/.bashrc`:

```bash
source ~/.tmux/plugins/stax.tmux/scripts/window-rename.sh
```

The rename runs after every command prompt, updating when you change branches.
