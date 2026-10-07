#!/bin/bash
clear
TOKEN_FILE=".gitTok"

TOKEN=$(cat "$TOKEN_FILE" | tr -d '[:space:]')

rm -rf .git

git init -b main

git config user.email "s.t.a.l.k.e.riat1905@gmail.com"
git config user.name "Teplikx"

git remote add origin "https://Teplikx:${TOKEN}@github.com/Teplikx/dwm-Gruvbox.git"

git add .
git commit -m "Fresh backup: $(date +'%Y-%m-%d %H:%M:%S')"
git push -f origin main
