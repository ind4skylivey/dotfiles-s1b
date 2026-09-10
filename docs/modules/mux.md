# Mux module

Portable **tmux** and **zellij** for `workstation` / `developer` / `full`.

## Session workflow (tmux)

| Prefix | Action |
|--------|--------|
| `s` | Session tree sorted by last use |
| `b` | Toggle last session |
| `p` | Project picker (`projects.list` + browse `Repos/`) |
| `f` | Fuzzy switch by session name |
| `T` | sesh launcher + preview |
| `M` / `L` / `C` | Quick jumps (host: `local.conf`) |

Scripts: `modules/mux/home/.config/tmux/scripts/`.

## Host setup (once per machine)

```bash
cp modules/mux/local.tmux.example ~/.config/tmux/local.conf
cp modules/mux/mux-host.env.example ~/.config/tmux/mux-host.env
cp modules/mux/home/.config/tmux/projects.list.example ~/.config/tmux/projects.list
# Edit paths in local.conf, mux-host.env, and projects.list
```

Optional **sesh** for `Prefix T`: `GOBIN=~/.local/bin go install github.com/joshmedeski/sesh@v1.2.0`

## Not in the portable module

- `default-shell /usr/bin/fish` (use `local.conf`)
- Host paths (use `local.conf`, `mux-host.env`, `projects.list`)
- TPM clones under `~/.tmux/plugins/`

## Files

| Repo path | Dest |
|-----------|------|
| `modules/mux/home/.config/tmux/tmux.conf` | `~/.config/tmux/tmux.conf` |
| `modules/mux/home/.config/tmux/scripts/*.sh` | `~/.config/tmux/scripts/` |
| `modules/mux/home/.config/tmux/docs/*.md` | `~/.config/tmux/docs/` |
| `modules/mux/home/.config/zellij/config.kdl` | `~/.config/zellij/config.kdl` |

Workstation dump (full paths + fish): repo `.config/tmux/`.

## Dry-run

```bash
./install.sh --dry-run --profile workstation
```
