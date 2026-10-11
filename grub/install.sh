#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Applying GRUB configuration..."
sudo cp $SCRIPT_DIR/grub /etc/default/grub

echo "==> Copying GRUB theme..."
sudo mkdir -p /boot/grub/themes
sudo cp -r "$SCRIPT_DIR/grub_theme" /boot/grub/themes/

echo "==> Updating GRUB config..."
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "==> GRUB theme installed successfully!"
