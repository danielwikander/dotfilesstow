#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
backgroundpic=~/Pictures/Wallpapers/currentwallpaper.jpg 

# Merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xrdb merge .Xresources &                      # Xresources 
setxkbmap -option "caps:escape" &             # Set caps as esc
xsetroot -cursor_name left_ptr &              # Set cursor to pointer instead of x
xset +fp /usr/share/fonts/local &             # Set fonts
xset +fp /usr/share/fonts/misc &
xset +fp ~/.fonts &
xset fp rehash &
systemctl --user import-environment DISPLAY & # Fix for dunst when not using display manager
dunst &                                       # Notification daemon
devmon &                                      # Mount removable media daemon
sxhkd &                                       # Keybind daemon
urxvtd -q -f -o &                             # Urxvt terminal daemon
if [ -f "$backgroundpic" ]; then              # Set backgroundpic
    feh --bg-fill "$backgroundpic" &
fi
compton -b &                                  # Compositor
polybar top &                                 # Bar
exec bspwm                                    # Windowmanager

