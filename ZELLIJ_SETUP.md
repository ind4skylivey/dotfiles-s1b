# Zellij Setup

Zellij is the session manager I use for local development. It handles layout management, pane splitting, and tab organization. The Eco-Workflow system (`ws-local`) wraps Zellij with custom layouts and session naming.

## Quick Start

If you're using the Eco-Workflow system, you don't need to run Zellij directly — just use `ws-local` and it handles everything. But if you want to run Zellij standalone:

```bash
# Basic usage
zellij

# With a specific layout
zellij --layout dev

# With a session name
zellij --session my-session
```

## Layouts

The Eco-Workflow system includes these layouts in `workflow/zellij/layouts/`:

| Layout | What it does |
|:---|:---|
| `dev` | Editor pane (70%) + Files (30%) / Shell (25%) |
| `monitor` | System monitor + Logs + Shell |
| `write` | Editor (75%) + Reference (25%) |
| `fullscreen` | Single editor pane |

## Key Navigation

| Key | Action |
|:---|:---|
| `Ctrl+G` | Enter Zellij mode |
| `Alt+Arrow` | Move between panes |
| `Alt+F` | Toggle floating pane |
| `Ctrl+G + T` | Tab mode |
| `Ctrl+G + P` | Pane mode |
| `Ctrl+G + R` | Resize mode |
| `Ctrl+G + Q` | Quit |

## Configuration

Zellij config lives in `~/.config/zellij/config.kdl`. The Eco-Workflow system doesn't override your personal config — it just provides layout files.

If you want to try the cyberpunk theme from the dotfiles, there's an integration guide at `.config/kitty/tmux-zellij-integration.conf`.

## Status Bar

I use the zjstatus plugin to show git branch, datetime, and session name in the status bar. It's located at `~/.config/zellij/plugins/zjstatus.wasm`.

## Troubleshooting

**Layout not loading:** Make sure `workflow/zellij/layouts/` is in your Zellij layouts directory, or specify the full path.

**Plugin not working:** The wasm plugin needs to be in `~/.config/zellij/plugins/`.

For more details on the Eco-Workflow integration, check out [ECO_WORKFLOW_GUIDE.md](ECO_WORKFLOW_GUIDE.md).
