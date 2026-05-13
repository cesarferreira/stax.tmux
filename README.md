# stax.tmux

> A [TPM](https://github.com/tmux-plugins/tpm) plugin for [stax](https://github.com/cesarferreira/stax) — live stack status in your status bar, keybindings for stack navigation, and automatic window rename on branch checkout.

```
 feat/login-flow [3/5] #42  ● passing  14:22
```

---

## Features

- **Status bar** — shows current branch, stack position, PR number, and CI state, live in your tmux status line
- **Keybindings** — navigate your stack, open a popup, and sync without leaving tmux
- **Window rename** — tmux window title follows your current branch automatically

---

## Requirements

- [stax](https://github.com/cesarferreira/stax) installed and on `$PATH`
- tmux 3.2+
- [TPM](https://github.com/tmux-plugins/tpm) (for managed install)

---

## Installation

### With TPM (recommended)

Add to `~/.tmux.conf`:

```tmux
set -g @plugin 'cesarferreira/stax.tmux'
```

Then press `prefix + I` to install.

### Manual

```bash
git clone https://github.com/cesarferreira/stax.tmux ~/.tmux/plugins/stax.tmux
```

Add to `~/.tmux.conf`:

```tmux
run '~/.tmux/plugins/stax.tmux/stax.tmux'
```

Then reload: `tmux source ~/.tmux.conf`

---

## Status Bar

The plugin sets `status-right` to display:

```
 feat/login-flow [3/5] #42  ● passing  14:22
```

| Field | Example | Meaning |
|-------|---------|---------|
| Branch | `feat/login-flow` | Current branch (truncated at 50 chars) |
| Position | `[3/5]` | 3rd branch in a 5-deep stack |
| PR | `#42` | Open PR · `#42 draft` · `#42 merged` · `⊘` (no PR) |
| CI | `● passing` | `● passing` · `✗ failing` · `⟳ running` · `– no CI` |

Status refreshes every 5 seconds (configurable via `status-interval`). Reads from stax's local CI cache — no live GitHub API call on each tick. When the cache is older than 90 seconds, a background `stax ci` is spawned automatically so CI and PR draft state stay current. Shows nothing when on trunk or outside a stax repo.

---

## Keybindings

| Binding | Action |
|---------|--------|
| `prefix + S` | Open stack popup (`stax watch --current` in a floating panel) |
| `prefix + ]` | `stax down` — move toward trunk |
| `prefix + [` | `stax up` — move away from trunk |
| `prefix + M-s` | `stax sync` — sync trunk and clean merged branches |

### Customising keys

Set options **before** the plugin loads:

```tmux
set -g @stax-popup-key 'S'     # default: S
set -g @stax-up-key ']'        # default: ]
set -g @stax-down-key '['      # default: [
set -g @stax-sync-key 'M-s'    # default: M-s

set -g @plugin 'cesarferreira/stax.tmux'
```

Set any key to `''` to disable that binding:

```tmux
set -g @stax-sync-key ''       # disables the sync binding
```

---

## Window Auto-Rename

Makes the tmux window title follow the current git branch after every command.

Add to `~/.zshrc` or `~/.bashrc`:

```bash
source ~/.tmux/plugins/stax.tmux/scripts/window-rename.sh
```

Then open a new terminal or run `source ~/.zshrc`. Windows rename automatically when you run `stax checkout`, `stax up`, `stax down`, etc.

Works with both zsh (`precmd` hook) and bash (`PROMPT_COMMAND`). No-op outside tmux or on a detached HEAD.

---

## Keeping your existing status-right

If you already have a custom `status-right`, the plugin will overwrite it. To preserve your content, set your own `status-right` after the plugin loads:

```tmux
run '~/.tmux/plugins/stax.tmux/stax.tmux'
set -g status-right "#(~/.tmux/plugins/stax.tmux/scripts/status.sh)  │  %H:%M"
```

---

## Related

- [stax](https://github.com/cesarferreira/stax) — the CLI this plugin wraps
- [TPM](https://github.com/tmux-plugins/tpm) — Tmux Plugin Manager
