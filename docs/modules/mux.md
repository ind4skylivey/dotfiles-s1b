# Mux module

Portable **tmux** and **zellij** for `workstation` / `developer` / `full`. New files, not the dump.

## Not included (on purpose)

- `default-shell /usr/bin/fish` (dump tmux forced Fish even if login was zsh)
- TPM plugin clones
- Zellij layouts from `workflow/` or another user's `~/.config`
- Host path comments from the dump KDL

Host extras: copy `modules/mux/local.tmux.example` → `~/.config/tmux/local.conf`.

## Files

| Repo path | Intended dest |
|---|---|
| `modules/mux/home/.config/tmux/tmux.conf` | `~/.config/tmux/tmux.conf` |
| `modules/mux/home/.config/zellij/config.kdl` | `~/.config/zellij/config.kdl` |

## Dry-run

```bash
./install.sh --dry-run --profile workstation
```

Do not link this over a live mux config until you have a backup.
