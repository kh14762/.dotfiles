# ---------------------- Begin Oh My Zsh Config ----------
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"

autoload -U compinit; compinit
source ~/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.plugin.zsh

# Which plugins would you like to load?
plugins=(git fzf-tab)

source $ZSH/oh-my-zsh.sh

# User configuration
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias cat="batcat"
alias vibe='launch_claude'
alias boondev='~/.config/tmux/boonie-dev.sh'
alias vim='nvim'

# Use emacs keybinds
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# @Kevin Heritage

# Git commands
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gco='git checkout'
alias gf='git fetch'
alias gl='lazygit'

# Bat
# Highlight help msgs
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}

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

# bun completions
[ -s "/home/kev/.bun/_bun" ] && source "/home/kev/.bun/_bun"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
