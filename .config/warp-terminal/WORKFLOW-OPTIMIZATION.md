# Warp Terminal Optimization para Red Team Dev & Full Stack

## Tu Perfil (ind4skylivey)
- **Rol**: Red Team Operator + Full Stack Developer
- **Stack**: Python, PHP, Rust, C, Bash
- **Especialidades**: Exploit development, malware analysis, reverse engineering
- **Frameworks**: Laravel (PHP), Vue.js, Rust async
- **Herramientas**: Burp, Ghidra, Radare2, Metasploit

---

## 1. ALIASES OPTIMIZADOS PARA TU WORKFLOW

Añade a tu `~/.zshrc` o `~/.bashrc`:

```bash
# ========== RED TEAM OPERATIONS ==========
alias recon='nmap -sV -sC -T4'
alias stealth-scan='nmap -sS -T2 -f'
alias full-enum='nmap -p- -sV -sC -O'
alias web-scan='gobuster dir -u'
alias check-vulns='searchsploit'

# ========== EXPLOIT DEVELOPMENT ==========
alias rop-search='ropper -f'
alias pattern-gen='python3 -c "from pwn import *; print(cyclic(256))"'
alias shellcode-gen='msfvenom -p linux/x64/shell_reverse_tcp'
alias gdb-debug='gdb-peda'

# ========== MALWARE ANALYSIS ==========
alias strings-hunt='strings'
alias bin-analyze='file && objdump -d'
alias strace-monitor='strace -f -e trace=network,file'
alias ltrace-monitor='ltrace -C'

# ========== FULL STACK DEV ==========
alias php-server='php -S localhost:8000'
alias rust-check='cargo clippy'
alias rust-build='cargo build --release'
alias py-serve='python3 -m http.server 8000'

# ========== DOCKER/SECURITY LAB ==========
alias malware-box='podman run -it --rm --network malware-isolated'
alias sec-lab='podman run -it --rm --network sec-tools'
alias kali='docker run -it --rm kalilinux/kali-rolling'

# ========== GIT & PROJECT MANAGEMENT ==========
alias gstash='git stash'
alias gpush-force='git push --force-with-lease'
alias gcommit-amend='git commit --amend --no-edit'
alias check-diffs='git diff && git diff --cached'

# ========== QUICK PENETRATION TESTING ==========
alias burp='burpsuite > /dev/null 2>&1 & disown'
alias ghidra='ghidra > /dev/null 2>&1 & disown'
alias sqlmap-quick='sqlmap -u'
alias xss-check='grep -ri "innerHTML\|eval\|document.write"'

# ========== SECURITY SCANNING ==========
alias scan-secrets='git diff | grep -iE "password|api_key|secret|token|private_key|aws_|bearer"'
alias scan-commit='git diff --cached | grep -iE "password|api_key|secret|token"'
alias scan-leaks='trufflehog git file:///'

# ========== CUSTOM UTILS ==========
alias whoami-info='whoami && hostname && pwd && id'
alias net-listen='ss -tulpn | grep LISTEN'
alias ps-watch='watch -n 1 ps aux'
```

---

## 2. TEMAS RECOMENDADOS POR CONTEXTO

### Para Operaciones Ofensivas (Red Team):
```
→ Red Team Operator (aggressive red/gold)
→ Breach Protocol (Matrix-style neon green)
```

### Para Análisis de Malware:
```
→ Penetration Test (purple/dark theme)
→ Cyberpunk Pastel (atmospheric, reduces eye strain)
```

### Para Full Stack Dev:
```
→ Rosé Pastel (calming, code-friendly)
→ Cyberpunk Pastel (hacker vibe but readable)
```

---

## 3. CONFIGURACIÓN DE WARP RECOMENDADA

### Settings → Appearance
- **Font Size**: 13-14 (tu actual 13 es buena)
- **Zoom**: 125% (mantienes)
- **Spacing**: Compact (actual, perfecto)
- **Theme**: Alterna según contexto

### Settings → Keybindings (ADICIONALES)
```yaml
# Divide panes rápidamente
"pane:split_pane_right": ctrl-shift-d
"pane:split_pane_down": ctrl-shift-e

# Búsqueda en historial para exploit development
"search:search_history": ctrl-r

# Comando palette para comandos custom
"command_palette:open": ctrl-p
```

### Settings → Workflows
Crear workflows personalizados para:
1. **Penetration Testing Flow**
   - Abre 3 panes: reconocimiento | explotación | post-exploitation
   
