#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Install configs..."

sudo cp    "$SCRIPT_DIR/tlp.conf"   /etc/
cp -r "$SCRIPT_DIR/.config"    "$HOME"
cp    "$SCRIPT_DIR/.xsession"  "$HOME"
cp    "$SCRIPT_DIR/.zshrc"     "$HOME"

echo "==> Done !"
