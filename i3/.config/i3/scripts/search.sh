#!/bin/bash
set -euo pipefail

# Read X11 PRIMARY selection ONLY (mouse highlight).
# Does NOT fall back to CLIPBOARD so stale copied text is never used.
get_selection() {
    # Small pause to allow X11 event loop and key-release state to settle
    sleep 0.05
    local text=""
    text=$(timeout 1s xclip -o -selection primary 2>/dev/null || true)
    if [ -z "$text" ]; then
        text=$(timeout 1s xsel -o -p 2>/dev/null || true)
    fi
    printf '%s' "$text"
}

# Standard percent-encoding (uses %20 for spaces for full Single Page App compatibility)
urlencode() {
    python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.stdin.read().strip()))"
}

LOG_FILE="/tmp/search_debug.log"

case "${1:-}" in
    chatgpt)
        QUERY=$(get_selection)
        QUERY_TRIMMED=$(printf '%s' "$QUERY" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ChatGPT query: [${QUERY_TRIMMED:0:60}]" >> "$LOG_FILE"
        if [ -n "$QUERY_TRIMMED" ]; then
            ENCODED=$(printf '%s' "$QUERY_TRIMMED" | urlencode)
            URL="https://chatgpt.com/?q=${ENCODED}"
        else
            # Nothing selected: open ChatGPT home page directly
            URL="https://chatgpt.com/"
        fi
        firefox --new-tab "$URL" >/dev/null 2>&1 &
        ;;
    google)
        QUERY=$(get_selection)
        # Collapse newlines, tabs, and multiple spaces into a single space for the input prompt
        CLEAN_QUERY=$(printf '%s' "$QUERY" | tr '\n\r\t' ' ' | sed 's/  */ /g; s/^ //; s/ $//')
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Google prefill query: [${CLEAN_QUERY:0:60}]" >> "$LOG_FILE"

        EXIT_CODE=0
        if [ -n "$CLEAN_QUERY" ]; then
            # Pipe CLEAN_QUERY as a default selectable item so pressing Enter immediately accepts it,
            # and use -filter so the input bar is pre-filled and editable
            FINAL_QUERY=$(printf '%s\n' "$CLEAN_QUERY" | rofi -dmenu -p "Search Google" -filter "$CLEAN_QUERY" 2>/dev/null) || EXIT_CODE=$?
        else
            # No selection: show prompt with empty input bar
            FINAL_QUERY=$(printf "" | rofi -dmenu -p "Search Google" 2>/dev/null) || EXIT_CODE=$?
        fi

        # If user pressed Escape / cancelled rofi, exit without opening browser
        if [ "$EXIT_CODE" -ne 0 ]; then
            exit 0
        fi

        FINAL_QUERY=$(printf '%s' "$FINAL_QUERY" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Google final query: [${FINAL_QUERY:0:60}]" >> "$LOG_FILE"

        if [ -n "$FINAL_QUERY" ]; then
            ENCODED=$(printf '%s' "$FINAL_QUERY" | urlencode)
            URL="https://www.google.com/search?q=${ENCODED}"
        else
            # User pressed Enter on an empty prompt: open Google home page
            URL="https://www.google.com/"
        fi
        firefox --new-tab "$URL" >/dev/null 2>&1 &
        ;;
    *)
        echo "Usage: $0 {chatgpt|google}" >&2
        exit 1
        ;;
esac
