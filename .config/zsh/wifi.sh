wifi() {
  local usage_file="$HOME/.config/bash/wifi/.wifi_usage"

  mkdir -p "$(dirname "$usage_file")"
  touch "$usage_file"

  # Refresh scan
  nmcli device wifi rescan >/dev/null 2>&1

  local current_ssid
  current_ssid=$(
    nmcli -t -f ACTIVE,SSID device wifi |
      grep '^yes:' |
      head -n1 |
      cut -d: -f2-
  )

  declare -A favorite_map
  declare -A seen

  # Load favorites/history
  while read -r count ssid; do
    [[ -n "$ssid" ]] && favorite_map["$ssid"]="$count"
  done <"$usage_file"

  local menu=()

  # History first (highest count first)
  while read -r ssid; do
    [[ -z "$ssid" ]] && continue

    if [[ -z "${seen[$ssid]}" ]]; then
      seen["$ssid"]=1
      menu+=("★ $ssid")
    fi
  done < <(
    sort -rn "$usage_file" 2>/dev/null |
      cut -d' ' -f2-
  )

  # Currently visible networks
  while read -r ssid; do
    [[ -z "$ssid" ]] && continue

    if [[ -z "${seen[$ssid]}" ]]; then
      seen["$ssid"]=1
      menu+=("$ssid")
    fi
  done < <(
    nmcli -t -f SSID device wifi list | sed '/^$/d'
  )

  [[ ${#menu[@]} -eq 0 ]] && {
    echo "No Wi-Fi networks found."
    return 1
  }

  local selected
  selected=$(
    printf '%s\n' "${menu[@]}" |
      fzf \
        --expect=ctrl-x \
        --header="Enter: Connect | Ctrl-X: Remove Favorite" \
        --preview '
                ssid=$(echo {} | sed "s/^★ //")

                echo "SSID: $ssid"
                echo

                nmcli -f SSID,SIGNAL,SECURITY device wifi list |
                grep -F "$ssid" | head -1
            '
  )

  [[ -z "$selected" ]] && return

  local key
  local ssid

  key=$(head -n1 <<<"$selected")
  ssid=$(tail -n1 <<<"$selected")

  ssid="${ssid#★ }"

  #
  # Remove favorite
  #
  if [[ "$key" == "ctrl-x" ]]; then
    local tmp
    tmp=$(mktemp)

    while read -r count name; do
      [[ "$name" == "$ssid" ]] && continue
      echo "$count $name"
    done <"$usage_file" >"$tmp"

    mv "$tmp" "$usage_file"
    wifi
    return
  fi

  #
  # Connect
  #
  if nmcli connection show "$ssid" >/dev/null 2>&1; then
    nmcli connection up "$ssid"
  else
    nmcli device wifi connect "$ssid"
  fi

  #
  # Update history
  #
  local tmp
  tmp=$(mktemp)

  local found=0

  while read -r count name; do
    [[ -z "$name" ]] && continue

    if [[ "$name" == "$ssid" ]]; then
      echo "$((count + 1)) $name" >>"$tmp"
      found=1
    else
      echo "$count $name" >>"$tmp"
    fi
  done <"$usage_file"

  [[ $found -eq 0 ]] && echo "1 $ssid" >>"$tmp"

  mv "$tmp" "$usage_file"
}
