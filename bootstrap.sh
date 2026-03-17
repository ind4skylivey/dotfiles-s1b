#!/bin/bash

set -e

DOTFILES_REPO="https://github.com/ind4skylivey/dotfiles-s1b.git"
DOTFILES_DIR="$HOME/dotfiles"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

info "Dotfiles Bootstrap Script"
echo "=========================="
echo

if ! command -v git >/dev/null 2>&1; then
    error "Git is not installed. Installing git..."
    sudo pacman -S --noconfirm git
fi

if [ -d "$DOTFILES_DIR" ]; then
    error "Dotfiles directory already exists at $DOTFILES_DIR"
    read -p "Do you want to remove it and clone fresh? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$DOTFILES_DIR"
    else
        exit 1
    fi
fi

info "Cloning dotfiles repository..."
git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
success "Repository cloned to $DOTFILES_DIR"

info "Running installation script..."
cd "$DOTFILES_DIR"
chmod +x install.sh
./install.sh

exit 0
