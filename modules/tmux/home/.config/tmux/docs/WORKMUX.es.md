# workmux — guía rápida en español

> **Versión comprobada:** `workmux 0.1.269` (Homebrew), 2 de octubre de 2026.
> **Config tmux:** `~/.config/tmux/tmux.conf` · **Prefijo:** `Ctrl Space`.

## Qué es

`workmux` une **Git worktrees** y **ventanas de tmux**. Cada tarea puede vivir en una rama y directorio separados, con su propia ventana, panes, editor y servidor. Así puedes trabajar en varias tareas a la vez sin cambiar de rama ni hacer `stash`.

No reemplaza tmux, Git, Emacs ni Neovim: los coordina. El worktree aísla los archivos y la ventana de tmux organiza la sesión.

Está instalado con Homebrew:

```fish
brew install raine/workmux/workmux
```

En tu `config.fish` ya existe el alias:

```fish
alias wm workmux
```

Por tanto, en los ejemplos puedes usar `wm` en lugar de `workmux`.

## Atajos de tu tmux

Tu prefijo es `Ctrl Space`: pulsa y suelta esa combinación, y después la tecla indicada.

| Atajo | Acción |
|---|---|
| `Prefijo` `Ctrl-w` | Abrir/cerrar el dashboard de workmux en un popup |
| `Prefijo` `Ctrl-t` | Activar/desactivar el sidebar de workmux |
| `Ctrl h/j/k/l` | Moverte entre panes; con Neovim/Helix el editor recibe la tecla |
| `Prefijo` `?` | Ver todos los atajos disponibles |

Los dos primeros atajos están definidos al final de tu `tmux.conf`, después de TPM. `Ctrl-w` se usa para evitar el conflicto entre el dashboard documentado originalmente con `Ctrl-s` y `tmux-resurrect` (`Prefijo` `Ctrl-s` guarda la sesión).

## Flujo básico

### 1. Crear una tarea

Desde el worktree principal del repositorio:

```fish
wm add feature/login
```

Esto crea la rama si no existe, crea un worktree hermano, abre una ventana tmux y te lleva a ella. El nombre del worktree y de la ventana se deriva de la rama.

Para incluir instrucciones para un agente configurado en los panes:

```fish
wm add feature/login -p "Implementa el login y añade tests"
```

Otras formas verificadas de iniciar una tarea:

```fish
wm add hotfix --base main             # partir de otra base
wm add docs-update --background        # crear sin cambiar a la ventana
wm add feature/login --open-if-exists  # abrirla si ya existe
wm add feature/login --dry-run         # mostrar el plan sin crear nada
```

`--prompt-file`, `--prompt-editor`, `--agent`, `--layout` y `--session` también existen; consulta `wm add --help` antes de incorporarlos a tu flujo.

### 2. Ver y localizar tareas

```fish
wm list
wm list --json
wm path feature/login
```

`wm list` muestra worktrees, estado del agente, ventana tmux y cambios pendientes. Para estado de agentes puedes usar:

```fish
wm status
wm status --git
```

`wm list --pr` añade estado de PR, pero requiere la CLI `gh` autenticada.

### 3. Trabajar en la ventana

El layout de workmux abre los panes definidos por la configuración del proyecto; si no hay configuración, usa un layout predeterminado. En esta máquina puedes usar tus herramientas habituales dentro de esos panes:

- **Neovim:** abre el editor en un pane y usa `Ctrl h/j/k/l` para cruzar entre splits de Neovim y panes tmux.
- **Emacs:** úsalo como editor/REPL en un pane; workmux no cambia sus atajos.
- **tmux:** crea panes o ventanas adicionales con los atajos de tu guía principal (`docs/guide.md`).
- Los servidores, watchers y tests deben tener puertos distintos si ejecutas varias worktrees a la vez.

Para volver a abrir un worktree existente:

```fish
wm open feature/login
```

## Dashboard y sidebar

### Dashboard

Abre el dashboard desde cualquier sesión tmux con:

```fish
wm dashboard
```

En tu configuración, lo normal es pulsar `Prefijo` `Ctrl-w`. El dashboard permite cambiar entre agentes/worktrees, ver una previsualización, filtrar, saltar a un agente y revisar diffs. Atajos útiles dentro del dashboard:

| Tecla | Acción |
|---|---|
| `j/k` | Mover la selección |
| `Enter` | Ir al agente seleccionado |
| `Tab` | Cambiar entre agente actual y anterior |
| `d` | Ver el diff |
| `/` | Filtrar por nombre |
| `i` | Escribir al agente |
| `q` | Salir |

También puedes abrir directamente una pestaña o un diff:

```fish
wm dashboard --tab worktrees
wm dashboard --diff
wm dashboard --session
```

