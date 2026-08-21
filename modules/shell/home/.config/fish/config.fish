# Portable fish config (shell module).
# No CachyOS hard-require, no host paths, no offensive aliases.
# Do not use `set -Ux` here (writes universal fish_variables).

set -gx PATH $HOME/.local/bin $HOME/bin $PATH

if command -q ls
    alias ls 'ls --color=auto'
end

if command -q starship
    starship init fish | source
end

if command -q zoxide
    zoxide init fish | source
end

# Host overlay (not versioned).
set -l fish_local $HOME/.config/fish/local.fish
if test -f $fish_local
    source $fish_local
end
