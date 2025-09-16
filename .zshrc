# ---------------------- Begin Oh My Zsh Config ----------
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"

autoload -U compinit; compinit

plugins=(git nvm fzf-tab)

source $ZSH/oh-my-zsh.sh

# User configuration
# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias cat="batcat"

# Use emacs keybinds
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# @Kevin Heritage

if [ -d "$HOME/neovim/bin:$PATH" ] ; then
    PATH="$HOME/neovim/bin:$PATH"
elif [ -d "$HOME/local/nvim/bin:$PATH" ] ; then
    PATH="$HOME/local/nvim/bin:$PATH"
else
    PATH="$HOME/opt/neovim/bin:$PATH"
fi
alias vim='nvim'

# Git commands
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gco='git checkout'
alias gf='git fetch'
alias gl='lazygit'

# Highlight help msgs
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}

# fzf shell integration
source <(fzf --zsh)

# Setup fzf keybinds
if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi
if [ -f /usr/share/doc/fzf/examples/completion.zsh ]; then
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Set zoxide alias to cd
alias cd="z"
eval "$(zoxide init zsh)"

# Claude tmux launcher
launch_claude() {
    # Check if claude exists
    if [ ! -e claude ]; then
      echo "claude not installed..."
      return 
    fi

    if tmux has-session -t claude 2>/dev/null; then
        if [ -n "$TMUX" ]; then
            tmux switch-client -t claude
        else
            tmux attach-session -t claude
        fi
    else
        if [ -n "$TMUX" ]; then
            tmux new-session -d -s claude 'claude'
            tmux switch-client -t claude
        else
            tmux new-session -d -s claude 'claude'
            tmux attach-session -t claude
        fi
    fi
}

alias vibe='launch_claude'
