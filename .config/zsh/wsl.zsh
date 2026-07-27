if [[ -n "${WSL_DISTRO_NAME:-}" ]]; then

  export WINHOME="c/mnt/Users/u341529"

  for file in ~/.config/zsh/wsl/*.zsh; do
    [[ -r "$file" ]] && source "$file"
  done
fi
