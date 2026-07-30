# Editors
export EDITOR=nvim
export VISUAL=nvim

# Host-specific locations
export NVM_DIR="$HOME/.nvm"
export SDKMAN_DIR="$HOME/.sdkman"

# Ghostty
export GHOSTTY_SHELL_FEATURES="title,sudo"

# Deduplicate PATH
typeset -U path PATH

for dir in \
    "$HOME/.local/bin" \
    "$HOME/bin" \
    "$HOME/go/bin" \
    "/usr/local/bin" \
    "/usr/local/go/bin"
do
    [[ -d "$dir" ]] && path=("$dir" $path)
done

for dir in \
    "$HOME/neovim/bin" \
    "$HOME/local/nvim/bin" \
    "$HOME/opt/neovim/bin"
do
    [[ -d "$dir" ]] && path=("$dir" $path) && break
done

export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL/bin" ]] && path=("$BUN_INSTALL/bin" $path)

export PATH
