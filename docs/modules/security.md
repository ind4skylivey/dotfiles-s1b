# Security module

Explicit **opt-in**. Not part of `minimal` / `workstation` / `developer`. `full` does **not** include this silently.

```bash
./install.sh --dry-run --profile security
```

Prints a `[warn]` row. Plans:

- `~/.config/zsh/security.zsh` / `~/.config/fish/security.fish` (aliases if tools exist)
- `~/.config/niri/modules/security.kdl` (workspace `sec`, Burp/ZAP window rules)

Uncomment `include "./modules/security.kdl"` in the portable Niri config after linking.

## Not included

- Dump `kali --privileged` / metasploit volume aliases
- Package installs (Burp/ZAP)
- Live `prefs.js`
