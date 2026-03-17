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

info "Starting dotfiles installation..."

if [ ! -d "$DOTFILES_DIR" ]; then
    error "Dotfiles directory not found at $DOTFILES_DIR"
    exit 1
fi

cd "$DOTFILES_DIR"

info "Checking for required commands..."

if ! command_exists pacman; then
    error "This script is designed for Arch Linux (pacman not found)"
    exit 1
fi

if ! command_exists git; then
    error "Git is not installed. Please install git first: sudo pacman -S git"
    exit 1
fi

info "Installing essential packages..."

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

info "Backing up existing configurations..."
mkdir -p "$BACKUP_DIR"

backup_if_exists() {
    local path="$1"
    if [ -e "$path" ] && [ ! -L "$path" ]; then
        info "Backing up $path"
        mv "$path" "$BACKUP_DIR/"
    fi
}

backup_if_exists "$HOME/.config/fish"
backup_if_exists "$HOME/.config/zsh"
backup_if_exists "$HOME/.config/nvim"
backup_if_exists "$HOME/.config/kitty"
backup_if_exists "$HOME/.config/alacritty"
backup_if_exists "$HOME/.config/tmux"
backup_if_exists "$HOME/.config/rofi"
backup_if_exists "$HOME/.config/fastfetch"
backup_if_exists "$HOME/.config/btop"
backup_if_exists "$HOME/.config/dunst"
backup_if_exists "$HOME/.config/picom"
backup_if_exists "$HOME/.config/cava"
backup_if_exists "$HOME/.config/micro"
backup_if_exists "$HOME/.config/yazi"
backup_if_exists "$HOME/.config/zellij"
backup_if_exists "$HOME/.config/dwm"
backup_if_exists "$HOME/.config/pcmanfm-qt"
backup_if_exists "$HOME/.config/Kvantum"
backup_if_exists "$HOME/.config/qt5ct"
backup_if_exists "$HOME/.config/starship.toml"
backup_if_exists "$HOME/.doom.d"
backup_if_exists "$HOME/lockscreen.sh"

success "Backups created in $BACKUP_DIR"

read -p "Use GNU Stow for symlinks? (recommended) (Y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    info "Using GNU Stow to create symlinks..."
    
    mkdir -p "$HOME/.config"
    
    cd "$DOTFILES_DIR"
    
    for dir in .config/*/; do
        target="${dir#.config/}"
        if [ -d "$HOME/.config/$target" ] && [ ! -L "$HOME/.config/$target" ]; then
            rm -rf "$HOME/.config/$target"
        fi
    done
    
    if [ -d "$HOME/.doom.d" ] && [ ! -L "$HOME/.doom.d" ]; then
        rm -rf "$HOME/.doom.d"
    fi
    
    stow -v -t "$HOME" --ignore='^\.git.*' --ignore='README.md' --ignore='SETUP_GUIDE.md' --ignore='install.sh' --ignore='bootstrap.sh' --ignore='.gitignore' .
    
    success "Symlinks created with GNU Stow"
else
    info "Creating manual symlinks..."
    
    mkdir -p "$HOME/.config"
    
    for config_dir in "$DOTFILES_DIR/.config/"*/; do
        config_name=$(basename "$config_dir")
        if [ "$config_name" != "starship.toml" ]; then
            ln -sf "$config_dir" "$HOME/.config/$config_name"
            info "Linked $config_name"
        fi
    done
    
    ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
    ln -sf "$DOTFILES_DIR/.doom.d" "$HOME/.doom.d"
    
    if [ -f "$DOTFILES_DIR/lockscreen.sh" ]; then
        cp "$DOTFILES_DIR/lockscreen.sh" "$HOME/lockscreen.sh"
        chmod +x "$HOME/lockscreen.sh"
    fi
    
    success "Manual symlinks created"
fi

info "Running post-installation setup..."

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

if command_exists tmux && [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    info "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
    success "TPM installed. Press 'prefix + I' in tmux to install plugins"
fi

if [ -d "$HOME/.config/dwm" ]; then
    read -p "Compile and install DWM? (requires sudo) (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        info "Compiling DWM..."
        cd "$HOME/.config/dwm"
        sudo make clean install
        success "DWM installed"
        cd "$DOTFILES_DIR"
    fi
fi

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

echo
success "=========================================="
success "Dotfiles installation completed!"
success "=========================================="
echo
info "Next steps:"
echo "  1. Logout and login to apply shell changes"
echo "  2. Open tmux and press 'prefix + I' to install plugins"
echo "  3. Open Neovim and run ':PackerSync' or ':Lazy sync' (depending on your config)"
if [ -d "$HOME/.config/emacs" ]; then
    echo "  4. Run '~/.config/emacs/bin/doom sync' for Doom Emacs"
fi
echo
info "Backup location: $BACKUP_DIR"
echo

exit 0
