# Git module

Portable Git **defaults**. There was no `.gitconfig` in this repo before.

## Not included (on purpose)

- `user.name` / `user.email` / `user.signingkey`
- Tokens, `credential.helper` secrets
- `init.templatedir` pointing at Claude Code hooks (audit S-05)

Identity goes in **`~/.config/git/local`** (copy `modules/git/local.example`). The portable config `[include] path = local` relative to `~/.config/git/config`.

## Files

| Repo path | Intended dest |
|---|---|
| `modules/git/home/.config/git/config` | `~/.config/git/config` |
| `modules/git/home/.config/git/ignore` | `~/.config/git/ignore` |

Git 2.x reads XDG config; we do **not** also link `~/.gitconfig`.

## Dry-run

```bash
./install.sh --dry-run --profile minimal
```

Do not link this over a live config until you have a backup.
