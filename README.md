# Arch Linux Dotfiles

My personal configuration files for Arch Linux featuring a customized DWM setup with modern terminal tools and development environments.

## System Information

- **OS:** Arch Linux (CachyOS)
- **Kernel:** 6.17.0-3-cachyos
- **WM:** DWM (Dynamic Window Manager)
- **Shell:** Fish / Zsh with Starship prompt
- **Terminal:** Kitty / Alacritty
- **Editor:** Neovim / Doom Emacs
- **Multiplexer:** Tmux

## Included Configurations

### Shell & Terminal
- **Fish** - Modern shell with syntax highlighting and autosuggestions
- **Zsh** - Powerful shell with Zinit plugin manager and Powerlevel10k
- **Starship** - Fast, minimal prompt for any shell
- **Kitty** - GPU-accelerated terminal emulator
- **Alacritty** - Blazing fast, OpenGL terminal emulator
- **Tmux** - Terminal multiplexer configuration

### Window Management
- **DWM** - Suckless dynamic window manager (source code included)
- **Rofi** - Application launcher and window switcher
- **Picom** - Compositor for transparency and effects
- **Dunst** - Lightweight notification daemon

### Development Tools
- **Neovim** - Hyperextensible Vim-based text editor
- **Doom Emacs** - Configuration framework for Emacs
- **Micro** - Modern terminal-based text editor

### System Utilities
- **Fastfetch** - System information tool
- **Btop** - Resource monitor
- **Yazi** - Terminal file manager
- **Zellij** - Modern terminal workspace
- **Cava** - Audio visualizer

### Scripts
- **lockscreen.sh** - Custom screen locking script

## Installation

### Prerequisites

```bash
# Install required packages
sudo pacman -S fish zsh neovim kitty alacritty tmux rofi picom dunst btop starship git stow

# Install AUR packages (optional)
yay -S fastfetch yazi-git zellij
```

### Clone Repository

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Deploy Configurations

#### Method 1: Manual Symlinks

```bash
# Backup your existing configs
mv ~/.config/fish ~/.config/fish.backup
mv ~/.config/nvim ~/.config/nvim.backup

# Create symlinks
ln -s ~/dotfiles/.config/* ~/.config/
ln -s ~/dotfiles/.doom.d ~/.doom.d
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml
cp ~/dotfiles/lockscreen.sh ~/lockscreen.sh
chmod +x ~/lockscreen.sh
```

#### Method 2: Using GNU Stow (Recommended)

```bash
# Install GNU Stow
sudo pacman -S stow

# Stow all configs
cd ~/dotfiles
stow .
```

### Post-Installation

#### Fish Shell
```bash
# Set Fish as default shell
chsh -s $(which fish)

# Install Fisher plugin manager
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

#### Zsh
```bash
# Zinit will auto-install on first launch
# Restart shell after installation
```

#### Doom Emacs
```bash
# Install Doom Emacs
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

# Sync configuration
~/.config/emacs/bin/doom sync
```

#### Tmux
```bash
# Install TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Inside tmux, press: prefix + I to install plugins
```

#### DWM
```bash
# Compile and install DWM
cd ~/.config/dwm
sudo make clean install
```

## Key Features

- **Unified theme** across terminal, editors, and window manager
- **Efficient keybindings** optimized for productivity
- **Plugin management** for Fish (Fisher), Zsh (Zinit), and Tmux (TPM)
- **Modern tooling** with fast, rust-based utilities
- **Version controlled** for easy deployment across machines

## Customization

Feel free to fork and customize these dotfiles to your needs. Key configuration files:

- Shell prompts: `starship.toml`
- Fish config: `.config/fish/config.fish`
- Zsh config: `.config/zsh/.zshrc`
- Neovim: `.config/nvim/init.lua` (or `init.vim`)
- Tmux: `.config/tmux/tmux.conf`
- DWM: `.config/dwm/config.h`

## Updates

To update your dotfiles:

```bash
cd ~/dotfiles
git pull origin main
```

## License

Feel free to use and modify these configurations as you see fit.

## Credits

Configuration inspired by the amazing Arch Linux and dotfiles community.
