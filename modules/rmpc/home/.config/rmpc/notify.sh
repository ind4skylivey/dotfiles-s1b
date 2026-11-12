#!/usr/bin/env sh
# notificación al cambiar de canción (con portada si hay)
# También intenta bajar letras sincronizadas si faltan.

CACHE_DIR="${HOME}/.cache/rmpc"
mkdir -p "$CACHE_DIR"
ALBUM_ART_PATH="${CACHE_DIR}/notification_cover"

if rmpc albumart --output "$ALBUM_ART_PATH"; then
    :
else
    ALBUM_ART_PATH=""
fi

TITLE="${TITLE:-Unknown title}"
ARTIST="${ARTIST:-Unknown artist}"

if [ -n "$ALBUM_ART_PATH" ] && [ -f "$ALBUM_ART_PATH" ]; then
    notify-send -i "$ALBUM_ART_PATH" "Now Playing" "$ARTIST — $TITLE" 2>/dev/null || true
else
    notify-send "Now Playing" "$ARTIST — $TITLE" 2>/dev/null || true
fi

FETCH="${HOME}/.config/rmpc/fetch-lyrics.sh"
if [ -x "$FETCH" ]; then
    "$FETCH" || true
fi
