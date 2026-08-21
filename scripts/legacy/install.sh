#!/bin/bash

set -e

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

info "Dotfiles Installation Script"
echo "=============================="
echo

if [ ! -d "$DOTFILES_DIR" ]; then
    error "Dotfiles directory not found at $DOTFILES_DIR"
    error "Run bootstrap.sh first, or clone the repo manually:"
    error "  git clone https://github.com/ind4skylivey/dotfiles-s1b.git $DOTFILES_DIR"
    exit 1
fi

cd "$DOTFILES_DIR"

# --- Package Installation ---

info "Checking for required commands..."

if ! command_exists pacman; then
    error "This script is designed for Arch Linux (pacman not found)"
    exit 1
fi

PACKAGES=(
    "fish"
    "zsh"
    "neovim"
    "kitty"
    "alacritty"
    "tmux"
    "rofi"
    "picom"
    "dunst"
    "btop"
    "starship"
    "stow"
    "base-devel"
    "pcmanfm-qt"
    "file-roller"
    "kvantum"
    "qt5ct"
)

read -p "Install essential packages? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    info "Installing packages with pacman..."
    sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"
    success "Essential packages installed"
else
    warning "Skipping package installation"
fi

AUR_PACKAGES=(
    "fastfetch"
    "yazi"
    "zellij"
    "mcmojave-circle-icon-theme"
    "kvmojave-kde-theme"
)

if command_exists yay; then
    read -p "Install AUR packages? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        info "Installing AUR packages..."
        yay -S --needed --noconfirm "${AUR_PACKAGES[@]}"
        success "AUR packages installed"
    else
        warning "Skipping AUR packages"
    fi
else
    warning "yay not found. Skipping AUR packages. Install yay to get: ${AUR_PACKAGES[*]}"
fi

# --- Backup Existing Configs ---

info "Backing up existing configurations..."
mkdir -p "$BACKUP_DIR"

backup_if_exists() {
    local path="$1"
    if [ -e "$path" ] && [ ! -L "$path" ]; then
        info "Backing up $path"
        mv "$path" "$BACKUP_DIR/"
    fi
}

# Back up .config directories
for config_dir in fish zsh nvim kitty alacritty tmux rofi fastfetch btop dunst picom cava micro yazi zellij dwm pcmanfm-qt Kvantum qt5ct waybar warp-terminal helix; do
    backup_if_exists "$HOME/.config/$config_dir"
done

# Back up root-level configs
backup_if_exists "$HOME/.config/starship.toml"
backup_if_exists "$HOME/.doom.d"
backup_if_exists "$HOME/.p10k.zsh"
backup_if_exists "$HOME/.zshrc"
backup_if_exists "$HOME/lockscreen.sh"

success "Backups created in $BACKUP_DIR"

# --- Create Symlinks with Stow ---

read -p "Use GNU Stow for symlinks? (recommended) (Y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    info "Using GNU Stow to create symlinks..."
    
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.local/bin"
    
    cd "$DOTFILES_DIR"
    
    # Remove existing directories that stow would conflict with
    for dir in .config/*/; do
        target="${dir#.config/}"
        if [ -d "$HOME/.config/$target" ] && [ ! -L "$HOME/.config/$target" ]; then
            rm -rf "$HOME/.config/$target"
        fi
    done
    
    if [ -d "$HOME/.doom.d" ] && [ ! -L "$HOME/.doom.d" ]; then
        rm -rf "$HOME/.doom.d"
    fi
    
    stow -v -t "$HOME" \
        --ignore='^\.git.*' \
        --ignore='install.sh' \
        --ignore='bootstrap.sh' \
        --ignore='.gitignore' \
        --ignore='LICENSE' \
        --ignore='CYBERPUNK_SETUP.md' \
        --ignore='ECO_WORKFLOW_GUIDE.md' \
        --ignore='KEYBINDINGS.md' \
        --ignore='KITTY_GUIDE.md' \
        --ignore='README.md' \
        --ignore='README_CYBERPUNK_UPDATE.md' \
        --ignore='SETUP_GUIDE.md' \
        --ignore='ZELLIJ_SETUP.md' \
        --ignore='ZEN_BROWSER_GUIDE.md' \
        .
    
    success "Symlinks created with GNU Stow"
else
    info "Creating manual symlinks..."
    
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.local/bin"
    
    for config_dir in "$DOTFILES_DIR/.config/"*/; do
        config_name=$(basename "$config_dir")
        ln -sf "$config_dir" "$HOME/.config/$config_name"
        info "Linked $config_name"
    done
    
    ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
    ln -sf "$DOTFILES_DIR/.doom.d" "$HOME/.doom.d"
    ln -sf "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
    ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    
    if [ -f "$DOTFILES_DIR/lockscreen.sh" ]; then
        cp "$DOTFILES_DIR/lockscreen.sh" "$HOME/lockscreen.sh"
        chmod +x "$HOME/lockscreen.sh"
    fi
    
    success "Manual symlinks created"
