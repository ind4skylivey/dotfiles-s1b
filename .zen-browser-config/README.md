# Staging mirror (not canonical)

Canonical Zen templates live in:

`modules/zen-browser/home/.zen-browser-config/`

`install.sh` / `links.tsv` stages them to `~/.zen-browser-config/`.
Do not keep a second full copy of `user.js` / `userChrome.css` here — it drifts.

`prefs.js` in this folder (if present) is legacy and must not be treated as source of truth.
