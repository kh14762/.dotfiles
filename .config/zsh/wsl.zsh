if [[ -n "${WSL_DISTRO_NAME:-}" ]]; then
  for file in ~/.config/zsh/wsl/*.zsh; do
    [[ -r "$file" ]] && source "$file"
  done
fi
