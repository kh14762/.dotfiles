# Neovim
if [ -d "$HOME/neovim/bin:$PATH" ] ; then
    PATH="$HOME/neovim/bin:$PATH"
elif [ -d "$HOME/local/nvim/bin:$PATH" ] ; then
    PATH="$HOME/local/nvim/bin:$PATH"
else
    PATH="$HOME/opt/neovim/bin:$PATH"
fi

# Golang
export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"

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

