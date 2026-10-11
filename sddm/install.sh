#!/bin/bash
set -euo pipefail

if [ "$EUID" -ne 0 ]; then
    echo "==> Цей скрипт потребує прав root. Перезапуск через sudo..."
    exec sudo "$0" "$@"
fi

THEME_NAME="pixie"
THEME_DIR="/usr/share/sddm/themes/${THEME_NAME}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}==>${NC} Копіювання системних конфігів..."
cp "$SCRIPT_DIR/mkinitcpio.conf" /etc/mkinitcpio.conf
cp "$SCRIPT_DIR/dwm.desktop"     /usr/share/xsessions/dwm.desktop 

echo -e "${BLUE}==>${NC} Starting Pixie SDDM Installation..."

if command -v sddm-greeter-qt6 >/dev/null 2>&1; then
    SYSTEM_QT="6"
    GREETER_CMD="sddm-greeter-qt6"
    echo -e "${BLUE}==>${NC} System detected: ${GREEN}Qt6 (Modern)${NC}"
else
    SYSTEM_QT="5"
    GREETER_CMD="sddm-greeter"
    echo -e "${BLUE}==>${NC} System detected: ${YELLOW}Qt5 (Legacy)${NC}"
fi

BACKUP_DIR=$(mktemp -d)

if [ -d "${THEME_DIR}" ]; then
    echo -e "${BLUE}==>${NC} Backing up user configurations..."
    [ -f "${THEME_DIR}/theme.conf" ] && cp "${THEME_DIR}/theme.conf" "${BACKUP_DIR}/"
    [ -f "${THEME_DIR}/assets/background.jpg" ] && cp "${THEME_DIR}/assets/background.jpg" "${BACKUP_DIR}/"
    [ -f "${THEME_DIR}/assets/avatar.jpg" ] && cp "${THEME_DIR}/assets/avatar.jpg" "${BACKUP_DIR}/"

    echo -e "${BLUE}==>${NC} Cleaning old version..."
    rm -rf "${THEME_DIR}"
fi

echo -e "${BLUE}==>${NC} Installing Pixie (Qt${SYSTEM_QT}) to ${THEME_DIR}..."
mkdir -p "${THEME_DIR}"

cd "$SCRIPT_DIR"
cp -r assets components Main.qml metadata.desktop theme.conf LICENSE "${THEME_DIR}/"
chmod -R 755 "${THEME_DIR}"

if [ -f "${BACKUP_DIR}/theme.conf" ]; then
    echo -e "${BLUE}==>${NC} Restoring user configurations..."
    cp "${BACKUP_DIR}/theme.conf" "${THEME_DIR}/theme.conf"
    [ -f "${BACKUP_DIR}/background.jpg" ] && cp "${BACKUP_DIR}/background.jpg" "${THEME_DIR}/assets/background.jpg"
    [ -f "${BACKUP_DIR}/avatar.jpg" ] && cp "${BACKUP_DIR}/avatar.jpg" "${THEME_DIR}/assets/avatar.jpg"
    
    if ! grep -q "^autoColor=" "${THEME_DIR}/theme.conf"; then
        sed -i '/^accentColor=/a autoColor=true' "${THEME_DIR}/theme.conf"
    fi
    if ! grep -q "^use24HourClock=" "${THEME_DIR}/theme.conf"; then
        sed -i '/^autoColor=/a use24HourClock=true' "${THEME_DIR}/theme.conf"
    fi
fi

rm -rf "${BACKUP_DIR}"

echo -e "${GREEN}Done!${NC} Pixie SDDM is now installed."

echo -e ""
read -p "Apply Pixie as your active theme now? (y/N) " -n 1 -r < /dev/tty
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=${THEME_NAME}" > /etc/sddm.conf.d/theme.conf
    echo -e "${GREEN}Theme applied successfully!${NC}"
else
    echo -e "To apply manually, set ${GREEN}Current=${THEME_NAME}${NC} in your SDDM config."
fi

echo -e ""
echo -e "Test with: ${BLUE}${GREETER_CMD} --test-mode --theme ${THEME_DIR}${NC}"