fi

# --- Verify Symlinks ---

info "Verifying symlinks..."
SYMLINK_ERRORS=0

for config_dir in fish zsh nvim kitty alacritty tmux rofi fastfetch btop dunst picom cava micro yazi zellij dwm pcmanfm-qt Kvantum qt5ct waybar warp-terminal helix; do
    if [ -L "$HOME/.config/$config_dir" ]; then
        success "  $config_dir -> $(readlink "$HOME/.config/$config_dir")"
    elif [ -d "$HOME/.config/$config_dir" ]; then
        warning "  $config_dir is a directory (not a symlink)"
    else
        error "  $config_dir is missing"
        SYMLINK_ERRORS=$((SYMLINK_ERRORS + 1))
    fi
done

if [ $SYMLINK_ERRORS -gt 0 ]; then
    warning "Found $SYMLINK_ERRORS symlink issues. Check the output above."
else
    success "All symlinks verified successfully"
fi

# --- Add ~/bin and ~/.local/bin to PATH ---

info "Ensuring ~/bin and ~/.local/bin are in PATH..."

SHELL_RC="$HOME/.config/fish/config.fish"
if [ -f "$SHELL_RC" ]; then
    if ! grep -q 'set -gx PATH.*\$HOME/bin' "$SHELL_RC" 2>/dev/null && ! grep -q 'set -gx PATH.*\.local/bin' "$SHELL_RC" 2>/dev/null; then
        echo '' >> "$SHELL_RC"
        echo '# Add custom bin directories to PATH' >> "$SHELL_RC"
        echo 'set -gx PATH $HOME/bin $HOME/.local/bin $PATH' >> "$SHELL_RC"
        success "Added ~/bin and ~/.local/bin to fish PATH"
    else
        info "PATH entries already exist in fish config"
    fi
fi

ZSH_RC="$HOME/.zshrc"
if [ -f "$ZSH_RC" ]; then
    if ! grep -q 'export PATH.*\$HOME/bin' "$ZSH_RC" 2>/dev/null && ! grep -q 'export PATH.*\.local/bin' "$ZSH_RC" 2>/dev/null; then
        echo '' >> "$ZSH_RC"
        echo '# Add custom bin directories to PATH' >> "$ZSH_RC"
        echo 'export PATH="$HOME/bin:$HOME/.local/bin:$PATH"' >> "$ZSH_RC"
        success "Added ~/bin and ~/.local/bin to zsh PATH"
    else
        info "PATH entries already exist in zsh config"
    fi
fi

# --- Post-Installation Setup ---

info "Running post-installation setup..."

# Fish shell setup
if command_exists fish; then
    info "Setting up Fish shell..."
    
    read -p "Set Fish as default shell? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if ! grep -q "$(which fish)" /etc/shells; then
            echo "$(which fish)" | sudo tee -a /etc/shells >/dev/null
        fi
        chsh -s "$(which fish)"
        success "Fish set as default shell (logout required)"
    fi
    
    info "Installing Fisher plugin manager..."
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher" 2>/dev/null || warning "Fisher installation failed or already installed"
fi

