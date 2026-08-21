# Backup and restore

Backups are copy-only. User data is never deleted automatically.

## Location

```
${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/backups/
```

Override with `DOTFILES_BACKUP_ROOT` (used by tests).

Each session:

```
backups/
└── 2026-08-21T185600Z/
    ├── manifest.json
    ├── checksums.sha256
    ├── restore.tsv
    ├── restore.sh
    └── files/
```

## Commands

```bash
./install.sh --backup                 # show root and existing ids
./scripts/backup.sh PATH [PATH...]    # snapshot paths (missing paths are recorded)
./restore.sh --list
./restore.sh --latest
./restore.sh --backup-id ID
./restore.sh --dry-run --latest
```

Dry-run logs actions and writes nothing.

## Behavior

| Source | What is stored |
|---|---|
| Regular file | Copy with permissions (`cp -a`) + sha256 |
| Symlink | Link target string (the symlink is not followed) |
| Directory | Full tree copy; restore refuses to merge into an existing directory |
| Missing | Recorded as `missing`; restore does not create or delete |

If the destination exists as a **different type** (file vs symlink vs directory), restore skips that path instead of replacing it.

Rollback restores the active session created by `dotfiles_backup_begin`.
