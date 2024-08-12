#!/usr/bin/env bash


power_off=""
reboot=""
lock=""
suspend="󰒲"
log_out=""

chosen=$(printf '%s;%s;%s;%s;%s\n' \
		"$power_off" \
		"$reboot" \
		"$lock" \
		"$suspend" \
		"$log_out" \
		| rofi \
				-theme-str '@import "themes/power.rasi"' \
				-hover-select \
				-me-select-entry "" \
				-me-accept-entry MousePrimary \
				-dmenu \
				-sep ';' \
				-selected-row 2)

confirm () {
		${builtins.readFile ./rofi-prompt.sh}
}

case "$chosen" in
		"$power_off")
				confirm 'Shutdown?' && doas shutdown now
				;;

		"$reboot")
				confirm 'Reboot?' && doas reboot
				;;

		"$lock")
				i3lock-color
				;;

		"$suspend")
				systemctl suspend
				;;

		"$log_out")
				confirm 'Logout?' && i3-msg exit
				;;

		*) exit 1 ;;
esac
