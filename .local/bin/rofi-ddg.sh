#!/usr/bin/env bash
#
# 🔎 Search with DuckDuckGo bangs via rofi, with local overrides.
#
# Behavior:
#   - If prefix matches a local mapping → use that.
#   - Else → forward query to DuckDuckGo bangs (!prefix query).
#
# Common prefixes:
#   g      → Google
#   yt     → YouTube
#   sp     → Startpage
#   ddg    → DuckDuckGo
#   amz    → Amazon
#
# Full bang list: https://duckduckgo.com/bang

BROWSER="xdg-open"

ROFI_THEME='
listview {
    enabled: false;
}
'

# --- Local bang overrides (prefix → URL template with %s) ---
declare -A BANGS=(
    # Custom (not supported by DDG)
    ["g"]="www.google.com/search?q=%s"
    ["y"]="https://www.youtube.com/results?search_query=%s"
    ["gpt"]="https://chat.openai.com/?q=%s"
)

# --- Dependency check ---
check_dependencies() {
    local deps=("xdg-open" "rofi")

    for dep in "${deps[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            echo "❌ Error: Missing dependency '$dep'." >&2
            exit 1
        fi
    done
}

# --- Query chooser ---
choose_query() {
    rofi -dmenu -i -theme-str "$ROFI_THEME" -p "Search" < /dev/null
}

urlencode() {
    if command -v jq >/dev/null 2>&1; then
        jq -sRr @uri <<<"$1"
    else
        local s="$1" encoded="" c
        for (( i=0; i<${#s}; i++ )); do
            c=${s:$i:1}
            case "$c" in
                [a-zA-Z0-9.~_-]) encoded+="$c" ;;
                *) encoded+=$(printf '%%%02X' "'$c") ;;
            esac
        done
        echo "$encoded"
    fi
}

open_in_browser() {
    local query="$1"
    local prefix="${query%% *}"
    local rest="${query#* }"

    # If query has no space, treat whole thing as search term
    if [[ "$query" == "$prefix" ]]; then
        rest=""
    fi

    if [[ -n "${BANGS[$prefix]}" ]]; then
        # Local custom mapping
        local encoded
        encoded=$(urlencode "$rest")
        local url="${BANGS[$prefix]}"
        url="${url//%s/$encoded}"
    else
        # Fallback to DuckDuckGo bangs
        if [[ "$query" != "!"* ]]; then
            query="!$query"
        fi
        local encoded
        encoded=$(urlencode "$query")
        local url="https://duckduckgo.com/?q=${encoded}"
    fi

    $BROWSER "$url" &
}

# --- Main Flow ---
check_dependencies
query=$(choose_query)
[ -z "$query" ] && exit 0

open_in_browser "$query"
