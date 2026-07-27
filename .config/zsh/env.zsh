# Editor
export EDITOR=nvim
export VISUAL=nvim

# Terminal
export TERM=xterm-256color
export COLORTERM=truecolor

# Host-specific locations
export NVM_DIR="$HOME/.nvm"
export SDKMAN_DIR="$HOME/.sdkman"

# Path setup
path=(
    "$HOME/.local/bin"
    "$HOME/bin"
    "$HOME/opt/fzf/bin"
    "/usr/local/bin"
    "$HOME/go/bin"
    "/usr/local/go/bin"
    $path
)

# Neovim
for dir in \
    "$HOME/neovim/bin" \
    "$HOME/local/nvim/bin" \
    "$HOME/opt/neovim/bin"
do
    [[ -d "$dir" ]] && path=("$dir" $path) && break
done

# Bun
export BUN_INSTALL="$HOME/.bun"
path=("$BUN_INSTALL/bin" $path)

# WSL-specific settings
if grep -qi microsoft /proc/version 2>/dev/null; then
    export WINHOME="/mnt/c/Users/u341529"
    path=("$HOME/.config/scripts/wsl" $path)
fi

# Ghostty
export GHOSTTY_SHELL_FEATURES="title,sudo"

# FZF
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
"

# Export path array as PATH
export PATH