# Tmux plugin manager
if command_exists tmux && [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    info "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
    success "TPM installed. Press 'prefix + I' in tmux to install plugins"
fi

# DWM compilation (AFTER stow so paths are correct)
if [ -d "$HOME/.config/dwm" ]; then
    info "Customizing DWM configuration for current user..."
    
    # Replace hardcoded user paths with current user's home directory
    for file in "$HOME/.config/dwm/config.h" "$HOME/.config/dwm/slstatus/config.h" "$HOME/.config/dwm/scripts/apply-xrandr-layout.sh"; do
        if [ -f "$file" ]; then
            sed -i "s|/home/il1v3y|$HOME|g" "$file"
            info "Updated paths in $(basename $file)"
        fi
    done
    
    read -p "Compile and install DWM? (requires sudo) (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        info "Installing build dependencies..."
        sudo pacman -S --needed --noconfirm libx11 libxinerama libxft freetype2 imlib2
        
        info "Compiling DWM with custom configuration..."
        cd "$HOME/.config/dwm"
        
        # Compile slstatus first if it exists
        if [ -d "slstatus" ]; then
            info "Compiling slstatus..."
            cd slstatus
            make clean && sudo make install
            cd ..
        fi
        
        # Then compile dwm
        info "Compiling dwm..."
        sudo make clean install
        
        # Also install to user path for local testing
        cp dwm "$HOME/.config/dwm/dwm"
        
        success "DWM and slstatus installed successfully"
        success "Autostart will run custom slstatus and xrandr layout script on next session"
        cd "$DOTFILES_DIR"
    fi
fi

# Doom Emacs
if command_exists emacs && [ ! -d "$HOME/.config/emacs" ]; then
    read -p "Install Doom Emacs? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        info "Installing Doom Emacs..."
        git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.config/emacs"
        "$HOME/.config/emacs/bin/doom" install
        success "Doom Emacs installed"
    fi
fi

# --- Personal Projects (Rust) ---

PERSONAL_REPOS=(
    "matteria-track|https://github.com/ind4skylivey/matteria-track.git"
    "iridex-prism-terminal|https://github.com/ind4skylivey/iridex-prism-terminal.git"
)

read -p "Install personal projects (matteria-track, iridex-prism-terminal)? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if ! command_exists cargo; then
        info "Rust/Cargo not found. Installing rustup..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
        success "Rust installed"
    fi

    for repo_entry in "${PERSONAL_REPOS[@]}"; do
        IFS='|' read -r repo_name repo_url <<< "$repo_entry"
        repo_dir="$HOME/code/$repo_name"

        if [ -d "$repo_dir" ]; then
            warning "$repo_name already exists at $repo_dir, skipping"
            continue
        fi

        info "Cloning $repo_name..."
        mkdir -p "$HOME/code"
        git clone "$repo_url" "$repo_dir"
        cd "$repo_dir"

        info "Building $repo_name..."
        if cargo build --release 2>/dev/null; then
            # Install binary to ~/.local/bin
            mkdir -p "$HOME/.local/bin"
            find target/release/ -maxdepth 1 -type f -executable ! -name "*.d" -exec cp {} "$HOME/.local/bin/" \; 2>/dev/null
            success "$repo_name installed to ~/.local/bin/"
        else
            warning "$repo_name build failed. You can build it manually with: cd $repo_dir && cargo build --release"
        fi

        cd "$DOTFILES_DIR"
    done
fi

# --- Final Summary ---

echo
success "=========================================="
success "Dotfiles installation completed!"
success "=========================================="
echo
info "Next steps:"
echo "  1. Logout and login to apply shell changes"
echo "  2. Open tmux and press 'prefix + I' to install plugins"
echo "  3. Open Neovim and run ':Lazy sync'"
if [ -d "$HOME/.config/emacs" ]; then
    echo "  4. Run '~/.config/emacs/bin/doom sync' for Doom Emacs"
fi
echo "  5. Make sure ~/bin and ~/.local/bin are in your PATH"
echo
info "Backup location: $BACKUP_DIR"
echo

exit 0
