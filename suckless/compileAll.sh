#!/bin/bash
set -euo pipefail

# SCRIPT_DIR зараз вказує чітко на папку /home/lunatik/dwm-Gruvbox/suckless
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Compile..."

echo "==>  Deleting old configs..." 
rm -f "$SCRIPT_DIR/dmenu/config.h" "$SCRIPT_DIR/dwm/config.h" "$SCRIPT_DIR/slstatus/config.h" "$SCRIPT_DIR/st/config.h"

echo "Compile WM and components..."

cd "$SCRIPT_DIR/dmenu"
sudo make clean install

cd "$SCRIPT_DIR/dwm"
sudo make clean install

cd "$SCRIPT_DIR/slstatus"
sudo make clean install

cd "$SCRIPT_DIR/st"
sudo make clean install 

echo "Done!"

