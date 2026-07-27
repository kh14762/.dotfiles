dex() {
  if [[ $# -eq 1 ]]; then
    docker exec -it "$1" sh
  else
    docker exec -it "$@"
  fi
}

y() {
  local tmp cwd

  tmp="$(mktemp -t yazi-cwd.XXXXXX)"

  command yazi "$@" --cwd-file="$tmp"

  IFS= read -r -d '' cwd < "$tmp"

  if [[ "$cwd" != "$PWD" && -d "$cwd" ]]; then
    builtin cd -- "$cwd"
  fi

  rm -f -- "$tmp"
}
