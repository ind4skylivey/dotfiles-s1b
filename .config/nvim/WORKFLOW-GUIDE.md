# Multi-Language Professional Workflow Guide

## 🚀 Quick Start

Your Neovim + Zellij setup is now configured for professional development in:
- **PHP/Laravel** - Complete refactoring with PHPActor + Xdebug debugging
- **Python** - Pyright LSP + debugpy + virtual environment management
- **Rust** - rust-analyzer + rustaceanvim + LLDB debugging  
- **C** - clangd (for exploit development)

### Starting a Development Session

```bash
cd /path/to/your/project
dev-start  # Auto-detects project type and launches appropriate layout
```

## 📋 Available Layouts

### Laravel Development
- **Trigger:** Auto-detected when `composer.json` contains `laravel/framework`
- **Layout:** `laravel-dev.kdl`
- **Panes:**
  - Main: Neovim editor (65%)
  - Side Top: Server/Artisan commands (17.5%)
  - Side Bottom: Tests/Tinker (17.5%)
- **Extra Tabs:** Database, Logs

### Python Development
- **Trigger:** Auto-detected when `requirements.txt`, `pyproject.toml`, or `setup.py` exists
- **Layout:** `python-dev.kdl`
- **Panes:**
  - Main: Neovim editor (65%)
  - Side Top: Python REPL (17.5%)
  - Side Bottom: Pytest (17.5%)
- **Extra Tabs:** Venv management

### Rust Development
- **Trigger:** Auto-detected when `Cargo.toml` exists
- **Layout:** `rust-dev.kdl`
- **Panes:**
  - Main: Neovim editor (65%)
  - Side Top: Cargo watch (17.5%)
  - Side Bottom: Tests (17.5%)
- **Extra Tabs:** Build output

### Security Research
- **Trigger:** Auto-detected when git repo contains `exploits`, `payloads`, or `loot` directories
- **Layout:** `security-research.kdl`
- **Panes:**
  - Main: Neovim editor (60%)
  - Side Top: Target terminal (20%)
  - Side Bottom: Listener (20%)
- **Extra Tabs:** Research notes, Tools

## ⌨️ Keybindings

### General LSP (All Languages)

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ca` | Code Actions | Show available code actions (refactoring, fixes) |
| `<leader>rn` | Rename Symbol | Rename variable/function across project |
| `<leader>fm` | Format Document | Format current file |
| `gd` | Go to Definition | Jump to symbol definition |
| `gr` | Go to References | Find all references |
| `K` | Hover Documentation | Show documentation for symbol under cursor |
| `[d` | Previous Diagnostic | Jump to previous error/warning |
| `]d` | Next Diagnostic | Jump to next error/warning |

### PHP/Laravel Specific

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>la` | Laravel Artisan | Open Artisan command picker |
| `<leader>lr` | Laravel Routes | List all routes |
| `<leader>lm` | Laravel Related | Navigate to related files (controller ↔ view) |
| `<leader>lc` | Make Controller | Generate new controller |
| `<leader>lmo` | Make Model | Generate new model |
| `<leader>lmi` | Make Migration | Generate new migration |

### Python Specific

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>pv` | Select VirtualEnv | Choose Python virtual environment |
| `<leader>pr` | Run Test Method | Run current test method |
| `<leader>pc` | Run Test Class | Run entire test class |

### Rust Specific

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>rc` | Rust Code Action | Rust-specific code actions |
| `<leader>rr` | Rust Runnables | Show runnable targets |
| `<leader>rd` | Rust Debuggables | Show debuggable targets |
| `<leader>rt` | Rust Tests | Run tests |
| `<leader>re` | Expand Macro | Expand Rust macro |

### Debugging (All Languages)

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>db` | Toggle Breakpoint | Add/remove breakpoint at current line |
| `<leader>dB` | Conditional Breakpoint | Add breakpoint with condition |
| `<leader>dc` | Continue | Continue execution |
| `<leader>di` | Step Into | Step into function |
| `<leader>do` | Step Over | Step over line |
| `<leader>dO` | Step Out | Step out of function |
| `<leader>dt` | Terminate | Stop debugging session |
| `<leader>dr` | Toggle REPL | Open debug REPL |

## 🔧 PHP/Laravel Features

### Refactoring with PHPActor

PHPActor provides professional refactoring capabilities:

- **Extract Method** - `<leader>ca` → Select "Extract Method"
- **Rename Symbol** - `<leader>rn` on any variable/method/class
- **Complete Constructor** - Auto-generate properties from constructor
- **Implement Contracts** - Auto-implement interface methods
- **Generate Method** - Generate missing methods
- **Add Missing Assignments** - Auto-add class properties

### Debugging with Xdebug

#### Setup Xdebug (if not already configured)

1. **For Valet (local PHP):**
```bash
# Check if Xdebug is installed
php -m | grep xdebug

# If not installed (Arch-based):
sudo pacman -S xdebug

