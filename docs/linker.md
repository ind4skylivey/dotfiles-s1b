# Linker

Per-path symlinks. **Not GNU Stow.** The repo root is never linked as a tree.

## Why

Root `stow .` would put `docs/`, `.github/`, and `assets/` into `$HOME`, and `sed -i` on a stow-linked dest mutates git (audit C-03).

## Commands

```bash
./scripts/link.sh SRC DEST
./scripts/link.sh --dry-run SRC DEST
./scripts/link.sh --status DEST
./install.sh --link SRC DEST
./install.sh --dry-run --link SRC DEST
```

`SRC` is inside this repository (absolute or repo-relative).  
`DEST` is under `$HOME` (or `DOTFILES_LINK_HOME` in tests).

## Behavior

| Destination | Action |
|---|---|
| Missing | `mkdir -p` parent, `ln -s` to the absolute repo path |
| Already the correct symlink | no-op |
| Regular file or wrong symlink | copy-only backup, `rm` dest only, then link |
| Real directory | refuse (no `rm -rf`) |
| Path inside the repo | refuse |

Dry-run logs and writes nothing. Replacing dest never follows an existing symlink (it does not `sed` the repo).

No module links are declared yet. Do not point this at the live `.config/` tree until a module is migrated.

Example format for later manifests (`config/links.example.tsv`):

```
# src (repo-relative)	dest (home-relative)
```