El dashboard necesita el seguimiento de estado de agentes para mostrar agentes con información completa.

### Sidebar

Actívalo o desactívalo con:

```fish
wm sidebar
```

En tu tmux, `Prefijo` `Ctrl-t` ejecuta exactamente ese toggle. También puedes controlarlo explícitamente:

```fish
wm sidebar on
wm sidebar off
wm sidebar next
wm sidebar prev
wm sidebar jump 1
wm sidebar filter
wm sidebar group
```

El sidebar es específico de tmux y muestra estado, proyecto y worktree. Para limitarlo a la sesión actual:

```fish
wm sidebar --session
```

## Terminar una tarea

### Merge local y limpieza

Desde el worktree de la tarea:

```fish
wm merge
```

O indicando el nombre:

```fish
wm merge feature/login
```

Por defecto fusiona en la rama principal configurada y limpia el worktree, la ventana tmux y la rama local. Opciones útiles:

```fish
wm merge feature/login --rebase       # rebase y merge lineal
wm merge feature/login --squash       # un commit combinado
wm merge feature/login --into develop # fusionar en otra rama
wm merge feature/login --keep         # fusionar, pero conservar recursos
wm merge feature/login --cleanup      # forzar limpieza tras el merge
```

Revisa cambios y tests antes de fusionar. Las worktrees evitan interferencias de archivos, pero no eliminan conflictos de Git.

### Flujo con Pull Request

Si vas a abrir un PR, no uses `wm merge` antes de que se fusione el PR. Cuando el PR ya esté integrado, limpia la worktree con:

```fish
wm remove feature/login
```

Para una rama que quieres conservar, `--keep-branch` elimina la worktree y la ventana, pero conserva la rama:

```fish
wm remove feature/login --keep-branch
```

## Configuración opcional

### Configuración de un proyecto

Desde la raíz del repositorio:

```fish
wm init
```

Esto genera un `.workmux.yaml` de ejemplo. Es opcional: workmux funciona con valores razonables sin ese archivo. Úsalo para definir, por ejemplo, panes de Emacs/Neovim, comandos de tests o servidores, hooks y archivos que deben copiarse o enlazarse.

Ejemplo mínimo ilustrativo:

```yaml
panes:
  - command: nvim
    focus: true
  - command: npm run dev
    split: horizontal
```

Los nombres y opciones válidos dependen de la versión instalada. Para consultar la referencia completa sin editar nada:

```fish
wm config reference
wm config path
wm config edit
```

La configuración global está en `~/.config/workmux/config.yaml`; la del proyecto es `.workmux.yaml`. La del proyecto puede sobrescribir la global.

### Estado de agentes y skills

Si usas agentes compatibles y quieres que dashboard/sidebar indiquen `working`, `waiting` o `done`:

```fish
wm setup
```

También puedes instalar solo una parte:

```fish
wm setup --hooks
wm setup --skills
```

Esto configura hooks de estado y/o skills; no es necesario para usar workmux únicamente con tmux, Git y tu editor.

### Autocompletado de fish (opcional)

```fish
workmux completions fish | source
```

## Archivos ignorados y dependencias

Una worktree nueva es un checkout limpio: archivos ignorados como `.env` o `node_modules` no aparecen automáticamente. Si el proyecto los necesita, configura `files.copy` o `files.symlink` en `.workmux.yaml`; para reaplicarlo después:

```fish
wm sync-files
wm sync-files --all
```

Si varias worktrees ejecutan el mismo stack, revisa especialmente:

- `.env` y secretos: copia solo lo necesario.
- `node_modules`: enlazarlo solo si las ramas usan exactamente las mismas dependencias.
- Puertos: asigna puertos diferentes para servidores simultáneos.
- Servidores persistentes: cada worktree necesita su propio proceso o una estrategia clara para compartirlo.

## TUIOS y workmux no son lo mismo

TUIOS es una herramienta separada. No forma parte de workmux ni de tmux: mantenlo como una capa aparte si lo usas. Para tu flujo principal, piensa en:

```text
tmux → ventanas/panes
workmux → worktrees + ventanas tmux
Emacs/Neovim → editor dentro de un pane
TUIOS → herramienta independiente
```

## Recordatorio de bolsillo

```fish
wm add mi-tarea -p "Describe aquí el trabajo"
wm list
wm dashboard                 # o Prefijo Ctrl-w
wm sidebar                   # o Prefijo Ctrl-t
wm path mi-tarea
wm merge                    # merge + limpieza
wm remove mi-tarea          # descartar/limpiar sin merge
wm --help
wm add --help
wm merge --help
```

Documentación local relacionada: [`guide.md`](guide.md) y [`sesh.md`](sesh.md). Referencia upstream: <https://github.com/raine/workmux>.
