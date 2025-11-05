# Quick Reference Card - Multi-Language Dev Setup

## 🚀 Launch Development Environment

```bash
cd /path/to/project
dev-start  # Auto-detects: Laravel, Python, Rust, or Security project
```

## ⌨️ Essential Keybindings

### Universal (All Languages)
```
<leader>ca   Code Actions (refactoring menu)
<leader>rn   Rename Symbol
<leader>fm   Format Document
gd           Go to Definition
gr           Go to References
K            Documentation Hover
```

### Debugging
```
<leader>db   Toggle Breakpoint
<leader>dB   Conditional Breakpoint
<leader>dc   Continue/Start Debug
<leader>di   Step Into
<leader>do   Step Over
<leader>dt   Terminate Debug
```

### PHP/Laravel
```
<leader>la   Artisan Command Picker
<leader>lr   Routes List
<leader>lm   Related Files
<leader>lc   Make Controller
<leader>lmo  Make Model
<leader>lmi  Make Migration
```

### Python
```
<leader>pv   Select Virtual Environment
<leader>pr   Run Test Method
<leader>pc   Run Test Class
```

### Rust
```
<leader>rc   Rust Code Actions
<leader>rr   Rust Runnables
<leader>rd   Rust Debuggables
<leader>rt   Run Tests
<leader>re   Expand Macro
```

## 🛠️ Mason Commands

```vim
:Mason          Open Mason UI
:MasonInstall phpactor pyright rust-analyzer
:MasonUpdate    Update all servers
```

## 🔍 Health Checks

```vim
:checkhealth mason
:checkhealth lsp
:LspInfo       Show active LSP servers
```

## 📦 Installed LSP Servers

- **PHP:** phpactor (refactoring + IntelliSense)
- **Python:** pyright (type checking)
- **Rust:** rust-analyzer (complete tooling)
- **C:** clangd (exploits/malware analysis)
- **Web:** html-lsp, css-lsp, typescript-language-server
- **Shell:** bash-language-server

## 🐛 Debugging Setup

### PHP (Xdebug)
1. Verify Xdebug: `php -m | grep xdebug`
2. Config: `/etc/php/conf.d/xdebug.ini`
3. Port: 9003

### Python (debugpy)
- Auto-configured via Mason
- Just set breakpoints and press `<leader>dc`

### Rust (LLDB)
- Build with debug: `cargo build`
- Set breakpoints, press `<leader>dc`

## 🌐 Podman Networks (Security Research)

```bash
# Malware analysis (NO INTERNET)
podman run --network malware-isolated ubuntu

# Vulnerable app testing (Internet)
podman run --network vuln-testing dvwa

# General security tools (Internet)
podman run --network sec-tools kalilinux/kali-rolling
```

## 📝 Quick Workflows

### Laravel: Create Feature
```bash
cd ~/laravel-app && dev-start
:Laravel artisan make:controller UserController
<leader>db  # Set breakpoint
# Server pane: php artisan serve
```

### Python: Debug Script
```bash
cd ~/python-project && dev-start
<leader>pv  # Select venv
<leader>db  # Set breakpoint
<leader>dc  # Start debugging
```

### Rust: Run Binary
```bash
cd ~/rust-project && dev-start
<leader>rr  # Show runnables
<leader>rd  # Show debuggables
```

---

**Full Guide:** `~/.config/nvim/WORKFLOW-GUIDE.md`
