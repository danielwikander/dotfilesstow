#!/bin/sh
pic=$1
extension=${pic##*.}
wallpaperpath=~/.config/currentwallpaper.${extension}
cp -- "$pic" "$wallpaperpath"
feh --bg-fill --no-fehbg "$wallpaperpath"
echo "Changed wallpaper to: $pic
