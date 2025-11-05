#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════
#  DWM Setup Script - Aesthetic Edition
# ═══════════════════════════════════════════════════════════════════════

# Get script directory and change to it
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || {
    echo "Error: Could not change to script directory"
    exit 1
}

# Color palette
PURPLE='\033[0;35m'
LAVENDER='\033[1;35m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

# Icons
ROCKET="🚀"
SPARKLE="✨"
PACKAGE="📦"
CHECKMARK="✓"
CROSS="✗"
ARROW="➜"
GEAR="⚙"

# Print functions
print_banner() {
    clear
    echo -e "${LAVENDER}"
    cat << "EOF"
    ██████╗ ██╗    ██╗███╗   ███╗
    ██╔══██╗██║    ██║████╗ ████║
    ██║  ██║██║ █╗ ██║██╔████╔██║
    ██║  ██║██║███╗██║██║╚██╔╝██║
    ██████╔╝╚███╔███╔╝██║ ╚═╝ ██║
    ╚═════╝  ╚══╝╚══╝ ╚═╝     ╚═╝
    Dynamic Window Manager Setup
EOF
    echo -e "${RESET}"
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
}

print_step() {
    echo -e "${PURPLE}${ARROW}${RESET} ${BOLD}$1${RESET}"
}

print_success() {
    echo -e "${GREEN}${CHECKMARK}${RESET} $1"
}

print_error() {
    echo -e "${RED}${CROSS}${RESET} $1"
}

print_info() {
    echo -e "${CYAN}${GEAR}${RESET} ${DIM}$1${RESET}"
}

print_section() {
    echo -e "\n${LAVENDER}${SPARKLE} $1 ${SPARKLE}${RESET}"
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

# Function to install dependencies for Debian-based distributions
install_debian() {
    print_step "Updating package repositories..."
    sudo apt update > /dev/null 2>&1
    print_success "Repositories updated"
    
    print_step "Installing DWM dependencies..."
    sudo apt install -y libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev libxext-dev meson ninja-build uthash-dev cmake libxft-dev libimlib2-dev libxinerama-dev libxcb-res0-dev alsa-utils > /dev/null 2>&1
    print_success "Dependencies installed"
}

# Function to install dependencies for Red Hat-based distributions
install_redhat() {
    print_step "Installing development tools..."
    sudo yum groupinstall -y "Development Tools" > /dev/null 2>&1
    print_success "Development tools installed"
    
    print_step "Installing DWM dependencies..."
    sudo yum install -y dbus-devel gcc git libconfig-devel libdrm-devel libev-devel libX11-devel libX11-xcb libXext-devel libxcb-devel libGL-devel libEGL-devel libepoxy-devel meson ninja-build pcre2-devel pixman-devel uthash-devel xcb-util-image-devel xcb-util-renderutil-devel xorg-x11-proto-devel xcb-util-devel cmake libxft-devel libimlib2-devel libxinerama-devel libxcb-res0-devel alsa-utils > /dev/null 2>&1
    print_success "Dependencies installed"
}

# Function to install dependencies for Arch-based distributions
install_arch() {
    print_step "Syncing package databases..."
    sudo pacman -Syu --noconfirm > /dev/null 2>&1
    print_success "System updated"
    
    print_step "Installing DWM dependencies..."
    sudo pacman -S --noconfirm base-devel libconfig dbus libev libx11 libxcb libxext libgl libegl libepoxy meson pcre2 pixman uthash xcb-util-image xcb-util-renderutil xorgproto cmake libxft libimlib2 libxinerama libxcb-res xorg-xev xorg-xbacklight alsa-utils > /dev/null 2>&1
    print_success "Dependencies installed"
}

# Display banner
print_banner

# Detect the distribution and install the appropriate packages
print_section "System Detection"

if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
        debian|ubuntu)
            print_info "Detected: ${BOLD}Debian/Ubuntu${RESET}"
            print_section "Package Installation"
            install_debian
            ;;
        rhel|centos|fedora)
            print_info "Detected: ${BOLD}RHEL/Fedora${RESET}"
            print_section "Package Installation"
            install_redhat
            ;;
        arch|cachyos|endeavouros|manjaro)
            print_info "Detected: ${BOLD}Arch-based Linux${RESET}"
            print_section "Package Installation"
            install_arch
            ;;
        *)
            print_error "Unsupported distribution: $ID"
            exit 1
            ;;
    esac
else
    print_error "/etc/os-release not found"
    exit 1
fi

