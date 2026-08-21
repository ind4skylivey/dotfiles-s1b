# Shell module

Portable **zsh** and **fish** configs for `minimal` / `workstation` / `developer`. They are **new files**, not the repo-root dump.

## Not included (on purpose)

- Offensive aliases (`kali`, `metasploit`, privileged podman)
- Hardcoded `/home/il1v3y`, `/media/il1v3y`, `/tmp/.tmp*` prism
- CachyOS-only `source /usr/share/cachyos-*` (optional later)
- Auto `ssh-add` of a named key
- The `.config/zsh/` Zsh 5.9 completions tree

Host extras go in `~/.config/zsh/local.zsh` or `~/.config/fish/local.fish` (not git).

## Files

| Repo path | Intended dest |
|---|---|
| `modules/shell/home/.zshrc` | `~/.zshrc` |
| `modules/shell/home/.config/fish/config.fish` | `~/.config/fish/config.fish` |

## Dry-run

```bash
./install.sh --dry-run --profile minimal
```

This prints `[link]` lines. It does **not** change `$HOME`.

To link later (after backup), use the per-path linker — not root stow:

```bash
./scripts/link.sh --dry-run modules/shell/home/.zshrc .zshrc
```

Do not point this at the live dump until you have a backup and want to switch.
