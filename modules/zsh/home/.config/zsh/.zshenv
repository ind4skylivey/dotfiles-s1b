# ~/.config/zsh/.zshenv — todos los zsh (incluido el login de SDDM → niri)
# typeset -U evita duplicados cuando wayland-session + niri-session hacen zsh -l dos veces.
typeset -U path PATH
path=("$HOME/.local/bin" "$HOME/.cargo/bin" $path)
export PATH