# Function to install Meslo Nerd font for dwm and rofi icons to work
install_nerd_font() {
    FONT_DIR="$HOME/.local/share/fonts"
    FONT_ZIP="$FONT_DIR/Meslo.zip"
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip"
    FONT_INSTALLED=$(fc-list | grep -i "Meslo")

    if [ -n "$FONT_INSTALLED" ]; then
        print_info "Meslo Nerd Font already installed, skipping..."
        return 0
    fi

    print_step "Installing Meslo Nerd Font..."

    if [ ! -d "$FONT_DIR" ]; then
        mkdir -p "$FONT_DIR" || {
            print_error "Failed to create fonts directory"
            return 1
        }
    fi

    if [ ! -f "$FONT_ZIP" ]; then
        print_info "Downloading font package..."
        wget -q -P "$FONT_DIR" "$FONT_URL" || {
            print_error "Failed to download Nerd Font"
            return 1
        }
    fi

    if [ ! -d "$FONT_DIR/Meslo" ]; then
        print_info "Extracting fonts..."
        unzip -q "$FONT_ZIP" -d "$FONT_DIR" || {
            print_error "Failed to extract fonts"
            return 1
        }
    fi

    rm "$FONT_ZIP" 2>/dev/null

    print_info "Rebuilding font cache..."
    fc-cache -fv > /dev/null 2>&1 || {
        print_error "Failed to rebuild font cache"
        return 1
    }

    print_success "Nerd Font installed successfully"
}

picom_animations() {
    mkdir -p ~/build
    
    if [ ! -d ~/build/picom ]; then
        print_step "Cloning picom with animations..."
        if ! git clone --quiet https://github.com/FT-Labs/picom.git ~/build/picom 2>/dev/null; then
            print_error "Failed to clone picom repository"
            return 1
        fi
        print_success "Repository cloned"
    else
        print_info "Picom repository already exists, skipping clone"
    fi

    cd ~/build/picom || {
        print_error "Failed to access picom directory"
        return 1
    }

    print_step "Building picom (this may take a while)..."
    
    print_info "Running meson setup..."
    if ! meson setup --buildtype=release build > /dev/null 2>&1; then
        print_error "Meson setup failed"
        return 1
    fi

    print_info "Compiling with ninja..."
    if ! ninja -C build > /dev/null 2>&1; then
        print_error "Ninja build failed"
        return 1
    fi

    print_info "Installing picom binary..."
    if ! sudo ninja -C build install > /dev/null 2>&1; then
        print_error "Installation failed"
        return 1
    fi

    print_success "Picom with animations installed"
}

clone_config_folders() {
    [ ! -d ~/.config ] && mkdir -p ~/.config

    print_step "Copying configuration files..."
    
    local count=0
    for dir in config/*/; do
        dir_name=$(basename "$dir")

        if [ -d "$dir" ]; then
            cp -r "$dir" ~/.config/
            print_info "Copied $dir_name"
            ((count++))
        fi
    done
    
    if [ $count -gt 0 ]; then
        print_success "Copied $count configuration folder(s)"
    else
        print_info "No configuration folders to copy"
    fi
}

configure_backgrounds() {
    BG_DIR="$HOME/Pictures/backgrounds"
    DEFAULT_WP="$SCRIPT_DIR/backgrounds/default-wallpaper.jpg"

    print_step "Setting up wallpaper directory..."
    
    if [ ! -d "$HOME/Pictures" ]; then
        mkdir -p "$HOME/Pictures" || {
            print_error "Failed to create Pictures directory"
            return 1
        }
    fi
    
    if [ ! -d "$BG_DIR" ]; then
        mkdir -p "$BG_DIR" || {
            print_error "Failed to create backgrounds directory"
            return 1
        }
        print_success "Created wallpaper directory"
    else
        print_info "Wallpaper directory already exists"
    fi

    # Copy default wallpaper if directory is empty
    if [ -f "$DEFAULT_WP" ]; then
        local wallpaper_count=$(find "$BG_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | wc -l)
        
        if [ "$wallpaper_count" -eq 0 ]; then
            cp "$DEFAULT_WP" "$BG_DIR/" || {
                print_error "Failed to copy default wallpaper"
                return 1
            }
            print_success "Copied default wallpaper"
            print_info "You can add more wallpapers to: $BG_DIR"
        else
            print_info "Wallpapers already present ($wallpaper_count found)"
        fi
    else
        print_info "Place your wallpapers in: $BG_DIR"
    fi
}

# Install Nerd Fonts
print_section "Nerd Fonts Installation"
install_nerd_font

# Copy config folders
print_section "Configuration Setup"
clone_config_folders

# Build and install picom
print_section "Picom Compositor"
picom_animations

# Setup wallpaper directory
print_section "Wallpaper Setup"
configure_backgrounds

# Final message
echo ""
print_section "Installation Complete"
echo -e "${GREEN}${ROCKET} All components installed successfully!${RESET}"
echo -e "${CYAN}Next steps:${RESET}"
echo -e "  ${PURPLE}1.${RESET} Compile DWM: ${BOLD}make && sudo make install${RESET}"
echo -e "  ${PURPLE}2.${RESET} Add wallpapers to ${BOLD}~/Pictures/backgrounds/${RESET}"
echo -e "  ${PURPLE}3.${RESET} Log out and select DWM from your login manager"
echo -e "\n${LAVENDER}${SPARKLE} Happy ricing! ${SPARKLE}${RESET}\n"
