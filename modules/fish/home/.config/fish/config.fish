# ============================================
# Fish config — v3.2 (limpieza 2026-10-06)
# ============================================

# --- GPG TTY (commit signing) ---
set -gx GPG_TTY (command tty)

# --- PATH ---
# Lista global (no universal) y solo con carpetas que existen.
# Se define antes de doom-shell.fish para que su fish_add_path no recree la variable universal.
set -g fish_user_paths
set -l d
for d in \
        $HOME/.nix-profile/bin \
        /nix/var/nix/profiles/default/bin \
        $HOME/.emacs.d/bin \
        $HOME/.local/share/fnm/node-versions/v22.23.2/installation/bin \
        $HOME/.spicetify \
        $HOME/.pyenv/bin \
        $HOME/.pi/bin \
        $HOME/bin \
        $HOME/.cargo/bin \
        $HOME/.config/composer/vendor/bin \
        $HOME/.local/bin \
        /home/linuxbrew/.linuxbrew/bin
    test -d $d; and set -a fish_user_paths $d
end

# --- Doom Emacs (only if it exists) ---
if test -f ~/.config/emacs/doom-shell.fish
    source ~/.config/emacs/doom-shell.fish
end

# --- Prompt / navigation ---
if type -q starship
    starship init fish | source
end
if type -q zoxide
    zoxide init fish --cmd cd | source
end

# --- Basic aliases ---
alias fixmic 'fix-hammerhead-mic'
alias ls 'lsd'
alias cat 'bat --paging=never'
alias vim 'nvim'

set -gx LS_COLORS "di=01;34:ln=01;36:ex=01;32:ow=01;36:st=01;35:tw=01;36"

# ============================================
# Containers / security
# ============================================
# Docker real (daemon del sistema): aquí corre el laboratorio sec-* (traefik, wazuh, crowdsec…).
# Podman (lerd, etc.) se usa con los alias pod*.
alias docker '/usr/bin/docker'
alias docker-compose '/usr/bin/docker compose'
set -gx DOCKER_HOST "unix:///var/run/docker.sock"

alias pod 'podman'
alias podi 'podman images'
alias podps 'podman ps -a'
alias podrm 'podman rm'
alias podrmi 'podman rmi'
alias podclean 'podman system prune -af --volumes'
alias podstats 'podman stats --no-stream'

alias malware-box 'podman run -it --rm --security-opt seccomp=unconfined --cap-add=SYS_PTRACE --network malware-isolated --name malware-analysis'
alias kali 'podman run -it --rm --network host --privileged kalilinux/kali-rolling /bin/bash'

alias codex-run 'codex-container run'
alias codex-shell 'codex-container shell'
alias codex-clean 'codex-container clean'

# --- PYENV ---
set -gx PYENV_ROOT $HOME/.pyenv
if status is-interactive; and type -q pyenv
    pyenv init - --no-rehash fish | source   # sin rehash en cada shell
    pyenv virtualenv-init - fish | source
end

# --- Projects ---
alias mtrack 'materiatrack'

if test -f "$HOME/.config/prism/prism.fish"
    source "$HOME/.config/prism/prism.fish"
end

# --- SSH agent: el de systemd --user (ssh-agent.service), uno solo para toda la sesión ---
if set -q XDG_RUNTIME_DIR; and test -S "$XDG_RUNTIME_DIR/ssh-agent.socket"; and not set -q SSH_CONNECTION
    set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
end
if status is-interactive; and set -q SSH_AUTH_SOCK
    ssh-add -l >/dev/null 2>&1; or ssh-add ~/.ssh/id_ed25519 ~/.ssh/id_ed25519_bitflow 2>/dev/null
end

# --- TidaLuna ---
function tu
    "/media/$USER/HD2/Scripts & Tools/tidaluna-update" $argv
end
function tu-force
    "/media/$USER/HD2/Scripts & Tools/tidaluna-update" --force $argv
end

# --- Ollama Vulkan ---
function ollama-start
    "/media/$USER/HD2/Scripts & Tools/vulkna Ollama/ollama-start.sh" $argv
end
function ollama-chat
    python3 "/media/$USER/HD2/Scripts & Tools/vulkna Ollama/ollama-chat-interactive.py" $argv
end

function zoxide-boost
    "/media/$USER/HD2/Scripts & Tools/zoxide-boost.sh" $argv
end

# --- Greeting / fastfetch ---
function fish_greeting
    set -l c1 (set_color brgreen)
    set -l c2 (set_color brblue)
    set -l c3 (set_color brcyan)
    set -l c0 (set_color normal)
    echo $c3'┌─['$c2$USER$c3'@'(hostname)$c3']'
    echo $c3'│'
    echo $c3'└─➤ '$c1(uname -sr)$c0' '$c2'['$c3'{~} livey@arch ⚡ session ready'$c2']'
    echo $c1'  > access granted. happy hacking.'$c0
end
if status is-interactive; and type -q ff
    ff
end

# --- Engram backup ---
function engram-backup
    cd ~/.engram; and engram export; and git add .
    and git commit -m "sync "(date +%Y-%m-%d); and git push
end

# --- GitHub profile switch ---
if type -q gh-profile-cd
    gh-profile-cd
end


alias vibe "$HOME/.vibe/launch_vibe.sh"

set -gx PI 3.141592653589793

# workmux (git worktrees + tmux)
alias wm workmux

# --- Pi MCP + switch_model ---
if status is-interactive; and type -q pi-mcp-env
    # pi-mcp-env imprime `export KEY=val` (bash); lo convertimos a set -gx
    for line in (pi-mcp-env shell 2>/dev/null)
        set -l m (string match -r '^export ([A-Za-z_][A-Za-z0-9_]*)=(.*)$' -- $line)
        if test (count $m) -ge 3
            set -l val (string trim -c "'" -- $m[3])
            set -gx $m[2] $val
        end
    end
end
if test -x $HOME/.pi/bin/switch_model
    alias switch_model '$HOME/.pi/bin/switch_model'
end

# --- Limpieza final del PATH: sin duplicados ni carpetas inexistentes ---
set -l clean_path
for d in $PATH
    if test -d "$d"; and not contains -- $d $clean_path
        set -a clean_path $d
    end
end
set -gx PATH $clean_path
