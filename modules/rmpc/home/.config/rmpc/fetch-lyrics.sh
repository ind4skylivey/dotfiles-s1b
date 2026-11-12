#!/usr/bin/env sh
# baja .lrc sincronizado desde lrclib.net si no hay letras.

if [ "$HAS_LRC" = "true" ]; then
    exit 0
fi

if [ -z "$ARTIST" ] || [ -z "$TITLE" ] || [ -z "$LRC_FILE" ]; then
    exit 0
fi

if ! command -v curl >/dev/null 2>&1 || ! command -v jq >/dev/null 2>&1; then
    exit 0
fi

mkdir -p "$(dirname "$LRC_FILE")"

LYRICS="$(curl -sS -G --max-time 8 \
    -H "Lrclib-Client: rmpc-${VERSION:-unknown}" \
    --data-urlencode "artist_name=$ARTIST" \
    --data-urlencode "track_name=$TITLE" \
    --data-urlencode "album_name=${ALBUM:-}" \
    "https://lrclib.net/api/get" | jq -r '.syncedLyrics // empty')" || exit 0

if [ -z "$LYRICS" ] || [ "$LYRICS" = "null" ]; then
    if [ -n "$PID" ]; then
        rmpc remote --pid "$PID" status "No lyrics for $ARTIST - $TITLE" --level warn 2>/dev/null || true
    fi
    exit 0
fi

{
    printf '%s\n' "[ar:$ARTIST]"
    [ -n "$ALBUM" ] && printf '%s\n' "[al:$ALBUM]"
    printf '%s\n' "[ti:$TITLE]"
    printf '%s\n' "$LYRICS" | sed -E '/^\[(ar|al|ti):/d'
} >"$LRC_FILE"

if [ -n "$PID" ]; then
    rmpc remote --pid "$PID" indexlrc --path "$LRC_FILE" 2>/dev/null || true
    rmpc remote --pid "$PID" status "Downloaded lyrics for $ARTIST - $TITLE" --level info 2>/dev/null || true
fi
