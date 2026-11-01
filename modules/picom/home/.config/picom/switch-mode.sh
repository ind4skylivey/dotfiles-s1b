#!/bin/bash
# ============================================
# Picom Mode Switcher
# ============================================
# Switches between FULL mode (all effects) and MINIMAL mode (focus mode).
# Improved version: automatic backup, non-destructive, with status.
#
# Usage:
#   switch-mode.sh full      -> Enable blur + shadows + fading + animations
#   switch-mode.sh minimal   -> Focus mode, no distractions (but still optimized)
#   switch-mode.sh status    -> Show current mode and process state
# ============================================

set -e

PICOM_DIR="$HOME/.config/picom"
CURRENT="$PICOM_DIR/picom.conf"
BACKUP_DIR="$PICOM_DIR/backups"
MINIMAL="$BACKUP_DIR/picom_minimal.conf"
FULL="$BACKUP_DIR/picom_full.conf"
HISTORY="$BACKUP_DIR/switch-history.log"

# --- Helper functions ---

log_change() {
  local mode="$1"
  local timestamp
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$timestamp] switched to $mode" >> "$HISTORY"
}

detect_current_mode() {
  # Detects mode by reading the active config file
  if [ ! -f "$CURRENT" ]; then
    echo "missing"
    return
  fi
  if grep -q "^shadow = true" "$CURRENT" 2>/dev/null; then
    echo "full"
  elif grep -q "^shadow = false" "$CURRENT" 2>/dev/null; then
    echo "minimal"
  else
    echo "unknown"
  fi
}

restart_picom() {
  pkill -TERM picom 2>/dev/null || true
  sleep 1
  # If it didn't die, force it
  if pgrep picom >/dev/null 2>&1; then
    echo "[WARN] picom did not respond to SIGTERM, sending SIGKILL..."
    pkill -KILL picom 2>/dev/null || true
    sleep 1
  fi
  picom -b --config "$CURRENT"
  sleep 1
  if pgrep picom >/dev/null 2>&1; then
    echo "[OK] picom running (PID: $(pgrep picom))"
    return 0
  else
    echo "[ERR] picom did not start. Check /tmp/picom.log"
    return 1
  fi
}

backup_current() {
  if [ -f "$CURRENT" ]; then
    local timestamp
    timestamp=$(date +%Y%m%d-%H%M%S)
    cp "$CURRENT" "$BACKUP_DIR/picom.conf.auto-backup-$timestamp"
    echo "[INFO] Backup of current config: picom.conf.auto-backup-$timestamp"
  fi
}

show_status() {
  local mode
  mode=$(detect_current_mode)
  echo "=============== Picom Status ==============="
  echo "  Current mode:  $mode"
  echo "  Config path:   $CURRENT"
  if pgrep picom >/dev/null 2>&1; then
    echo "  Process:       running (PID: $(pgrep picom))"
    echo "  Version:       $(picom --version 2>&1 | head -1)"
  else
    echo "  Process:       NOT running"
  fi
  echo ""
  echo "  Last 5 changes:"
  if [ -f "$HISTORY" ]; then
    tail -5 "$HISTORY" | sed 's/^/    /'
  else
    echo "    (no history yet)"
  fi
  echo "============================================"
}

# --- Main ---

case "$1" in
  full)
    if [ ! -f "$FULL" ]; then
      echo "[ERR] $FULL not found"
      exit 1
    fi
    current_mode=$(detect_current_mode)
    if [ "$current_mode" = "full" ]; then
      echo "[INFO] Already in full mode. Restarting picom anyway..."
      restart_picom
      exit 0
    fi
    echo "[INFO] Switching to FULL picom (blur + shadows + fading + animations)..."
    backup_current
    cp "$FULL" "$CURRENT"
    log_change "full"
    if restart_picom; then
      echo "[OK] FULL mode active"
    fi
    ;;

  minimal)
    if [ ! -f "$MINIMAL" ]; then
      echo "[ERR] $MINIMAL not found"
      exit 1
    fi
    current_mode=$(detect_current_mode)
    if [ "$current_mode" = "minimal" ]; then
      echo "[INFO] Already in minimal mode. Restarting picom anyway..."
      restart_picom
      exit 0
    fi
    if [ ! -f "$CURRENT" ]; then
      echo "[ERR] $CURRENT not found"
      exit 1
    fi
    echo "[INFO] Switching to MINIMAL picom (focus mode, no distractions)..."
    backup_current
    cp "$MINIMAL" "$CURRENT"
    log_change "minimal"
    if restart_picom; then
      echo "[OK] MINIMAL mode active (optimized, no blur/shadows/fading/animations)"
    fi
    ;;

  status)
    show_status
    ;;

  *)
    echo "Picom Mode Switcher"
    echo ""
    echo "Usage: $0 {full|minimal|status}"
    echo ""
    echo "  full     - Enable blur + shadows + fading + animations"
    echo "  minimal  - Focus mode, no distractions (but still optimized)"
    echo "  status   - Show current mode and process state"
    echo ""
    echo "Current mode: $(detect_current_mode)"
    ;;
esac
