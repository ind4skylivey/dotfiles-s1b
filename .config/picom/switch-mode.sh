#!/bin/bash
# Picom Mode Switcher - Switch between full and minimal configs

PICOM_DIR="$HOME/.config/picom"
CURRENT="$PICOM_DIR/picom.conf"
FULL="$PICOM_DIR/backups/picom_full.conf"
MINIMAL="$PICOM_DIR/picom.conf"

case "$1" in
  full)
    echo "🎨 Switching to FULL picom (all effects)..."
    cp "$FULL" "$CURRENT"
    pkill picom
    sleep 1
    picom -b
    echo "✅ Picom FULL mode active (don't use with Warp!)"
    ;;
  minimal)
    echo "⚡ Switching to MINIMAL picom (Warp compatible)..."
    # Already active, just restart
    pkill picom
    sleep 1
    picom -b
    echo "✅ Picom MINIMAL mode active (Warp friendly)"
    ;;
  *)
    echo "Usage: $0 {full|minimal}"
    echo ""
    echo "  full     - Enable all effects (blur, shadows, animations)"
    echo "  minimal  - Minimal config for Warp compatibility"
    echo ""
    echo "Current config: $(basename $(readlink $CURRENT 2>/dev/null || echo $CURRENT))"
    ;;
esac
