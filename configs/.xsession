#!/bin/sh

setxkbmap 'us,ua' -option "grp:lwin_toggle" &
xwallpaper --zoom "$(find ~/dwm-Gruvbox/wallpapers/ -type f | shuf -n 1)"

picom -b &
slstatus &

exec dwm
