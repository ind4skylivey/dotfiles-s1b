# sesh (opcional, ya instalado)

[sesh](https://github.com/joshmedeski/sesh) unifica sesiones tmux, configs y zoxide en un solo picker.

## Binario

Instalado en `~/.local/bin/sesh`. Asegurate de tener `~/.local/bin` en PATH (fish: `fish_add_path ~/.local/bin`).

## Uso en tmux

| Atajo | Acción |
|-------|--------|
| `Prefix` `T` | Launcher sesh + fzf-tmux con preview |

Dentro del menú:

- `Ctrl+a` todas las sesiones
- `Ctrl+t` solo tmux
- `Ctrl+g` configs de sesh
- `Ctrl+x` zoxide
- `Ctrl+f` buscar directorios con fd
- `Ctrl+d` matar sesión seleccionada

## Config

`sesh` lee `~/.config/sesh/sesh.toml` si existe. Sin config, igual lista sesiones tmux activas.

```bash
sesh list
sesh preview <nombre>
```