# Configure in /etc/php/conf.d/xdebug.ini:
[xdebug]
zend_extension=xdebug.so
xdebug.mode=debug
xdebug.start_with_request=yes
xdebug.client_host=127.0.0.1
xdebug.client_port=9003
xdebug.idekey=NVIM
```

2. **For Podman containers:** (already configured in podman-compose.yml)

#### Using the Debugger

1. Set breakpoint: `<leader>db` on desired line
2. Start debugging: `<leader>dc`
3. In your browser/terminal, trigger the PHP code
4. Debugger will pause at breakpoint
5. Use step commands to navigate

Available debug configurations:
- **Listen for Xdebug (Valet)** - For local Valet development
- **Listen for Xdebug (Podman)** - For containerized apps
- **Launch currently open script** - For CLI scripts

## 🐍 Python Features

### Virtual Environment Management

```vim
:VenvSelect           " Choose venv from list
:VenvSelectCached     " Use previously selected venv
<leader>pv           " Quick venv selector
```

### Debugging

1. Set breakpoint: `<leader>db`
2. Start debug: `<leader>dc`
3. Python debugger will attach automatically

### Linting & Formatting

- **Ruff** is configured for ultra-fast linting and formatting
- Auto-format on save (if configured in conform.nvim)
- Manual format: `<leader>fm`

## 🦀 Rust Features

### Cargo Integration

```vim
:RustLsp runnables    " Show runnable targets (tests, bins, examples)
:RustLsp debuggables  " Show debuggable targets
:RustLsp expandMacro  " Expand macro under cursor
```

### Crates.nvim

When editing `Cargo.toml`:
- Hover over dependency: Shows latest versions
- Code actions: Update dependencies
- Auto-completion: Dependency names and versions

### Debugging

1. Build with debug symbols: `cargo build`
2. Set breakpoints in code: `<leader>db`
3. Start debugging: `<leader>dc`
4. LLDB will attach to the binary

## 🔒 Security Research Workflow

### Isolated Malware Analysis

Your Podman is configured with 3 networks:

1. **malware-isolated** (172.20.0.0/24) - **NO INTERNET**
   - Use for malware analysis
   - Complete network isolation

2. **vuln-testing** (172.21.0.0/24) - Internet enabled
   - Use for vulnerable application testing
   - Controlled environment for exploit development

3. **sec-tools** (172.22.0.0/24) - Internet enabled
   - General security tools
   - Scanners, utilities

### Example: Analyzing Malware

```bash
cd ~/security/malware-samples
dev-start  # Launches security-research layout

# In the Target pane:
podman run -it --rm --network malware-isolated \
  --security-opt seccomp=unconfined \
  --cap-add=SYS_PTRACE \
  -v $(pwd):/analysis \
  ubuntu:latest bash

# In Neovim: Edit analysis notes
# In Listener pane: Monitor for any connection attempts
```

## 📦 Installing LSP Servers

All LSP servers are managed by Mason. To install/update:

```vim
:Mason                " Open Mason UI
:MasonInstall phpactor pyright rust-analyzer clangd
:MasonUpdate          " Update all installed servers
```

### Verifying Installation

```vim
:checkhealth mason    " Check Mason status
:checkhealth lsp      " Check LSP configuration
:LspInfo              " Show active LSP servers
```

## 🐛 Troubleshooting

### PHPActor Not Working

```bash
# Reinstall PHPActor
:Mason
# Find phpactor, press 'U' to update or 'X' to uninstall then 'i' to reinstall

# Check PHPActor status
:LspInfo  # Should show phpactor is attached to PHP buffers
```

### Python Virtual Environment Not Detected

```bash
# Create venv if it doesn't exist
python -m venv .venv

# In Neovim:
:VenvSelect  # Manually select the venv
```

### Rust Analyzer Slow

```bash
# Clear rust-analyzer cache
rm -rf ~/.cache/rust-analyzer

# Restart Neovim
```

### Xdebug Not Connecting

```bash
# Check Xdebug is enabled
php -m | grep xdebug

# Check Xdebug configuration
php -i | grep xdebug

# Check port 9003 is not blocked
sudo netstat -tlnp | grep 9003

# In Neovim, check DAP status
:lua print(vim.inspect(require('dap').configurations.php))
```

## 🔄 Workflow Examples

### Example 1: Laravel Feature Development

```bash
cd ~/projects/my-laravel-app
dev-start

# Zellij opens with Laravel layout
# In main pane (Neovim):
:Laravel artisan make:controller Api/UserController --resource

# Set breakpoint in controller method: <leader>db
# In server pane:
php artisan serve

# Test endpoint, debugger activates
# Use <leader>di, <leader>do to step through code
```

### Example 2: Python Script with Exploit

```bash
cd ~/security/exploit-dev
dev-start

# Zellij opens with Python layout
# In main pane:
<leader>pv  # Select venv
# Write exploit code
# Set breakpoint: <leader>db
# Run with debugger: <leader>dc
```

### Example 3: Rust Binary Tool

```bash
cd ~/rust/port-scanner
dev-start

# Zellij opens with Rust layout
# In watch pane: cargo watch -x check will auto-run
# In main pane: Edit code
<leader>rc  # Rust code actions (implement trait, etc.)
<leader>rr  # Run specific binary/example
<leader>rt  # Run tests
```

## 📚 Additional Resources

- **PHPActor Docs:** https://phpactor.readthedocs.io/
- **Pyright:** https://github.com/microsoft/pyright
- **rust-analyzer:** https://rust-analyzer.github.io/
- **DAP Protocol:** https://microsoft.github.io/debug-adapter-protocol/

## 🎯 Next Steps

1. Open a Laravel project: `cd ~/projects/laravel-app && dev-start`
2. Test refactoring: Open a controller, press `<leader>rn` to rename a method
3. Test debugging: Set breakpoint with `<leader>db`, start server, trigger breakpoint
4. Try Python: `cd ~/python-project && dev-start`
5. Try Rust: `cd ~/rust-project && dev-start`

---

**Happy Coding! 🚀**

*For questions or issues, check `:checkhealth` and `:LspInfo` in Neovim.*
