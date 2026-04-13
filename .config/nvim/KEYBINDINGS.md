# 🔥 il1v3y's Neovim Keybindings Reference

> **Leader Key:** `<Space>` (Space bar)
> **Mode Legend:** `n` = Normal mode, `i` = Insert mode, `v` = Visual mode

---

## 📋 Table of Contents
- [Basic Navigation](#basic-navigation)
- [File Management](#file-management)
- [Search & Find](#search--find)
- [LSP & Code Intelligence](#lsp--code-intelligence)
- [AI Assistants](#ai-assistants)
- [Git Operations](#git-operations)
- [Debugging (DAP)](#debugging-dap)
- [Python Development](#python-development)
- [PHP/Laravel Development](#phplarave-development)
- [Rust Development](#rust-development)
- [Aesthetic & Focus](#aesthetic--focus)
- [Miscellaneous](#miscellaneous)

---

## Basic Navigation

| Key | Mode | Action |
|-----|------|--------|
| `;` | n | Enter command mode (same as `:`) |
| `jk` | i | Exit insert mode (alternative to `Esc`) |
| `<C-h>` | n | Move to left window |
| `<C-j>` | n | Move to window below |
| `<C-k>` | n | Move to window above |
| `<C-l>` | n | Move to right window |
| `<C-u>` | n | Scroll up (smooth) |
| `<C-d>` | n | Scroll down (smooth) |
| `<C-b>` | n | Scroll page up (smooth) |
| `<C-f>` | n | Scroll page down (smooth) |
| `zt` | n | Move cursor to top (smooth) |
| `zz` | n | Center cursor (smooth) |
| `zb` | n | Move cursor to bottom (smooth) |

---

## File Management

| Key | Mode | Action |
|-----|------|--------|
| `<leader>e` | n | Toggle file explorer (Oil.nvim) |
| `<leader>ff` | n | Find files (fuzzy finder) |
| `<leader>fa` | n | Find all files (including hidden) |
| `<leader>fw` | n | Live grep (search in files) |
| `<leader>fb` | n | Find buffers |
| `<leader>fh` | n | Find help tags |
| `<leader>fo` | n | Find old files (recent) |
| `<leader>fz` | n | Find in current buffer |

---

## Search & Find

| Key | Mode | Action |
|-----|------|--------|
| `/` | n | Forward search (enhanced with scrollbar) |
| `?` | n | Backward search (enhanced with scrollbar) |
| `n` | n | Next search result |
| `N` | n | Previous search result |
| `<leader>ch` | n | Clear search highlights |

---

## LSP & Code Intelligence

### General LSP
| Key | Mode | Action |
|-----|------|--------|
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `gi` | n | Go to implementation |
| `gr` | n | Go to references |
| `K` | n | Hover documentation |
| `<leader>ca` | n | Code actions |
| `<leader>rn` | n | Rename symbol |
| `<leader>fm` | n | Format buffer |
| `[d` | n | Previous diagnostic |
| `]d` | n | Next diagnostic |
| `<leader>ds` | n | Document symbols |
| `<leader>ws` | n | Workspace symbols |

### Preview Windows (Goto Preview)
| Key | Mode | Action |
|-----|------|--------|
| `gpd` | n | Preview definition |
| `gpD` | n | Preview declaration |
| `gpi` | n | Preview implementation |
| `gpy` | n | Preview type definition |
| `gpr` | n | Preview references |
| `gP` | n | Close all preview windows |

### Symbols Outline
| Key | Mode | Action |
|-----|------|--------|
| `<leader>cs` | n | Open symbols outline |

---

## AI Assistants

### CodeCompanion (AI Assistant)
| Key | Mode | Action |
|-----|------|--------|
| `<leader>ac` | n, v | Toggle AI Chat |
| `<leader>an` | n, v | New AI Chat |
| `<leader>aa` | n, v | AI Actions menu |
| `<leader>ae` | v | AI Explain selected code |
| `ga` | v | Add selection to AI chat |

**Inline Mode:**
- `ga` (n) - Accept AI suggestion
- `gr` (n) - Reject AI suggestion

**Chat Commands:**
- `<CR>` (n) - Send message
- `<C-s>` (i) - Send message
- `<C-c>` (n, i) - Close chat

**Custom Commands:**
- `:cc` - Alias for `:CodeCompanion`

---

## Git Operations

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gb` | n | Git blame |
| `<leader>go` | n | Git browse (open in browser) |
| `<leader>gg` | n | Open Lazygit (if installed) |

---

## Debugging (DAP)

### Debug Control
| Key | Mode | Action |
|-----|------|--------|
| `<leader>db` | n, v | Toggle breakpoint |
| `<leader>dB` | n, v | Breakpoint with condition |
| `<leader>dc` | n, v | Continue / Start debugging |
| `<leader>dt` | n, v | Terminate debugging |
| `<leader>dr` | n, v | Toggle REPL |

### Debug Navigation
| Key | Mode | Action |
|-----|------|--------|
| `<leader>di` | n, v | Step into |
| `<leader>do` | n, v | Step out |
| `<leader>dO` | n, v | Step over |
| `<leader>dC` | n, v | Run to cursor |
| `<leader>dg` | n, v | Go to line (no execute) |
| `<leader>dj` | n, v | Down stack frame |
| `<leader>dk` | n, v | Up stack frame |

### Debug Utilities
| Key | Mode | Action |
|-----|------|--------|
| `<leader>da` | n, v | Run with arguments |
| `<leader>dl` | n, v | Run last debug config |
| `<leader>dp` | n, v | Pause execution |
| `<leader>ds` | n, v | Show session |
| `<leader>dw` | n, v | Debug widgets |

---

## Python Development

| Key | Mode | Action |
|-----|------|--------|
| `<leader>pv` | n | Select Python virtual environment |
| `<leader>pr` | n | Run Python test method (debug) |
| `<leader>pc` | n | Run Python test class (debug) |

**Tools Available:**
- LSP: Pyright (type checking)
- Formatter: Ruff
- Debugger: debugpy (DAP)

---

## PHP/Laravel Development

| Key | Mode | Action |
|-----|------|--------|
| `<leader>la` | n | Laravel Artisan commands |
| `<leader>lr` | n | Laravel Routes |
| `<leader>lm` | n | Laravel Related files |
| `<leader>lc` | n | Make Controller |
| `<leader>lmo` | n | Make Model |
| `<leader>lmi` | n | Make Migration |

**Tools Available:**
- LSP: PHPActor
- Blade syntax support
- Laravel.nvim for navigation

---

## Rust Development

| Key | Mode | Action |
|-----|------|--------|
| `<leader>rc` | n | Rust code actions |
| `<leader>rr` | n | Rust runnables |
| `<leader>rd` | n | Rust debuggables |
| `<leader>rt` | n | Rust tests |
| `<leader>re` | n | Expand Macro |

**Tools Available:**
- LSP: rust-analyzer
- Rustaceanvim for advanced features
- Crates.nvim for Cargo.toml management
- LLDB debugger integration

---

## Aesthetic & Focus

### Zen Mode & Focus
| Key | Mode | Action |
|-----|------|--------|
| `<leader>zz` | n | Toggle Zen Mode (distraction-free) |
| `<leader>z` | n | Alternative Zen Mode toggle |

**Features:**
- Centers window (120 chars width)
- Hides statusline, numbers, signs
- Integrates with Twilight (dims inactive code)
- Notifications on enter/exit

### Matrix Effects
| Key | Mode | Action |
|-----|------|--------|
| `<leader>fml` | n | Make it rain (Matrix animation) |
| `<leader>gol` | n | Game of Life animation |

**Commands:**
- `:CellularAutomaton make_it_rain`
- `:CellularAutomaton game_of_life`

**Close animations:** Press `q`, `<Esc>`, or `<CR>`

### Code Folding
| Key | Mode | Action |
|-----|------|--------|
| `zR` | n | Open all folds |
| `zM` | n | Close all folds |
| `zr` | n | Fold less (open one level) |
| `zm` | n | Fold more (close one level) |
| `zp` | n | Peek folded lines (preview) |
| `zo` | n | Open fold under cursor |
| `zc` | n | Close fold under cursor |

**Features:**
- LSP + Treesitter powered folding
- Shows line count in folded text
- Peek without opening

---

## Miscellaneous

### Mason (Package Manager)
| Key | Mode | Action |
|-----|------|--------|
| `<leader>M` | n | Open Mason |
| `<leader>pm` | n | Package Manager (Mason) |

### Noice (UI)
- Enhanced cmdline (popup centered)
- Animated notifications
- `:Noice` - View message history
- `:Noice last` - View last message
- `:Noice errors` - View errors

### Terminal
| Key | Mode | Action |
|-----|------|--------|
| `<leader>h` | n | Horizontal terminal split |
| `<leader>v` | n | Vertical terminal split |

### Tabs & Buffers
| Key | Mode | Action |
|-----|------|--------|
| `<leader>x` | n | Close buffer |
| `<Tab>` | n | Next buffer |
| `<S-Tab>` | n | Previous buffer |
| `<leader>b` | n | New buffer |

### WhichKey
- Press `<Space>` and wait → Shows all available keybindings
- Hierarchical menu for discovering shortcuts

---

## Visual Features Active

### Auto-highlighting
- **indent-blankline.nvim** - Rainbow indent guides (7 Catppuccin colors)
- **nvim-colorizer.lua** - Live color preview for hex/rgb/hsl codes
- **Scrollbar** - Shows LSP diagnostics, git changes, search results
- **Noice.nvim** - Aesthetic cmdline and notifications

### Smooth Animations
- **neoscroll.nvim** - Smooth scrolling for all movements
- **cellular-automaton.nvim** - Matrix effects and animations

### LSP Indicators
- Error/Warn/Info marks in scrollbar (Catppuccin colors)
- Git add/change/delete indicators
- Virtual text for diagnostics

---

## Tips & Tricks

### Workflow Optimization
1. **Quick Exit Insert Mode:** Use `jk` instead of `Esc`
2. **Command Mode:** Use `;` instead of `:` (faster)
3. **Discover Keybinds:** Press `<Space>` and wait for WhichKey menu
4. **Focus Mode:** `<Space>zz` for deep work sessions
5. **Matrix Break:** `<Space>fml` when tests fail (stress relief)

### AI Assistant Workflow
1. Select code (Visual mode)
2. `<leader>ae` - Ask AI to explain
3. Or `ga` - Add to ongoing chat
4. Use `<leader>aa` for quick actions menu

### Debugging Workflow
1. `<leader>db` - Set breakpoints
2. `<leader>dc` - Start debugging
3. `<leader>di/o/O` - Step through code
4. `<leader>dr` - Open REPL for evaluation
5. `<leader>dt` - Terminate when done

### LSP Workflow
1. `gd` - Jump to definition
2. `K` - Read documentation
3. `<leader>ca` - See available actions
4. `<leader>rn` - Rename across project
5. `gpd` - Preview without jumping

---

## Color Scheme

**Theme:** Catppuccin
- **Change theme:** `:Telescope themes`
- **Base46 cache:** Managed by NvChad

**Custom highlights:**
- Rainbow indent lines (7 colors)
- Scrollbar diagnostics (Red/Yellow/Blue/Cyan)
- Git signs (Green/Orange/Red)

---

## Plugin List (Quick Reference)

**Core:**
- NvChad v2.5 (base configuration)
- Lazy.nvim (plugin manager)
- Treesitter (syntax highlighting)

**LSP & Completion:**
- nvim-lspconfig (LSP support)
- blink.cmp (completion)
- conform.nvim (formatting)
- mason.nvim (LSP/tool installer)

**AI:**
- CodeCompanion (AI assistant)
- GitHub Copilot integration

**Navigation:**
- telescope.nvim / fzf-lua (fuzzy finder)
- oil.nvim (file explorer)
- goto-preview (LSP previews)

**Git:**
- gitsigns.nvim (git indicators)
- git.nvim (git operations)

**Debugging:**
- nvim-dap (Debug Adapter Protocol)
- nvim-dap-ui (debug UI)
- nvim-dap-python (Python debugging)
- nvim-dap-virtual-text (debug info)

**Language Support:**
- rust-tools / rustaceanvim (Rust)
- phpactor / laravel.nvim (PHP/Laravel)
- venv-selector (Python)

**Aesthetic:**
- noice.nvim (UI overhaul)
- nvim-notify (notifications)
- indent-blankline.nvim (rainbow indents)
- nvim-colorizer.lua (color preview)
- zen-mode.nvim (focus mode)
- twilight.nvim (dim inactive code)
- cellular-automaton.nvim (matrix effects)
- neoscroll.nvim (smooth scroll)
- nvim-scrollbar (aesthetic scrollbar)
- nvim-ufo (code folding)

---

## Emergency Commands

**If Something Breaks:**
- `:Lazy sync` - Update/sync all plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy restore` - Restore to lockfile state
- `:checkhealth` - Diagnose issues
- `:Mason` - Check LSP/tool installation

**Reset to Defaults:**
- Delete `~/.local/share/nvim` and `~/.local/state/nvim`
- Reopen Neovim to reinstall

**View Logs:**
- `:Noice` - Message history
- `:messages` - Vim messages
- `:checkhealth noice` - Noice diagnostics

---

## Quick Reference Card

```
┌─────────────────────────────────────────────────────────┐
│  il1v3y's Neovim Quick Reference                        │
├─────────────────────────────────────────────────────────┤
│  LEADER: Space                                          │
│                                                         │
│  FILES:    <leader>ff  Find     <leader>e   Explorer   │
│  SEARCH:   <leader>fw  Grep     /           Search     │
│  LSP:      gd          Goto Def K           Hover      │
│  AI:       <leader>ac  Chat     <leader>aa  Actions    │
│  DEBUG:    <leader>db  Break    <leader>dc  Continue   │
│  GIT:      <leader>gb  Blame    <leader>go  Browse     │
│  FOCUS:    <leader>zz  Zen      <leader>fml Matrix     │
│  FOLD:     zp          Peek     zR/zM       All        │
│                                                         │
│  EXIT INSERT: jk       COMMAND: ;                      │
└─────────────────────────────────────────────────────────┘
```

---

**Last Updated:** 2025-11-05  
**Neovim Version:** 0.10+  
**Config Location:** `~/.config/nvim/`

---

*For the full configuration, see: `~/.config/nvim/lua/plugins/`*
*To add custom keybinds, edit: `~/.config/nvim/lua/mappings.lua`*
