# Niri module

Portable **Niri** (Wayland) imported from sibling repo [NiriPURA](https://github.com/ind4skylivey/NiriPURA.git). Not a git submodule of that tree.

`--desktop niri` is the default when `--profile desktop` (or `full`) is set. **No Waybar** in this session: Noctalia + Fuzzel. Mutually exclusive with DWM and Plasma.

## Not included (on purpose)

- `modules/monitors.kdl` / `open-on-output "DP-1"` (host overlay)
- OpenRGB / Solaar autostart
- Burp / ZAP / Ghidra / workspace `sec` (security profile later)
- `/home/il1v3y` launcher paths
- Noctalia plugin screenshots from NiriPURA

Copy `modules/niri/local.monitors.example` → `~/.config/niri/modules/monitors.kdl` and uncomment the include in `config.kdl`.

## Dry-run

```bash
./install.sh --dry-run --profile desktop
./install.sh --dry-run --desktop niri
```

Do not link over a live `~/.config/niri` until you have a backup. Live config is still NiriPURA.
