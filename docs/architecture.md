# Architecture — reproducible platform

**Status:** approved (2026-08-21).  
**Language:** English (this is a personal repository under [ind4skylivey](https://github.com/ind4skylivey)).  
**Audit:** [audit/current-state.md](audit/current-state.md).

This repository is no longer treated as a backup of a single home directory. The goal is a **declarative, modular, idempotent, auditable** system that can prepare a Unix/Linux machine, with Arch/CachyOS as Tier 1.

Cyberpunk aesthetics are an **optional layer**. The base system must work without themes, wallpapers, or window managers.

## Principles

1. Detect, do not guess. The installer prints a plan and asks for confirmation.
2. Dry-run changes nothing: `detect → plan → report`.
3. Real install: `detect → plan → confirm → backup → install → link → configure → validate → report`.
4. An incompatible module is skipped with an explanation; it does not fail the whole run unless it is mandatory.
5. AUR, offensive tools, and RGB/hardware are never installed silently.
6. Secrets, email, private disk paths, and monitor layouts stay out of git.
7. The legacy installer is kept (`scripts/legacy/install.sh` and `./install.sh --legacy`).

## Tree

```
.
├── install.sh                 # new CLI (dispatcher)
├── bootstrap.sh               # legacy: clone into ~/dotfiles
├── uninstall.sh               # pending
├── doctor.sh
├── validate.sh                # validates the repo, not the host
├── restore.sh
├── Makefile
├── config/
│   ├── defaults.toml
│   ├── profiles/*.toml
│   └── local.example.toml
├── scripts/
│   ├── lib/                   # log, detect, plan, backup, link
│   ├── detect-platform.sh
│   ├── backup.sh
│   ├── link.sh                # per-path linker (not stow)
│   └── legacy/install.sh
├── modules/                   # filled during migration
├── packages/                  # filled during migration
├── home/                      # portable overlay (migration)
├── hosts/*.example.toml
├── docs/
├── tests/
└── .github/workflows/
```

While migration is in progress, `.config/`, `bin/`, `workflow/`, and `.doom.d/` **stay where they are**. No mass move.

## Configuration layers (highest wins)

1. Module defaults / `config/defaults.toml`
2. Profile (`--profile`)
3. Detected platform
4. Host (`config/hosts/$HOSTNAME.toml`, gitignored; examples are versioned)
5. `config/local.toml` (gitignored)
6. Environment variables
7. CLI arguments

## Profiles

| Profile | Includes | Excludes |
|---|---|---|
| `minimal` | portable shell, git, essential CLI, optional minimal editor | DWM, Niri, Doom, AUR, offensive tools, gaming, heavy themes |
| `workstation` | minimal + terminal + multiplexer + fonts | DWM, Niri, security, gaming |
| `developer` | workstation + optional Rust/Python/PHP/Node + containers **without** offensive labs | red team, DWM/Niri |
| `security` | explicit opt-in with a warning | not part of the three profiles above |
| `desktop` | explicit backend (see below) | never two compositors |
| `gaming` | independent | — |
| `full` | union with a summary and confirmation | nothing silent |

## Desktop: Niri is first-class

Mutually exclusive backends:

| Flag | Session | Bar / shell | Source |
|---|---|---|---|
| `--desktop niri` | Wayland **(graphical default)** | Noctalia + Fuzzel | sibling repo [NiriPURA](https://github.com/ind4skylivey/NiriPURA.git) (`~/.config/niri`) |
| `--desktop dwm` | X11 | slstatus, picom, rofi | `.config/dwm/` in this repo |
| `--desktop plasma` | KDE Wayland | Waybar | `.config/waybar/` |

```text
./install.sh --profile desktop
./install.sh --profile desktop --desktop niri
./install.sh --components niri,noctalia,fuzzel
./install.sh --exclude niri
```

Niri does **not** start Waybar, Dunst, Rofi, or Wofi. Those stay with DWM/Plasma.

When importing NiriPURA (desktop phase, not now):

- Bring in: portable KDL (`config.kdl`, input, animations, decorations, layer-rules, generic Wayland env).
- Keep in a host overlay: `monitors.kdl`, `open-on-output "DP-1"`, OpenRGB/Solaar, `/home/il1v3y` paths.
- `security` profile: Burp/ZAP keybinds and the `sec` workspace.

Do not git-submodule the entire NiriPURA tree (screenshots, plugins, dirty working tree).

## Portability

| Tier | Systems |
|---|---|
| 1 | Arch Linux, CachyOS |
| 2 | Fedora, Debian, Ubuntu |
| 3 | other Linux distros |
| 4 | macOS (reasonable CLI/dev subset) |

Each module declares: supported systems, dependencies, privilege needs, graphical requirement, Wayland/X11, compile step, experimental flag, and whether it may be skipped.

## Packages

Module logic calls `install_package` / `install_optional_package` / `install_aur_package`. The concrete backend resolves `pacman`, `yay`/`paru`, `apt`, `dnf`, `brew`, `flatpak`. AUR only on Arch and only with consent.

## Security

- Bash: `set -Eeuo pipefail`, no unnecessary `eval`, no `curl | sh` in new code.
- Do not run as root. Use `sudo` only where required.
- Dry-run does not install, link, or delete.
- Do not version tokens, email, a real-profile `prefs.js`, or private disk paths.

## Implementation order

1. Detection + logging + dry-run + tests.
2. Backup / manifest / restore / rollback.
3. Idempotent linker (`scripts/link.sh`, not GNU Stow).
4. Modules: shell → git → terminal → tmux/zellij → editor.
5. Full doctor + expanded CI.
6. Desktop: **Niri first**, then DWM; Waybar only with `--desktop plasma`.
7. Security opt-in, gaming, themes, browser (`userChrome` only).

## Compatibility

| Command | Behavior |
|---|---|
| `./install.sh` (no flags) | legacy installer (interactive, Arch, `~/dotfiles`) |
| `./install.sh --legacy` | same, explicit |
| `./install.sh --help` | new CLI |
| `./install.sh --dry-run` | detect → plan → report |
| `./install.sh --doctor` | non-destructive checks |
| `./install.sh --link SRC DEST` | idempotent per-path symlink (see [linker.md](linker.md)) |
| `bin/ws-*` | path unchanged in this phase |
