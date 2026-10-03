#!/bin/sh

setxkbmap 'us,ua' -option "grp:lwin_toggle" &

feh --bg-fill dwm-Gruvbox/wallpapers/* --randomize

slstatus &

picom -b &

todo &

exec dwm
