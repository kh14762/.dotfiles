if [[ -n "${WSL_DISTRO_NAME:-}" ]]; then
    export WINHOME="/mnt/c/Users/u341529"
    path=("$HOME/.config/scripts/wsl" $path)
fi
