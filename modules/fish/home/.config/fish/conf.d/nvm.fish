# nvm es de bash: este wrapper sirve para `nvm ls`, `nvm install`, etc.
# `nvm use` no cambia el Node de fish (el Node fijo viene de fnm, ver config.fish).
function nvm
    bash -c 'source ~/.nvm/nvm.sh; nvm "$@"' nvm $argv
end
