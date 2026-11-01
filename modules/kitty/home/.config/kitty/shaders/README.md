# Custom Shaders — Kitty 0.49+

Kitty's custom shaders are **embedded in the binary**: you enable them **by name**
in `kitty.conf`. No shader files are needed here. This directory is only for your
**own** pipelines (`.pipeline`) or shaders (`.slang`).

## Enable (in `kitty.conf`)

```ini
cursor_trail 3        # required by all cursor-trail-* shaders
custom_shaders cursor-trail-blaze focus-highlight tab-change
```

`custom_shaders` accepts several names on one line; each one is an independent
pipeline that runs at the end of kitty's rendering.

## Built-in shaders (by name)

| Category | Names |
|---|---|
| Animated backgrounds | `inside-the-matrix`, `northern-lights` |
| Retro | `crt`, `crt-blue`, `tft` |
| Cursor trails | `cursor-trail-blaze`, `cursor-trail-lightning`, `cursor-trail-motion-blur`, `cursor-trail-railgun`, `cursor-trail-torpedo`, `cursor-trail-pixiedust` |
| Mouse | `spotlight`, `pond-ripple`, `fireworks` |
| UI | `focus-highlight`, `tab-change`, `dim-inactive-windows`, `bloom` |

## Caveats

- Background shaders (matrix / northern-lights / crt-blue) are full-screen:
  enable **one at a time** (GPU cost).
- Cursor-trail shaders **suppress** kitty's native trail rendering: do not
  combine several trail shaders at once.
- Restart kitty completely after editing `kitty.conf`.

## Verify config without restarting

```bash
kitty +runpy "from kitty.config import load_config; import os; print(load_config(os.path.expanduser('~/.config/kitty/kitty.conf'))['custom_shaders'])"
```

## References

- Docs: https://sw.kovidgoyal.net/kitty/docs/custom-shaders/
- Built-in shader source: https://github.com/kovidgoyal/kitty/tree/master/kitty/shaders/custom
