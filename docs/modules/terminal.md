# Terminal module

Portable **kitty** and **alacritty** for `workstation` / `developer` / `full`. New files, not the dump under `modules/kitty/` or `modules/alacritty/`.

## Not included (on purpose)

- Cyberpunk / Nordic theme files
- Meslo / Nerd Font pins (host overlay)
- Dump cheatsheets

Copy `modules/kitty/local.kitty.example` → `~/.config/kitty/local.conf` and uncomment `include local.conf` if you want a host font.

## Files

| Repo path | Intended dest |
|---|---|
| `modules/kitty/home/.config/kitty/kitty.conf` | `~/.config/kitty/kitty.conf` |
| `modules/alacritty/home/.config/alacritty/alacritty.toml` | `~/.config/alacritty/alacritty.toml` |

## Dry-run

```bash
./install.sh --dry-run --profile workstation
```

`minimal` plans shell, git, and editor only. Do not link over a live terminal config until you have a backup.
