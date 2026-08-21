# Current-state audit — dotfiles-s1b

**Date:** 2026-08-21  
**Language:** English (personal repository under [ind4skylivey](https://github.com/ind4skylivey)).  
**Branch:** `main` (HEAD `8f97f1c`, tracking `origin/main`)  
**Scope:** versioned files, scripts, documentation, and paths.  
**Method:** tree inventory, installer and config review, search for PII, hardware, AUR, root, URLs, and duplicates. Same-day amendment: live Niri session outside this repo.  
**Rule:** nothing below was invented. If the README mentions a component that is not in the tree, it is marked *documented but absent*.

> **Niri amendment:** the Wayland compositor in daily use **does exist** on the machine (`niri 26.04`, session `niri.desktop`). It is not inside `dotfiles-s1b`; it lives in `~/.config/niri` (repo [NiriPURA](https://github.com/ind4skylivey/NiriPURA.git)). It must be a **first-class** desktop backend, not a future invented module. See §3.4 and §15.

Approved architecture: [../architecture.md](../architecture.md).

---

## 1. Executive summary

This repository is **not yet a reproducible platform**. It is a **dump of a live home** (user `il1v3y`, reference host CachyOS/Arch, machine S1B) plus two install scripts (`bootstrap.sh`, `install.sh`) and an orchestration layer (`bin/ws-*` + `workflow/`).

Verified numbers:

| Metric | Value |
|---|---|
| Files tracked by git | 1905 |
| Files under `.config/` | 1829 |
| Files under `.config/zsh/` | 1356 (~71% of the repo) |
| Top-level install scripts | 2 (`install.sh`, `bootstrap.sh`) |
| Root Makefile | none (at audit time) |
| CI (GitHub Actions) | none (`.github/` is screenshots only) |
| Automated tests | none (at audit time) |
| Declarative profiles | none |
| Platform detection | none (installer requires `pacman`) |
| Dry-run / uninstall / restore | none |
| Niri | **in use on the host**, outside this repo (`~/.config/niri`, NiriPURA) |
| Versioned git config (`.gitconfig`) | **not in the repository** |

The README promises “minimal intrusion, maximum reproducibility”. The real installer assumes Arch, assumes the clone lives at `$HOME/dotfiles`, installs AUR packages if `yay` exists, rewrites host configs with `sed`, and can delete `~/.config` directories with `rm -rf`.

**Verdict:** usable as a personal backup of a single host; **not usable** to prepare a new machine in an auditable, portable, reversible way.

---

## 2. Current structure

```
dotfiles-s1b/
├── install.sh                 # Arch + stow + AUR + DWM + Doom
├── bootstrap.sh               # clone into ~/dotfiles, then install.sh
├── lockscreen.sh              # betterlockscreen wrapper
├── lockscreen-setup.sh        # wallpaper cache from ~/Pictures/screenlock
├── .zshrc                     # interactive zsh (host-specific, offensive, P10k)
├── .p10k.zsh
├── starship.toml              # at repo root (not under .config/)
├── --body                     # empty junk file
├── LICENSE                    # MIT, copyright 2024 il1v3y
├── README.md + extra guides
├── bin/                       # Eco-Workflow: ws-local/remote/write/redteam/doctor
├── workflow/                  # markdown profiles + Zellij layouts
├── themes/                    # 12 YAML palettes (Materia Shift)
├── assets/                    # screenshots
├── .github/screenshots/       # duplicates of assets; no workflows
├── .doom.d/                   # Doom Emacs
├── .zen-browser-config/       # real-profile prefs.js + userChrome.css
├── .config/                   # XDG dump (most of the repo)
└── .local/                    # wrapper binaries + file-manager actions
```

At audit time there were no `modules/`, `packages/`, `config/profiles/`, `scripts/lib/`, `tests/`, root `Makefile`, system `doctor.sh`, `validate.sh`, `uninstall.sh`, or `restore.sh`.

`bin/ws-doctor` exists, but it only validates Eco-Workflow, not the rest of the system.

---

## 3. Detected components

Classification verified against real files.

### 3.1 Present and versioned

| Domain | Components | Notes |
|---|---|---|
| Shell | Fish (`config.fish`), Zsh (`.zshrc` + a different `.config/zsh/.zshrc`), P10k, Starship | Two incompatible zshrcs. Fish is the documented interactive shell. |
| Prompt | Starship (root), Powerlevel10k, Prism (referenced; `.config/prism/prism.fish` **missing**) | Starship disabled in `.zshrc` |
| Terminal | Kitty, Alacritty, Warp (docs + aliases), Cava | Warp is docs/aliases, not a binary |
| Multiplexer | Tmux, Zellij (+ layouts in `workflow/` and `.config/zellij/`) | Tmux forces `/usr/bin/fish` |
| Editors | Neovim (NvChad), Doom Emacs, Helix, Micro | Micro ships 150+ upstream syntax YAML files |
| Git | aliases and referenced hooks; **no `.gitconfig`** | `git config --global` runs on zsh startup |
| Desktop X11 | DWM (full source + patches), slstatus, dwmblocks, Picom, Rofi, Dunst, betterlockscreen | Compile + `sudo make install` |
| Desktop Wayland (Niri) | Niri 26.04 + Noctalia v5 + Fuzzel + swww + mpvpaper | **Live source outside this repo.** See §3.4 |
| Desktop Wayland/KDE | Waybar (multi-monitor), Wofi, Kvantum, qt5ct, KDE autostart | Aimed at Plasma 6, not DWM or Niri |
| File managers | Yazi, PCManFM-Qt | Custom actions (send-to-phone, magit) |
| Browser | Zen (`userChrome.css` + real-profile `prefs.js`), DWM binds for Helium/Qutebrowser/Firefox | `prefs.js` is not a theme |
| Gaming | Gamescope wrappers, `steam-launch.sh`, DWM rules for RetroArch/ES-DE | Host-specific |
| Security / red team | offensive aliases (zsh, warp, fish/podman), `workflow/profiles/redteam.md`, `ctf_mode` / `red_team` themes | No offensive AUR package list in `install.sh` |
| Workflow | `ws-local`, `ws-remote`, `ws-write`, `ws-redteam`, `ws-doctor` | `ws-menu` and `ws-kill` **documented and absent** |
| Themes | Catppuccin, Nord, cyberpunk synthwave, 12 YAML files in `themes/` | Visual layer mixed into the base |
| Personal projects | optional clones from `install.sh` (matteria-track, iridex-prism-terminal) | Author GitHub URLs |
| RGB hardware | OpenRGB, Solaar, Polychromatic in autostart and DWM autostart | Specific peripherals |

### 3.2 Documented but absent

| Item | Where promised | Actual state |
|---|---|---|
| Niri | original brief + real host use | **Absent from `dotfiles-s1b`**. Present in `~/.config/niri` (NiriPURA). Integrate as an **option**, do not invent it |
| `ws-menu`, `ws-kill` | README, ECO_WORKFLOW_GUIDE | Not in `bin/` |
| `KITTY_GUIDE.md` | README | Missing (`.config/kitty/CHEATSHEET.md` exists) |
| `SETUP_GUIDE.md` | ignored by `.gitignore`; excluded from stow | Not versioned |
| Git identity / `.gitconfig` | implied by “developer setup” | No git config module |
| `.bashrc` | — | Does not exist |
| Zellij layouts `laravel-dev`, `python-dev`, `rust-dev`, `security-research` | `nvim/INSTALLATION-LOG.txt` | Not in `.config/zellij/layouts/` or `workflow/zellij/layouts/` (only `dev`, `write`, `monitor`, `fullscreen`) |
| `~/.config/prism/prism.fish` | `config.fish` | `.config/prism/` only has `.gitkeep` |
| Fisher plugins, TPM, Doom packages | README post-install | Not versioned (correct), but no idempotent install hook |
| Niri / Noctalia / `fz-*` config | daily Wayland use | Outside this repo; see §3.4 |

### 3.3 Non-portable / host-bound

See sections 5 and 6. Summary: `/home/il1v3y` paths, `/media/il1v3y/HD2/...`, CachyOS, a specific three-monitor layout, OpenRGB/Solaar/Razer, local AppImages, Firefox Account.

### 3.4 Niri — live source (NiriPURA)

Verified 2026-08-21 on the reference host:

| Fact | Value |
|---|---|
| Binary | `/usr/bin/niri` — `niri 26.04 (8ed0da4)` |
| Display-manager session | `/usr/share/wayland-sessions/niri.desktop` (alongside `dwm.desktop`) |
| Config tree | `~/.config/niri/` — **its own git repo** |
| Remote | `https://github.com/ind4skylivey/NiriPURA.git` |
| Observed branch | `fix/named-workspaces-boot-pin` |
| Session stack | Niri + **Noctalia v5** (bar, notifications, launcher, lock, wallpapers) |
| What Niri does **not** start | Waybar, Dunst, Rofi, Wofi — those stay with DWM/X11 |

Portable vs host-bound layout:

```
~/.config/niri/
├── config.kdl              # layout + includes (portable with caveats)
├── noctalia.kdl            # Noctalia color overrides
├── modules/
│   ├── input.kdl           # portable
│   ├── animations.kdl      # portable (themes layer)
│   ├── decorations.kdl     # portable (themes layer)
│   ├── env.kdl             # mixed (portable Wayland env; absolute QT_STYLESHEET)
│   ├── autostarts.kdl      # mixed (noctalia/swww portable; openrgb/solaar/fz-clip host)
│   ├── keybinds.kdl        # mixed (nav portable; burpsuite/ZAP and /home/il1v3y/.local/bin/fz-* host)
│   ├── layer-rules.kdl     # portable
│   ├── window-rules.kdl    # mixed (app classes; workspace `sec` → Burp/Ghidra/ZAP)
│   ├── monitors.kdl        # **host-only**: DP-1@180 / DP-2 rotated / HDMI-A-1
│   └── workspaces.kdl      # names portable; `open-on-output "DP-1"` host-only
├── scripts/                # restore-named-workspaces, toggle-output-profile, video-wallpaper
└── noctalia/               # cyberpunk plugins + widget snapshot
```

Niri session dependencies (not in `install.sh`): `niri`, `noctalia`, `fuzzel`, `swww`, `mpvpaper`, `notify-send`, mate-polkit, cursor (WhiteSur or Bibata), Papirus, qt6ct. `~/.local/bin/fz-*` (Fuzzel palette) is also not in `dotfiles-s1b`.

Profile implications:

- `--desktop niri` is the **current** Wayland backend, not an experimental extra.
- It is **mutually exclusive** with DWM and with Plasma+Waybar in the same session.
- `minimal` / `developer` do **not** install Niri.
- Monitors, OpenRGB/Solaar, and Burp/ZAP binds go to a host overlay + the `security` profile.
- Do not copy all of NiriPURA blindly: screenshots, Noctalia plugins, and `/home/il1v3y` paths must not enter the portable tree.

---

## 4. Detected dependencies

### 4.1 Packages `install.sh` tries to install (Arch)

Official (`pacman`): `fish zsh neovim kitty alacritty tmux rofi picom dunst btop starship stow base-devel pcmanfm-qt file-roller kvantum qt5ct`

AUR (`yay`): `fastfetch yazi zellij mcmojave-circle-icon-theme kvmojave-kde-theme`

Note: on current Arch, `fastfetch`, `yazi`, and `zellij` are in official repos. The AUR list is stale. The installer does **not** install DWM deps until a later prompt (`libx11 libxinerama libxft freetype2 imlib2`).

### 4.2 Implicit dependencies (used in configs, not installed)

| Area | Tools |
|---|---|
| Shell | lsd, bat, zoxide, pyenv, nvm, rustup/cargo, fisher, zinit, CachyOS p10k (`/usr/share/zsh-theme-powerlevel10k/`) |
| CachyOS | `/usr/share/cachyos-fish-config/cachyos-config.fish` (sourced; required for Fish) |
| Desktop X11 | betterlockscreen, feh, flameshot, synergy, mate-polkit, picom, slstatus, xrandr, dunstify, xdotool, xset |
| Desktop KDE | waybar, kwin_x11 / kwin_wayland, qdbus6 |
| Lock / wallpapers | `~/Pictures/screenlock`, `~/Pictures/backgrounds` (not versioned) |
| Security aliases | nmap, gobuster, sqlmap, burpsuite, ghidra, searchsploit, msfvenom, msfconsole, trufflehog, ropper, gdb-peda, pwntools |
| Containers | docker **and** podman (alias conflict across shells), networks `malware-isolated`, `sec-tools` |
| AI / local | ollama, LM Studio, OpenCode, Factory/droid, Claude Code configs in `~/.config/claude-code/` (outside the repo) |
| DWM autostart | emacs daemon, openrgb, solaar, synergy, gleam |
| Fonts | MesloLGS / MesloLGL Nerd Font, NotoColorEmoji |
| File transfer | kdeconnect / kdialog (`sendtophone.sh`) |

### 4.3 External URLs

| Use | URL / pattern | Risk |
|---|---|---|
| README one-liner | `curl` of `bootstrap.sh` from GitHub raw | `curl \| bash` |
| Fisher | `curl ... fisher.fish \| source` | pipe to shell, errors hidden (`2>/dev/null`) |
| Rustup | `https://sh.rustup.rs \| sh -s -- -y` | pipe to shell, no checksum |
| Zinit (`.config/zsh/.zshrc`) | clone `zdharma-continuum/zinit` | network on shell startup |
| Doom Emacs | clone `github.com/doomemacs/doomemacs` | |
| TPM | clone `github.com/tmux-plugins/tpm` | |
| Personal projects | `github.com/ind4skylivey/{matteria-track,iridex-prism-terminal}` | |
| Kitty | `api.github.com/users/ind4skylivey` (keybind) | account fingerprinting |
| Containers | `kalilinux/kali-rolling`, `metasploitframework/metasploit-framework` | implicit pull, `--privileged` / `--network host` |

### 4.4 Root / sudo

- `bootstrap.sh`: `sudo pacman -S git`
- `install.sh`: `sudo pacman`, `sudo tee -a /etc/shells`, `chsh`, `sudo make install` (dwm + slstatus)
- `.config/dwm/setup.sh`: `sudo apt` / `sudo yum` / `sudo pacman -Syu --noconfirm` (silent **full system** upgrade)

No script checks whether the user is root, whether sudo exists, or whether a TTY is available for a password prompt.

---

## 5. Critical issues

Each finding includes severity.

### C-01 — Versioned Firefox/Zen account PII — **Critical**

File: `.zen-browser-config/prefs.js`

This is a real profile dump, not a theme:

- `services.sync.username` — personal email
- `identity.fxaccounts.account.device.name` — `il1v3y’s Zen on S1BGr0uP`
- `identity.fxaccounts.account.telemetry.sanitized_uid`
- `identity.fxaccounts.lastSignedInUserHash`
- `browser.download.lastDir` — `/home/il1v3y/Downloads`
- extension UUIDs, urlbar suggestion history, sync timestamps

This is **not** an API token, but it **is** an account identifier and must not live in git. It is already on `main` history. Remove it from the tree, replace it with a minimal `user.js` (theme + privacy), and treat the current `prefs.js` as non-migratable.

**Immediate human action (not automated here):** review/rotate the Firefox account; do not re-commit a full `prefs.js`.

### C-02 — `install.sh` deletes user configs — **Critical**

After an incomplete backup (move only if the path exists **and is not a symlink**):

```bash
for dir in .config/*/; do
    ...
    rm -rf "$HOME/.config/$target"
done
```

It also `rm -rf "$HOME/.doom.d"`. No restore. No dry-run. A Neovim directory with unversioned plugins, or a local `.doom.d`, is destroyed.

### C-03 — Stow + `sed -i` rewrites the repo — **Critical**

`install.sh` stows `.` onto `$HOME` and then:

```bash
sed -i "s|/home/il1v3y|$HOME|g" "$HOME/.config/dwm/config.h" ...
```

If the target is a symlink into the working tree, **tracked files are mutated**. The installer is not an overlay: it edits the source.

The same happens when PATH is appended to `~/.config/fish/config.fish` and `~/.zshrc` (lines 217–238 of the legacy installer): if those are stow-linked, the append lands in git.

### C-04 — Installer pinned to `$HOME/dotfiles` — **Critical**

```bash
DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    error "Dotfiles directory not found..."
    exit 1
fi
```

This working copy lives at `/media/il1v3y/HD2/HDfiles/shenanigans/dotfiles-s1b`. Running `./install.sh` **from here fails**. `bin/ws-*` also assume `${HOME}/dotfiles`.

### C-05 — `curl | sh` and silenced errors — **Critical** (supply chain)

- README: `bash <(curl -fsSL .../bootstrap.sh)`
- Fisher: curl | source, stderr to `/dev/null`
- rustup: curl | sh `-y`
- `dwm/setup.sh`: `pacman -Syu --noconfirm` and apt/yum with stdout/stderr discarded

No checksums, version pins, or integrity checks.

### C-06 — `.zshrc` sources a temp path — **Critical**

```bash
source /tmp/.tmpJiQqOb/prism.zsh
```

Leftover tmpfile from another session. On a new machine it fails; if someone plants that path, zsh executes arbitrary code. A second, more correct source exists later (`~/.config/prism/prism.zsh`) and is also unversioned.

### C-07 — `bootstrap.sh` offers `rm -rf` of the clone — **High** (borderline Critical)

If `~/dotfiles` exists, it asks and may delete the entire tree. It does not distinguish “our repo” from “other content”.

### C-08 — Offensive aliases and privileged containers without consent — **High**

Metasploit/Burp are not installed via `install.sh`, but they **are** activated when shells are linked:

- Fish: `kali` = `podman run ... --privileged`; `malware-box` = unconfined seccomp + `SYS_PTRACE`; `metasploit` = `--network host`
- Zsh: `recon`, `stealth-scan`, `sqlmap-quick`, `msfvenom`, `new-exploit`, `ghidra`, `burp`, lab networks
- Warp: the same aliases documented as a daily flow
- DWM: `Super+g` → burpsuite (documented)

Any `minimal`/`developer` profile that stows `.zshrc` / `config.fish` **enables** this material. That violates explicit consent for the `security` profile.

---

## 6. Portability issues

### P-01 — Arch-only happy path — **High**

`install.sh` exits without `pacman`. `bootstrap.sh` installs git with pacman. Fish sources CachyOS config. Zsh sources CachyOS P10k. Tmux uses `/usr/bin/fish`. DWM autostart uses `--systemd` and mate-polkit.

`.config/dwm/setup.sh` does detect debian/ubuntu/rhel/fedora/arch, but it is disconnected from the main installer and performs silent upgrades.

### P-02 — Hardcoded three-monitor hardware — **High**

The same panels use **two naming schemes**:

| Layer | Outputs | Resolution / role |
|---|---|---|
| DWM X11 (AMD) | `DisplayPort-0`, `DisplayPort-1`, `HDMI-A-0` | 1920x1080@180, 1080 rotated, 1920x1080@60 |
| Waybar / KDE Wayland / Niri | `DP-1`, `DP-2`, `HDMI-A-1` | LG / ASUS portrait / Samsung |

Scripts: `apply-xrandr-layout.sh`, `toggle-xrandr-profile.sh`, `restore-dwm-monitors.sh`, `waybar/launch-multi.sh`, `wallpaper.sh`, `wallpaper-all.sh`, `config-dp1/dp2/hdmi.jsonc`, Niri `modules/monitors.kdl`.

On a laptop, NVIDIA GPU, or single monitor, these scripts fail or turn outputs off (`eDP --off`).

`config.h` hardcodes `refresh_rate = 180` and autostarts OpenRGB/Solaar/Synergy.

### P-03 — Absolute paths for this host — **High**

Verified:

| File | Path |
|---|---|
| `.zshrc` | `/home/il1v3y/Ollama`, `/home/il1v3y/.lmstudio/bin`, `/home/il1v3y/.config/prism/prism.zsh`, `/media/il1v3y/HD2/open-notebook/...`, `~/Applications/Antigravity/antigravity`, `~/AI-models/LMStudio.AppImage` |
| `config.fish` | `/home/il1v3y/Ollama`, `/home/il1v3y/.lmstudio/bin`, `/media/il1v3y/HD2/open-notebook/...` |
| autostart | `/media/il1v3y/HD2/App/VibeTyper.AppImage`, Nextcloud AppImage in `~/Downloads`, gleam in `~/.local/bin` |
| `qt5ct.conf` | `/home/il1v3y/.config/qt5ct/colors/...` |
| `dap-php.lua` | `/home/il1v3y/.valet/Sites` and `/Users/il1v3y/.valet/Sites` |
| sendtophone desktop | `/home/il1v3y/.local/share/file-manager/actions/sendtophone.sh` |
| `dwm/config.h` | `/home/il1v3y/.config/dwm/slstatus/slstatus` |
| `zed` alias | `/home/il1v3y/.local/zed.app/...` |

UID `1000` appears in zsh: `DOCKER_HOST=unix:///run/user/1000/podman/podman.sock`.

### P-04 — Hidden CachyOS dependency — **High**

Fish: `source /usr/share/cachyos-fish-config/cachyos-config.fish` with no guard. On Fedora/Debian/vanilla Arch, Fish **fails to start**.

Root zsh: `source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme` equally.

### P-05 — Three desktops, no selector — **High**

The host runs **three** stacks. Stow of `dotfiles-s1b` only knows the first two:

1. **DWM** (X11, slstatus, picom, xrandr `DisplayPort-*`)
2. **Plasma + Waybar** (`DP-*`, scripts that kill KWin)
3. **Niri + Noctalia** (Wayland, `niri.desktop`, config in NiriPURA)

Autostart in this repo launches Waybar **and** DWM monitor restore. Niri explicitly does **not** start Waybar/Dunst/Rofi/Wofi. Without `--desktop niri|dwm|plasma`, a “full” install would pollute the Niri session.

### P-06 — Niri lives outside this repo — **High** (corrected)

This is not a design vacuum: it is an **unintegrated sibling repo**. Risk: `dotfiles-s1b` cannot rebuild the current Wayland machine. Migration must **import** NiriPURA as `desktop/niri`, not rewrite a compositor from scratch.

### P-07 — macOS / Debian / Fedora — **Medium**

No brew, apt, or dnf in the main installer. Neovim/PHP Valet paths mix Linux and `/Users/il1v3y`. Helix/Kitty/Alacritty/Git would be portable **after** host-specific bits are extracted.

### P-08 — Architecture and GPU — **Low**

No prebuilt DWM binaries (gitignore excludes them). `gamescope` and Steam wrappers assume Xwayland + KWin. Fastfetch uses a personal logo.

---

## 7. Security issues

### S-01 — Firefox account in git — **Critical**

See C-01. Besides email: signed-in user hash and telemetry UID.

### S-02 — Versioned KeePassXC autostart — **Medium**

`.config/autostart/org.keepassxc.KeePassXC.desktop` has no secrets, but it advertises the password manager and would install on any machine. Must be a local override.

### S-03 — `eval` in sendtophone — **Medium**

`.local/share/file-manager/actions/sendtophone.sh` and the pcmanfm-qt copy:

```bash
eval "selected_id=\$(kdialog --menu ... $device_list)"
```

`$device_list` is not safely quoted. Injection risk if a device name is hostile.

### S-04 — Automatic SSH agent + `ssh-add` — **Medium**

Fish and Zsh: if `SSH_AUTH_SOCK` is unset, they start `ssh-agent` and `ssh-add ~/.ssh/id_ed25519`. On a shared host or an empty-passphrase key, the key sits in memory whenever a terminal opens. Not a versioned secret, but sensitive behavior.

### S-05 — `git config --global` on every zsh login — **Medium**

```bash
git config --global init.templatedir '~/.config/claude-code/hooks_template'
```

Mutates global git config when `.zshrc` is sourced. The template **is not in this repo**. On another machine it points at a missing path or another product’s hooks.

### S-06 — Token counts and API-key comments — **Low**

`.zshrc` documents `FACTORY_API_KEY`, `GOOGLE_API_KEY`, `GITHUB_PERSONAL_ACCESS_TOKEN` as “set via environment” (good). `token-usage()` prints token quotas (Haiku 4.5) — not a secret, personal metadata. No `sk-`, `ghp_`, PEM, or key files found.

### S-07 — `.gitignore` covers typical secrets, not browser PII — **Medium**

Ignores `*.secret`, `*.token`, `*.pem`, `*.key`, `auth.json`. **Does not** ignore `prefs.js`, autostart, or profile dumps. An explicit exception **forces** `.zen-browser-config/prefs.js` to be tracked.

### S-08 — Micro backup with user path — **Low**

`.config/micro/backups/%home%il1v3y%.config%.zshrc` — editor artifact; should not be in git.

### S-09 — DWM `systemctl reboot/suspend` without confirmation — **Low**

Direct power keybinds. Assumes systemd.

### S-10 — No ShellCheck / secret scan / CI — **High** (absence)

No workflow. Legacy `install.sh` uses `set -e` but not `set -u` or `pipefail`. `bootstrap.sh` the same. `dwm/setup.sh` has no `set -euo pipefail`. `ws-*` do use `set -euo pipefail` (the better layer in the repo).

---

## 8. Idempotence issues

### I-01 — Re-running `install.sh` is unsafe — **High**

- Backup always creates a new directory, then `rm -rf` of non-symlink targets.
- Stow on an already-linked tree may fail or no-op depending on version.
- PATH append can duplicate if the grep does not match exactly (two patterns OR’d).
- `chsh` is offered every time.
- Fisher is reinstalled every time (errors swallowed).
- Personal-project `cargo build --release` skips if the dir exists, but does not verify binaries in `~/.local/bin`.
- AUR/`pacman --noconfirm` is idempotent at package level (`--needed`), not at config level.

### I-02 — Two different zshrcs — **High**

| File | Stack |
|---|---|
| `/.zshrc` (stow to `~/.zshrc`) | CachyOS P10k, offensive aliases, pyenv, nvm, ollama, factory hooks |
| `.config/zsh/.zshrc` | Zinit + upstream P10k + OMZ snippets (archlinux, aws, kubectl) |

If `ZDOTDIR` points at `~/.config/zsh`, the user never loads the root `.zshrc`, or vice versa. Undocumented. The installer does not choose.

### I-03 — Docker vs Podman contradiction — **Medium**

- Fish: `alias docker '/usr/bin/docker'` and `DOCKER_HOST=unix:///var/run/docker.sock`
- Zsh: `alias docker='podman'` and `DOCKER_HOST=unix:///run/user/1000/podman/podman.sock`

The same user gets different runtimes depending on the shell.

### I-04 — Starship vs P10k — **Medium**

Fish starts Starship. Zsh disables Starship and uses P10k. `starship.toml` is at the **repo root**; the installer tries to back up `$HOME/.config/starship.toml` and, on the manual path, link `.config/starship.toml` **which does not exist**. Stow of the repo root would place `starship.toml` at `$HOME/starship.toml`, not `~/.config/starship.toml`, unless Starship is told otherwise. Default Starship reads `~/.config/starship.toml`. **The canonical file is in the wrong place for the default.**

### I-05 — PATH added three times in `.zshrc` — **Low**

`$HOME/.local/bin` and `$HOME/bin` are exported in several blocks. Not broken, just noisy.

### I-06 — Hardcoded `MAKEFLAGS=-j8` — **Low**

Assumes 8 compile jobs. Aggressive on a 2-core machine; not `nproc` detection.

### I-07 — Incomplete stow ignore list — **Medium**

Stow of `.` onto `$HOME` would also link: `assets/`, `workflow/`, `themes/`, `bin/`, `.github/`, `--body`, `docs/` (once it exists), and any new file. Ignores cover specific markdowns, not `*.md` or `docs/`. After adding `docs/audit/`, **stow would link the audit into the home directory** if someone reuses the current installer.

---

## 9. Files to migrate / split / delete

### 9.1 Migrate (keep behavior, extract host-specific)

This is the useful core. Move to `home/` or modules **after** a linker exists; do not delete.

- `.config/fish/config.fish` — **split** first (see 9.2)
- `.config/kitty/`, `.config/alacritty/`
- `.config/tmux/tmux.conf` — extract `default-shell`
- `.config/zellij/` + `workflow/zellij/layouts/`
- `.config/nvim/` (Lua) — extract Valet paths
- `.doom.d/` (`init.el`, `packages.el`, `config.el`/`config.org`)
- `.config/helix/` (`il1v3y_cyberpunk.toml` may stay as an optional theme)
- `.p10k.zsh` + a **clean** `.zshrc`
- `starship.toml` → `home/.config/starship.toml`
- `.config/yazi/` (without `.local-bin-rich`, already gitignored)
- `.config/dunst/`, `.config/picom/picom.conf` (not the backup)
- `.config/rofi/` (unify with `.config/dwm/config/rofi/`)
- `.config/btop/btop.conf` (strip disk-path comments if any)
- `bin/ws-*` + `workflow/`
- `themes/*.yaml`
- DWM: `config.h` → template with `$HOME`; volume/scratchpad/picom scripts (xrandr scripts go to a host overlay)

### 9.2 Split

| File | Why |
|---|---|
| `.zshrc` | Mixes P10k, pentest, ollama, nvm, pyenv, factory, claude-code, ssh-agent, HD2 paths |
| `config.fish` | CachyOS + global PATH + offensive podman + HD2 + LM Studio |
| `install.sh` | Packages, backup, stow, DWM, Doom, rustup, PATH — one script, five phases |
| `.config/dwm/config.h` | Look, hardware autostart, app rules, security/gaming binds |
| `.zen-browser-config/` | `userChrome.css` (theme) vs `prefs.js` (profile) |
| Waybar | per-monitor configs vs a generic single-monitor config |
| Autostart | restore-wallpaper (generic) vs Nextcloud/VibeTyper/OpenRGB (host) |
| Neovim plugins | PHP/Rust/Python LSP (developer) vs copilot/avante (optional) vs `chadrc` red-team branding |

### 9.3 Delete **only after** migration (not now)

| Path | Reason |
|---|---|
| `.config/zsh/functions/`, `site-functions/`, `5.9/help/` | **1356 files**: Zsh 5.9 tree + system completions. Not a dotfile. Should come from the `zsh` package. |
| `.config/micro/syntax/` | Same: Micro upstream syntax files |
| `.config/zsh/functions` test-repo-git-* | VCS_Info fixtures |
| `--body` | empty |
| `.config/micro/backups/` | local backup |
| `.config/picom/backups/` | local backup |
| `.config/autostart/mimeinfo.cache` | generated |
| `.config/nvim/INSTALLATION-LOG.txt`, `ERRORS-FIXED.md`, `SETUP-COMPLETE.md` | one-machine logs |
| `.config/dwm/config/{kitty,alacritty,rofi}/` | duplicates of `.config/{kitty,alacritty,rofi}` |
| Duplicate screenshots `assets/` vs `.github/screenshots/` | keep one set |
| Full `prefs.js` | replace with a minimal user.js |

**Do not delete yet:** DWM source (`dwm.c`, patches) — it is the real WM, not an accidental dump. Isolate it as a vendored `desktop/dwm` module.

### 9.4 Do not migrate (local overrides / stay out of git)

- `.zen-browser-config/prefs.js` (PII)
- Autostart for AppImages, Nextcloud, JetBrains Toolbox, MEGA, Vesktop, Polychromatic, OpenRGB, Solaar, Vibe Typer, XDM
- `/media/il1v3y/HD2/...` paths
- `config.fish` OLLAMA_MODELS / LM Studio
- `~/.ssh`, tokens, git user.email
- Podman networks and `~/security/` volumes

---

## 10. Documentation vs reality

| README claim | Reality |
|---|---|
| “Maximum reproducibility” | One host, absolute paths, CachyOS |
| One-liner `curl \| bash` | Unsafe; bootstrap requires pacman |
| GNU Stow recommended | Stow of the **entire repo** onto `$HOME` |
| Manual install `ln -sf ~/.config/fish ~/.config/fish` | **Broken** example (source = target) |
| `ws-menu` / `ws-kill` | Not implemented |
| Niri | In use on the host; **not versioned here** (NiriPURA) |
| Waybar “KDE Plasma 6 Wayland” + DWM | Two stacks, one stow |
| Security tools as part of setup | Aliases yes; packages no; no opt-in |
| `KITTY_GUIDE.md` | Missing |
| Eco-Workflow 6 layers | 4 real entrypoints + doctor; Materia Shift/Obsidian/Fantasma are documented more than implemented in this repo |

There is good documentation in `workflow/`, `ECO_WORKFLOW_GUIDE.md`, Kitty/Alacritty cheatsheets, and DWM-GUIDE. It is **coupled to this host** (monitors, burpsuite, lockscreen path).

---

## 11. DWM / Niri / Wayland / X11 / KDE conflicts

```
Session A: DWM + Picom + slstatus + xrandr DisplayPort-*          (X11)
Session B: KDE Plasma + KWin + Waybar DP-*                        (Wayland)
Session C: Niri + Noctalia + Fuzzel + swww   ← current Wayland use (Wayland)
```

- The display manager already offers `niri.desktop` and `dwm.desktop`.
- Autostart **in this repo** launches Waybar and DWM restore; that **breaks or pollutes** a Niri session (NiriPURA states it: do not start waybar/dunst/rofi/wofi).
- Panel names: Niri/Waybar use `DP-1`/`DP-2`/`HDMI-A-1`; DWM uses `DisplayPort-0`/`DisplayPort-1`/`HDMI-A-0`. Same physical desk, three stacks.
- `apply-kde-config.sh` **kills KWin** (irrelevant on Niri, destructive on Plasma).
- `steam-launch.sh` talks to KWin, not Niri or DWM.
- Niri binds `Mod+G` Burp / `Mod+Shift+Z` ZAP belong to the `security` profile, not generic `desktop`.
- `fz-*` uses absolute `/home/il1v3y/.local/bin/...` because Niri spawn does not inherit `~/.local/bin`.

Migration: mutually exclusive backends: `niri` | `dwm-x11` | `plasma-wayland`. Recommended graphical default: **niri**.

---

## 12. Shell compatibility

| | Fish | Root zsh | Zsh `$ZDOTDIR` | Bash |
|---|---|---|---|---|
| File | `.config/fish/config.fish` | `.zshrc` | `.config/zsh/.zshrc` | none |
| Prompt | Starship | CachyOS P10k | Zinit+P10k | — |
| Docker | real docker | podman | n/a | — |
| CachyOS | required source | P10k source | no | — |
| Red-team aliases | podman kali/msf | nmap/burp/msfvenom | no | — |
| Tmux default | forced `/usr/bin/fish` | | | |

`install.sh` asks whether to set Fish as the login shell. Tmux already assumes Fish. A user who chooses Zsh still gets Fish inside tmux.

`ws-doctor` looks for `__livey_prompt_badge` in Fish: **it is not** in `config.fish` → permanent WARN.

---

## 13. Risk of running existing scripts

| Script | What happens today | Risk |
|---|---|---|
| `./install.sh` from this path | Exits: not `~/dotfiles` | Low (fails closed) |
| `./install.sh` from `~/dotfiles` on Arch | pacman + yay, backup mv, `rm -rf` configs, mass stow, sed on the repo, optional system-wide DWM, rustup, chsh | **High** |
| `./bootstrap.sh` | May `rm -rf ~/dotfiles`, clone, install | **High** |
| `.config/dwm/setup.sh` | `pacman -Syu --noconfirm` or full apt/yum, compile picom/dwm, internal stow | **High** |
| `lockscreen-setup.sh` | Only caches wallpapers if `~/Pictures/screenlock` exists | Low |
| `bin/ws-*` | Creates tmux/zellij sessions; assumes `~/dotfiles` | Medium (non-destructive) |
| `waybar/scripts/apply-kde-config.sh` | Kills the graphical compositor | **High** in a graphical session |
| `restore-dwm-monitors.sh` | xrandr to a 3-monitor AMD layout | Medium (unreadable session on other hardware) |

**Recommendation:** do not run `install.sh` / `bootstrap.sh` / `dwm/setup.sh` until dry-run and backup-with-manifest exist.

---

## 14. Prioritized recommendations

### P0 — now (before any config migration)

1. **Remove `prefs.js` from the tree** (or stop tracking it) and review Firefox account exposure. Replace with an example `user.js` with no identity. **Critical.**
2. **Do not re-run the current installer** against a production home. **Critical.**
3. Treat Niri as the first-class Wayland backend and integrate NiriPURA in the desktop phase (do not mix it with DWM). **High.**

### P1 — foundations (without moving dotfiles)

4. `scripts/lib` + platform detection + logging + dry-run. **High.**
5. Backup with manifest, checksums, `restore.sh`, rollback. **High.**
6. Idempotent linker (`link_config`) that does not `rm -rf` or `sed -i` the repo. **High.**
7. CLI `./install.sh --help --dry-run --profile` as a facade, delegating to the old installer only under temporary `--legacy`. **High.**

### P2 — base modules (shell, git, terminal, tmux/zellij, editor)

8. Extract host-specific bits from `.zshrc` and `config.fish` into `config/local.toml` / `hosts/<name>.toml`. **High.**
9. Unify a single zshrc; stop versioning the Zsh 5.9 completions tree. **High.**
10. Create a `git` module (no config exists). **Medium.**
11. Move `starship.toml` to XDG. **Medium.**
12. `minimal` / `developer` profiles **without** offensive aliases. **High.**

### P3 — desktop / security / gaming / themes

13. Desktop opt-in: **Niri (Wayland, recommended default)** **or** DWM (X11) **or** Plasma/Waybar. Never two compositors in the same session. **High.**
14. `security` profile with a warning and an explicit list. **High.**
15. Gaming and RGB (OpenRGB/Solaar) out of `minimal`/`developer`. **Medium.**
16. Cyberpunk themes as a `themes` layer. **Medium.**

### P4 — quality

17. Bats + ShellCheck + gitleaks/trufflehog in GitHub Actions. **High.**
18. Makefile (`help lint test validate dry-run`). **Medium.**
19. README rewritten as a new-machine runbook. **High.**
20. Compatibility: `bin/` stays on PATH; the old `install.sh` is deprecated, not deleted in the first commit. **High.**

---

## 15. Target architecture (approved)

Goal: **wrap** the current tree; do not rewrite it in one move.

Canonical write-up: [../architecture.md](../architecture.md).

### 15.1 Deviations from the original brief tree

| Brief | Proposal | Why |
|---|---|---|
| Move everything to `home/` + `modules/` now | Introduce `scripts/`, `config/`, `modules/` and leave `.config/` in place until each module migrates | 1905 files; a mass move breaks stow and the live home |
| `modules/desktop` includes Niri | **Yes, as the primary Wayland backend.** Source = NiriPURA, not invention | Live config verified; not in this git |
| Copy all of NiriPURA | **No.** Import portable KDL modules; monitors and `/home/il1v3y` go to a host overlay | Screenshots, path PII, offensive binds, RGB |
| GNU Stow as the mechanism | Custom linker (`scripts/link.sh`) per declared file/dir | Root stow is the cause of C-03/I-07 |
| `packages/aur/` applied in developer | AUR only with `--allow-aur` or a profile that declares it | Do not install AUR silently |
| Replace `install.sh` immediately | New `install.sh` + `scripts/legacy/install.sh` | Do not break the existing command |
| Single `doctor.sh` | System `doctor.sh` + keep `bin/ws-doctor` | Workflow doctor already exists |
| Single `home/.zshrc` | Generate from layers; do not copy the current `.zshrc` as-is | Contains offensive aliases + host paths + tmp path |

### 15.2 Target tree (full phase, not this commit)

See [../architecture.md](../architecture.md). During migration, `.config/`, `bin/`, `workflow/`, and `.doom.d/` stay put. Each module declares `link:` from those paths. After a module is validated, it moves to `home/` with a stub or a documented rename.

### 15.3 Flow

```
detect → plan → confirm → backup → install → link → configure → validate → report
dry-run: detect → plan → report
```

The plan must be explicit (packages, links, skips). Never “guess” the host.

### 15.4 Configuration layers (priority)

1. Module defaults  
2. Profile  
3. Detected platform  
4. Host (`config/hosts/$HOSTNAME.toml`, gitignored)  
5. `config/local.toml` (gitignored)  
6. Environment  
7. CLI  

### 15.5 Profiles (mapped to **real** content)

| Profile | Includes from this repo | Excludes |
|---|---|---|
| `minimal` | zsh or fish **without** a hard CachyOS fail, git (new), optional starship/p10k, optional minimal nvim | DWM, Waybar, Doom, AUR, warp aliases, podman kali, wallpapers, RGB |
| `workstation` | minimal + kitty/alacritty + tmux or zellij + fonts | DWM, Niri, security, gaming |
| `developer` | workstation + nvim LSP plugins (php/python/rust) + optional pyenv/nvm/rustup + docker/podman **without** offensive labs | red-team aliases, DWM/Niri, AUR themes |
| `security` | aliases + warp docs + ws-redteam + warning + opt-in packages; on Niri, Burp/ZAP binds and workspace `sec` | not part of minimal/workstation/developer |
| `desktop` | `--desktop niri` (Wayland, **default if a graphical session is requested**) \| `--desktop dwm` (X11) \| `--desktop plasma`. Selectable Niri pieces: compositor, Noctalia, Fuzzel/`fz-*`, swww, mpvpaper, workspaces. Waybar/Rofi only with dwm/plasma | never two compositors |
| `gaming` | gamescope, steam-launch, DWM/Niri game rules, 180Hz toggle | independent |
| `full` | union with confirmation and a summary; asks for a desktop backend | nothing silent |

### 15.6 Niri option (mandatory in the design)

Niri is not guessed: it is chosen. Default **only** when the user asks for desktop and does not pass `--desktop`.

```text
./install.sh --profile desktop                  # default Wayland: niri
./install.sh --profile desktop --desktop niri
./install.sh --profile desktop --desktop dwm
./install.sh --profile desktop --desktop plasma
./install.sh --components niri,noctalia,fuzzel
./install.sh --profile full --desktop niri --exclude gaming
./install.sh --dry-run --desktop niri
```

Expected plan (example):

```text
Detected session: Wayland
Selected desktop: niri
[install] niri
[install] noctalia
[install] fuzzel
[install] swww
[skip]    dwm          (different backend)
[skip]    waybar       (Noctalia owns the bar)
[skip]    rofi/dunst   (Niri session)
[link]    ~/.config/niri/config.kdl
[link]    ~/.config/niri/modules/*.kdl  (portable)
[skip]    modules/monitors.kdl         (host overlay or detection)
[skip]    Burp/ZAP keybinds            (requires --profile security)
```

Internal modules (when migrated, not now):

| Module | What comes in | What stays out |
|---|---|---|
| `desktop/niri` | compositor, `config.kdl`, input/animations/decorations/layer-rules, generic Wayland env | hardcoded `monitors.kdl` |
| `desktop/noctalia` | shell (bar, lock, notifications, wallpapers) | live `~/.local/state/noctalia/settings.toml` |
| `desktop/fuzzel` | `fz-*` with `$HOME/.local/bin`, not `/home/il1v3y` | KeePass path, SSH config |
| `desktop/dwm` | X11, picom, slstatus, rofi | — |
| `desktop/waybar` | only `--desktop plasma` | niri session |

Detection: if `XDG_CURRENT_DESKTOP=niri` or `niri.desktop` exists, doctor and dry-run report it. An incompatible module (Niri on X11-only, DWM in an already-active Niri session) is **skipped** with an explanation; it does not fail the rest.

Import strategy (desktop phase): copy portable KDL from NiriPURA into `home/.config/niri/`. Do not git-submodule the whole repo (screenshots, plugins, dirty working tree). Keep NiriPURA as documented upstream.

---

## 16. Suggested migration order

0. **Audit** ← this document  
1. Architecture approval ← done  
2. Platform detection + logging + dry-run + tests (do not move dotfiles)  
3. Backup / manifest / restore / rollback + tests  
4. Minimal `install.sh` CLI (plan + --help) keeping `--legacy`  
5. Modules: shell → git → terminal → tmux/zellij → editor  
6. System doctor + repo validate  
7. CI ShellCheck + bats + secret scan  
8. Desktop: **Niri first** (import NiriPURA, split host/portable), then DWM; Waybar only if `--desktop plasma`  
9. Security (opt-in)  
10. Gaming, themes, browser (`userChrome` only)  
11. Drop the Zsh 5.9 tree and Micro syntax after confirming the distro package covers completions  
12. Rewrite the README  

After each module: tests, doctor, dry-run, diff, document incompatibilities.

---

## 17. Compatibility with the current installer

Until the new CLI is complete:

- **Do not delete** `install.sh` / `bootstrap.sh`.
- Rename later to `scripts/legacy/` and leave wrappers:
  - `./install.sh` → new CLI
  - `./install.sh --legacy` → current behavior, with a warning
- `bin/ws-*` do not move in the first phases (`PATH` documented as `~/dotfiles/bin` **or** `$REPO/bin`).
- Stow stops being the default as soon as `link_config` exists.
- Document: if the clone is not at `~/dotfiles`, the legacy installer does not work; the new CLI uses the script’s directory.

---

## 18. Script inventory (complete, verified)

| Path | `set -euo pipefail` | Privilege | Notes |
|---|---|---|---|
| `install.sh` (legacy, now also dispatcher) | legacy: `-e` only | sudo | see C-02–C-05 |
| `bootstrap.sh` | `-e` only | sudo | rm -rf clone |
| `lockscreen.sh` / `lockscreen-setup.sh` | no | no | betterlockscreen |
| `bin/ws-local` | yes | no | assumes `~/dotfiles` |
| `bin/ws-remote` | yes | no | tmux |
| `bin/ws-write` | yes | no | emacs |
| `bin/ws-redteam` | yes | no | ethical notice in help |
| `bin/ws-doctor` | `-uo pipefail` (no `-e`) | no | workflow only |
| `.config/dwm/setup.sh` | no | sudo | silent Syu |
| `.config/dwm/scripts/*.sh` | mixed | no | host-specific xrandr |
| `.config/waybar/scripts/*.sh` | mixed | no | KDE + monitors |
| `.config/picom/switch-mode.sh` | ? | no | |
| `.local/bin/codex` | yes | no | ollama wrapper |
| `.local/bin/steam-launch.sh` | no | no | KWin |
| `sendtophone.sh` | no | no | eval |

---

## 19. Verified vs unverified assumptions

**Verified**

- Niri **is** installed and configured on the host; **not** in this repository.
- No CI (at audit time).
- No tests (at audit time).
- No `.gitconfig`.
- `prefs.js` contains Firefox Account identity.
- `.config/zsh` is mostly upstream Zsh 5.9.
- The installer requires `pacman` and `$HOME/dotfiles`.
- Fish depends on CachyOS.
- DWM, Waybar, and Niri describe the same desk with different output names (X11 AMD vs Wayland DRM).

**Not verified (outside this working tree)**

- Whether the live home is currently stow-linked to this clone.
- Whether podman networks `malware-isolated` exist on the machine.
- Whether `~/Pictures/backgrounds` exists.
- Contents of `~/.config/claude-code/` (referenced, not versioned).
- Whether `fastfetch`/`yazi`/`zellij` are still AUR on the user’s mirror (they are usually official in Arch extra; re-check in the package phase).
- Dirty working tree in NiriPURA (`README.md`, `autostarts.kdl`, `keybinds.kdl`, `layer-rules.kdl` modified). Import **after** deciding which commit is the source.

---

## 20. Acceptance criteria — current gap

| # | Criterion | Met today? |
|---|---|---|
| 1 | Not tied to a single host | No |
| 2 | Modular architecture documented | Yes (this audit + `docs/architecture.md`) |
| 3 | Profiles | Not implemented |
| 4 | Selectable components | Not implemented |
| 5 | Platform detection | In progress (new `scripts/lib`) |
| 6 | Idempotence | No |
| 7 | Dry-run | In progress |
| 8 | Backup with manifest | No (legacy only `mv` to a timestamp) |
| 9 | Restore / rollback | No |
| 10 | System doctor | Partial (`ws-doctor` + new `doctor.sh`) |
| 11 | Safe uninstall | No |
| 12 | Skip incompatibles | Not implemented |
| 13 | AUR/offensive not silent | AUR prompted; offensive still linked |
| 14 | No versioned secrets/PII | **No** (`prefs.js`) |
| 15 | ShellCheck | Partial (new scripts only) |
| 16 | Tests | In progress |
| 17 | CI | Not yet |
| 18 | README for a from-scratch install | Misleading |
| 19 | Host-specific isolated | No |
| 20 | Auditable rebuild | No |

---

*End of Phase 0. Architecture in section 15 is approved. Project documentation language is English.*
