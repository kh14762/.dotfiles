#!/usr/bin/env zsh

set -euo pipefail

SCRIPTS_DIR="${XDG_CONFIG_HOME:-$HOME/.config/scripts}"

FAV_FILE="$SCRIPTS_DIR/wifi-favorites"
LAST_FILE="$SCRIPTS_DIR/wifi-last"

STAR="★"

mkdir -p "$SCRIPTS_DIR"
touch "$FAV_FILE"
touch "$LAST_FILE"

SELF="$(realpath "$0")"

###############################################################################
# Scan visible Wi-Fi networks from Windows
###############################################################################

get_networks() {
    powershell.exe -NoProfile -Command '
        netsh wlan show networks |
            Select-String "SSID [0-9]+ :" |
            ForEach-Object {
                ($_ -replace "^.*SSID [0-9]+ :\s*", "").Trim()
            } |
            Where-Object { $_ -ne "" } |
            Sort-Object -Unique
    ' | tr -d "\r"
}

###############################################################################
# Helpers
###############################################################################

strip_star() {
    local value="$1"

    if [[ "$value" == "$STAR "* ]]; then
        printf '%s\n' "${value#"$STAR "}"
    else
        printf '%s\n' "$value"
    fi
}

###############################################################################
# Build menu list
#
# Order:
#   1. Last selected network (always first)
#   2. Remaining favorites
#   3. Visible non-favorites
#
# Last selected remains visible even if currently out of range.
###############################################################################

list_networks() {
    local scan_file
    local last_ssid

    scan_file="$(mktemp)"
    last_ssid="$(cat "$LAST_FILE" 2>/dev/null || true)"

    get_networks > "$scan_file"

    #
    # Last selected network goes first
    #
    if [[ -n "$last_ssid" ]]; then
        if grep -Fxq "$last_ssid" "$FAV_FILE"; then
            printf '%s %s\n' "$STAR" "$last_ssid"
        else
            printf '%s\n' "$last_ssid"
        fi
    fi

    #
    # Remaining favorites
    #
    while IFS= read -r fav; do
        [[ -z "$fav" ]] && continue
        [[ "$fav" == "$last_ssid" ]] && continue

        printf '%s %s\n' "$STAR" "$fav"
    done < "$FAV_FILE"

    #
    # Visible non-favorites
    #
    while IFS= read -r ssid; do
        [[ -z "$ssid" ]] && continue
        [[ "$ssid" == "$last_ssid" ]] && continue

        if ! grep -Fxq "$ssid" "$FAV_FILE"; then
            printf '%s\n' "$ssid"
        fi
    done < "$scan_file"

    rm -f "$scan_file"
}

###############################################################################
# Favorites
###############################################################################

add_favorite() {
    local ssid="$1"

    [[ -z "$ssid" ]] && exit 0

    grep -Fxq "$ssid" "$FAV_FILE" && exit 0

    printf '%s\n' "$ssid" >> "$FAV_FILE"

    sort -u "$FAV_FILE" -o "$FAV_FILE"
}

remove_favorite() {
    local ssid="$1"

    [[ -z "$ssid" ]] && exit 0

    grep -Fvx "$ssid" "$FAV_FILE" > "${FAV_FILE}.tmp" || true
    mv "${FAV_FILE}.tmp" "$FAV_FILE"
}

###############################################################################
# Connection
###############################################################################

connect_wifi() {
    local ssid="$1"

    [[ -z "$ssid" ]] && exit 1

    #
    # Remember selection before connecting.
    #
    printf '%s\n' "$ssid" > "$LAST_FILE"

    powershell.exe -NoProfile -Command "
        netsh wlan connect name=\"$ssid\"
    " >/dev/null

    echo "Connecting to: $ssid"
}

###############################################################################
# Command modes used by fzf
###############################################################################

case "${1:-}" in

    --list)
        list_networks
        exit 0
        ;;

    --favorite)
        ssid="$(strip_star "${2:-}")"
        add_favorite "$ssid"
        exit 0
        ;;

    --unfavorite)
        ssid="$(strip_star "${2:-}")"
        remove_favorite "$ssid"
        exit 0
        ;;

    --connect)
        ssid="$(strip_star "${2:-}")"
        connect_wifi "$ssid"
        exit 0
        ;;

esac

###############################################################################
# Main Menu
###############################################################################

selection="$(
    "$SELF" --list |
    fzf \
        --height=75% \
        --layout=reverse \
        --border \
        --prompt='wifi> ' \
        --header='ENTER=connect | CTRL-F=favorite | CTRL-X=remove favorite' \
        --bind='start:pos(1)' \
        --bind="ctrl-f:execute-silent($SELF --favorite {})+reload($SELF --list)" \
        --bind="ctrl-x:execute-silent($SELF --unfavorite {})+reload($SELF --list)"
)"

[[ -z "${selection:-}" ]] && exit 0

exec "$SELF" --connect "$selection"
