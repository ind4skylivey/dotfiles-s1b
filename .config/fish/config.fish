# Source CachyOS Fish configuration
source /usr/share/cachyos-fish-config/cachyos-config.fish

# Set paths
set -Ux PATH $HOME/.cargo/bin $PATH
set -x PATH $PATH ~/.emacs.d/bin
set -gx PATH $HOME/depot_tools $PATH

# Initialize Starship prompt
starship init fish | source


alias ls 'lsd'
alias cat 'bat'
alias vim 'nvim'

