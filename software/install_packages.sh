#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing packages..."

sudo pacman -Syu
sudo pacman -S --needed - < $SCRIPT_DIR/packages.txt

echo "==> Installing other software..."
sudo pacman -U --needed $SCRIPT_DIR/software_files/obsidian-1.12.7-3-x86_64.pkg.tar.zst

sudo cp $SCRIPT_DIR/software_files/bonsai.sh /usr/bin
sudo cp $SCRIPT_DIR/software_files/pipes.sh  /usr/bin
sudo cp $SCRIPT_DIR/software_files/todo      /usr/bin


echo "==> Done"
