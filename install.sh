#!/usr/bin/env bash
# Installs Color Tuner for the current user (no sudo needed).
set -euo pipefail
cd "$(dirname "$0")"

PREFIX="${PREFIX:-$HOME/.local}"
BINDIR="$PREFIX/bin"
APPDIR="$PREFIX/share/applications"
ICONDIR="$PREFIX/share/icons/hicolor/scalable/apps"
ID=io.github.MrGipso.ColorTuner

if ! python3 -c "import gi; gi.require_version('Gtk', '4.0')" 2>/dev/null; then
  echo "GTK4 for Python is missing. Install it, e.g.:" >&2
  echo "  Ubuntu/Debian: sudo apt install python3-gi gir1.2-gtk-4.0 colord" >&2
  echo "  Fedora:        sudo dnf install python3-gobject gtk4 colord" >&2
  echo "  Arch:          sudo pacman -S python-gobject gtk4 colord" >&2
  exit 1
fi

install -Dm755 color-tuner "$BINDIR/color-tuner"
install -Dm644 "data/$ID.svg" "$ICONDIR/$ID.svg"
mkdir -p "$APPDIR"
sed "s|@BINDIR@|$BINDIR|" "data/$ID.desktop" > "$APPDIR/$ID.desktop"
chmod 644 "$APPDIR/$ID.desktop"

gtk-update-icon-cache -f -t "$PREFIX/share/icons/hicolor" >/dev/null 2>&1 || true
update-desktop-database "$APPDIR" >/dev/null 2>&1 || true

echo "Color Tuner installed. Launch it from the app menu or run: $BINDIR/color-tuner"