2. **Development Flow**
   - Pane 1: Editor + git
   - Pane 2: Build/tests
   - Pane 3: Server/logs

3. **Malware Analysis Flow**
   - Pane 1: Ghidra/Radare2
   - Pane 2: Strace/ltrace
   - Pane 3: Radare2 console

---

## 4. COMMAND PALETTE CUSTOM (para Warp)

En `~/.config/warp-terminal/commands.json`:

```json
{
  "commands": [
    {
      "name": "Scan Network",
      "command": "nmap -sV -sC -T4"
    },
    {
      "name": "Start PHP Dev Server",
      "command": "cd ~/projects && php -S localhost:8000"
    },
    {
      "name": "Rust Release Build",
      "command": "cargo build --release && echo 'Build complete'"
    },
    {
      "name": "Check for Leaks",
      "command": "git diff --cached | grep -iE 'password|api_key|secret|token'"
    },
    {
      "name": "Malware Analysis Box",
      "command": "podman run -it --rm --network malware-isolated ubuntu:latest"
    },
    {
      "name": "Start Security Lab",
      "command": "docker run -it --rm kalilinux/kali-rolling"
    }
  ]
}
```

---

## 5. AGENT MODE OPTIMIZATION

Usa el **Warp Agent Mode** para:

### Red Team Operations
```
"Automate nmap scanning workflow"
→ Agent ejecuta reconocimiento → analiza resultados → sugiere exploits
```

### Full Stack Development
```
"Setup Laravel + Rust project"
→ Agent crea estructura, instala deps, configura testing
```

### Exploit Development
```
"Generate PoC for CVE-XXXX"
→ Agent busca detalles, crea template, genera payloads
```

---

## 6. INTEGRATED WORKFLOW EXAMPLE

### Sesión Típica de Red Team:

```bash
# 1. Abre Warp con Red Team Operator theme
warp

# 2. Split de panes (ctrl-shift-d)
# Pane 1: Reconocimiento
recon 192.168.1.0/24

# 3. En Pane 2 (ctrl-shift-right → ctrl-shift-d)
# Inicia Burp
burp

# 4. En Pane 3
# Prepara exploits
cd ~/security/exploits
ls -la
```

### Sesión Típica de Full Stack:

```bash
# 1. Tema Cyberpunk Pastel (menos cansador)
warp

# 2. Split panes (dev | tests | logs)
# Pane 1: IDE + git
cd ~/projects/int3rceptor
code .

# Pane 2: Build
cargo watch -x "check --color always"

# Pane 3: Server
npm run dev
```

---

## 7. INTEGRATION CON MCP & HOOKS

### Pre-commit Hook (Security Check)
```bash
#!/bin/bash
# ~/.git/hooks/pre-commit
echo "Scanning for secrets..."
git diff --cached | grep -iE "password|api_key|secret|token|bearer" && {
  echo "⚠️  Secrets detected! Aborting commit."
  exit 1
}
echo "✓ No secrets found. Safe to commit."
```

### Custom Droid para Red Team
```bash
droid "analyze-binary" /path/to/binary
# Ejecuta automáticamente: file → strings → objdump → radare2
```

---

## 8. PERFORMANCE TIPS

1. **Use Agent Mode para investigación rápida**
   - "Find exploit for OpenSSL 1.1.1k"
   - Agent busca, filtra resultados

2. **Setup Command Aliases al iniciar**
   - Los aliases ya están en .zshrc
   - Source automáticamente en cada sesión

3. **Usa split panes para contextualización**
   - Mantén historial visible
   - Monitorea múltiples procesos

4. **Combine temas por contexto**
   - Red Team Operator para ofensivas
   - Rosé Pastel para dev calmado

---

## 9. RECOMENDACIONES FINALES

✅ **Haz**
- Usa aliases para reducir escritura
- Split panes para múltiples contextos
- Workflows predefinidos para sesiones comunes
- Agent Mode para investigación rápida

❌ **Evita**
- Escribir comandos completos cada vez
- Perder contexto al cambiar panes
- Usar theme agresivo durante coding largo
- Dejar secrets en comandos visibles

---

**Tu setup está optimizado para:**
- OSCP-like penetration testing workflows
- Exploit development rápido
- Full stack development (PHP + Vue + Rust)
- Malware analysis y reverse engineering
- Red team operations automatizadas

¡Listo para operar! 🔴
