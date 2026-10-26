# Browser module

Optional **theme + prefs template** for `--profile full`. It does **not** auto-overwrite the live Zen profile.

## Live browsers (system, not this module)

| Browser | Role | Config in this repo |
|---|---|---|
| **Zen** | daily | Canonical **`user.js`** + **`userChrome.css`** under `modules/browser/home/.zen-browser-config/`. Copy into `~/.zen/<profile>/` when you want them live. |
| **Helium** | separate | On-system only. Not migrated. |
| **Qutebrowser** | separate | On-system only. Not migrated. |

## What this module stages (`~/.zen-browser-config/`)

- `chrome/userChrome.css` — cyberpunk/glass + Compact Mode pack (2026-10-26)
- `user.js` — hardening, cold-start, Compact prefs, **VAAPI** for AMD (RX 6700 XT)

That path is a **staging copy**. Apply into the live profile:

```fish
set -l P ~/.zen/7h4wrogl.Default\ \(release\)
cp ~/.zen-browser-config/user.js $P/user.js
mkdir -p $P/chrome
cp ~/.zen-browser-config/chrome/userChrome.css $P/chrome/userChrome.css
```

## Never

- Commit or install a dump of **`prefs.js`** (session/account PII)
- Blindly overwrite `~/.zen/<profile>/` from `install.sh`
- Helium / Qutebrowser user dirs

```bash
./install.sh --dry-run --profile full
```
