#!/usr/bin/env bash

## DWM Powermenu
## Styled for S1B Gr0uP.inc setup

# Options — Nerd Font icons + labels
lock='󰌾  Lock'
lockblur='󰍁  Blur'
suspend='󰤄  Sleep'
logout='󰍃  Logout'
reboot='󰜉  Reboot'
shutdown='󰐥  Power'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "" \
		-mesg "S1B Gr0uP.inc" \
		-theme "$HOME/.config/rofi/themes/powermenu.rasi"
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$lockblur\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	case $1 in
		--shutdown)
			systemctl poweroff
			;;
		--reboot)
			systemctl reboot
			;;
		--suspend)
			mpc -q pause
			amixer set Master mute
			systemctl suspend
			;;
		--lock)
			if [[ -x '/usr/bin/betterlockscreen' ]]; then
				betterlockscreen -l
			elif [[ -x '/usr/bin/i3lock' ]]; then
				i3lock
			fi
			;;
		--lockblur)
			if [[ -x '/usr/bin/betterlockscreen' ]]; then
				betterlockscreen -l blur --blur 0.5
			elif [[ -x '/usr/bin/i3lock' ]]; then
				i3lock
			fi
			;;
		--logout)
			case "$DESKTOP_SESSION" in
				openbox)
					openbox --exit
					;;
				bspwm)
					bspc quit
					;;
				dwm)
					pkill dwm
					;;
				i3)
					i3-msg exit
					;;
				plasma)
					qdbus org.kde.ksmserver /KSMServer logout 0 0 0
					;;
			esac
			;;
	esac
}

# Actions
chosen="$(run_rofi)"
case "${chosen}" in
    "${lock}")
		run_cmd --lock
        ;;
    "${lockblur}")
		run_cmd --lockblur
        ;;
    "${suspend}")
		run_cmd --suspend
        ;;
    "${logout}")
		run_cmd --logout
        ;;
    "${reboot}")
		run_cmd --reboot
        ;;
    "${shutdown}")
		run_cmd --shutdown
        ;;
esac