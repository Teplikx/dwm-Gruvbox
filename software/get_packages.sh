#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Get packages..."

pacman -Qqe > "$SCRIPT_DIR/packages.txt"

