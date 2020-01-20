#!/bin/bash

confirm() {
    echo -e "Yes\nNo" | rofi -dmenu -i -format d -selected-row 1 -p "${1:-Confirm: }"
}

suspend="Suspend"
reboot="Reboot"
shutdown="Shutdown"
logout="Log out"

content="$suspend\n$reboot\n$shutdown\n$logout"

selection=$(echo -e $content | rofi -dmenu -i -markup-rows -p "Action: ")
case $selection in
    $suspend)
        [[ $(confirm) = 1 ]] && (systemctl suspend -i) ;;
    $reboot)
	    [[ $(confirm) = 1 ]] && (systemctl reboot -i) ;;
    $shutdown)
        [[ $(confirm) = 1 ]] && (systemctl poweroff -i) ;;
    $logout)
        [[ $(confirm) = 1 ]] && ($HOME/.config/scripts/bspwm_close.sh) ;;
esac
