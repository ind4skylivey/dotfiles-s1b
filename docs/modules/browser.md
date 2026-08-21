# Browser module

Optional **theme archive** for `--profile full`. It does **not** own the live browsers on this machine.

## Live browsers (system, not this module)

| Browser | Role | Config in this repo |
|---|---|---|
| **Zen** | daily, stability/security profile | **No.** Live config stays in the Zen profile on disk. Do not link dump `prefs.js` or overwrite that profile. |
| **Helium** | separate | On-system only (DWM/Niri can spawn it). Not migrated. |
| **Qutebrowser** | separate | On-system only. Not migrated. |

## What this module plans

Staging copy of **`userChrome.css`** (cyberpunk chrome only) at `~/.zen-browser-config/chrome/userChrome.css`.

That path is **not** a Zen profile. Apply it only if you want that old theme on a throwaway profile. The current stable Zen setup must not be replaced by this file.

## Never

- `prefs.js` (C-01: account PII; also not how the live Zen profile is maintained)
- Helium / Qutebrowser user dirs
- Copying dump chrome into `~/.zen/<profile>/` as part of install

```bash
./install.sh --dry-run --profile full
```
