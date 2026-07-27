# Completion system
autoload -Uz compinit
compinit

# Load custom config
for file in ~/.config/zsh/*.zsh; do
  [[ -r "$file" ]] && source "$file"
done


