# XDG base directories
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Neovim
if [ -d "$HOME/neovim/bin:$PATH" ] ; then
    PATH="$HOME/neovim/bin:$PATH"
elif [ -d "$HOME/local/nvim/bin:$PATH" ] ; then
    PATH="$HOME/local/nvim/bin:$PATH"
else
    PATH="$HOME/opt/neovim/bin:$PATH"
fi
# Setup neovim as default directories
export EDITOR="$(which nvim)"
export VISUAL="$EDITOR"

# Local scripts.
export PATH="$HOME/.local/bin:$PATH"

# Golang
export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"

# zsh configuration
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# set PATH so it inculdes the system's bin if it exits
if [ -d "/usr/local/bin" ] ; then
    PATH="/usr/local/bin:$PATH"
fi
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Node nersion manager
export NVM_DIR="$HOME/.nvm"

# Don't let Ghostty mess up with the cursor.
export GHOSTTY_SHELL_FEATURES="title,sudo"
