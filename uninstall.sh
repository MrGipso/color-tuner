#!/usr/bin/env bash
# Removes Color Tuner. Run "Turn correction off" in the app first
# if you want to remove its profile from the monitor.
set -euo pipefail
PREFIX="${PREFIX:-$HOME/.local}"
ID=io.github.MrGipso.ColorTuner
rm -f "$PREFIX/bin/color-tuner" \
      "$PREFIX/share/applications/$ID.desktop" \
      "$PREFIX/share/icons/hicolor/scalable/apps/$ID.svg"
gtk-update-icon-cache -f -t "$PREFIX/share/icons/hicolor" >/dev/null 2>&1 || true
update-desktop-database "$PREFIX/share/applications" >/dev/null 2>&1 || true
echo "Color Tuner removed. Settings are kept in ~/.config/color-tuner.json"
