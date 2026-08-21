# Editor module

Portable **Neovim** for `minimal` / `workstation` / `developer`. A small `init.lua`, **not** the dump under `.config/nvim` (NvChad, Valet maps, one-machine logs).

## Not included (on purpose)

- Plugin managers and LSP stacks
- `/home/il1v3y` or `/Users/il1v3y` Valet path maps
- `INSTALLATION-LOG.txt` / setup markdown from the dump

Host extras: copy `modules/editor/local.lua.example` → `~/.config/nvim/local.lua`.

## Files

| Repo path | Intended dest |
|---|---|
| `modules/editor/home/.config/nvim/init.lua` | `~/.config/nvim/init.lua` |

Linking this later **replaces** a live `~/.config/nvim/init.lua`. Backup first. The dump tree stays in git until a later cleanup.

## Dry-run

```bash
./install.sh --dry-run --profile minimal
```
