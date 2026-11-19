#!/bin/sh
# Installs the macOS layout into a Herdr home. Refuses to overwrite existing files unless
# --force is given; Herdr's own layouts and mods are never touched.
#   ./scripts/install.sh            stop if any of its files is already there
#   ./scripts/install.sh --force    replace them
# HERDR_APP_HOME picks another Herdr home (default ~/.config/herdr-app).
set -eu
HOME_DIR="${HERDR_APP_HOME:-$HOME/.config/herdr-app}"
REPO="$(cd "$(dirname "$0")/.." && pwd)"
FORCE="${1:-}"
case "$FORCE" in ""|--force) ;; *) echo "Usage: $0 [--force]" >&2; exit 2 ;; esac
[ -d "$HOME_DIR" ] || { echo "No Herdr home at $HOME_DIR. Open the Herdr app once first." >&2; exit 1; }
if [ "$FORCE" != "--force" ]; then
  for f in layouts/macos.json themes/macos.json; do
    [ -e "$HOME_DIR/$f" ] && { echo "$HOME_DIR/$f exists. Re-run with --force to replace it." >&2; exit 1; }
  done
  for m in "$REPO"/mods/*/; do
    n=$(basename "$m")
    [ -e "$HOME_DIR/mods/$n" ] && { echo "$HOME_DIR/mods/$n exists. Re-run with --force to replace it." >&2; exit 1; }
  done
fi
mkdir -p "$HOME_DIR/layouts" "$HOME_DIR/themes" "$HOME_DIR/mods"
cp "$REPO/layouts/macos.json" "$REPO/layouts/macos.svg" "$HOME_DIR/layouts/"
cp "$REPO/themes/macos.json" "$HOME_DIR/themes/"
for m in "$REPO"/mods/*/; do
  n=$(basename "$m")
  rm -rf "$HOME_DIR/mods/$n"
  cp -R "$m" "$HOME_DIR/mods/$n"
done
if command -v herdr-app >/dev/null; then
  for m in "$REPO"/mods/*/; do
    n=$(basename "$m")
    out=$(herdr-app check "$HOME_DIR/mods/$n" 2>&1) || { echo "check failed: $n" >&2; echo "$out" >&2; }
  done
fi
echo "Installed. Switch to it with: herdr-app do layout.switch --name macos"
