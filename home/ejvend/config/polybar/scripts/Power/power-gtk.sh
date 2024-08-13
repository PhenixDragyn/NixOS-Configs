#!/usr/bin/env sh

POWER_OFF=" Power Off"
REBOOT=" Reboot"
SUSPEND=" Suspend"
LOG_OUT=" Log out"

chosen=`printf "%s\n%s\n%s\n%s" "$POWER_OFF" "$REBOOT" "$SUSPEND" "$LOG_OUT" | rofi -dmenu -i -p ""`

case "$chosen" in
	$POWER_OFF) action="power off" ;;
	$REBOOT) action="reboot" ;;
	$SUSPEND) action="suspend" ;;
	$LOG_OUT) action="log out" ;;
	*) exit 1 ;;
esac

confirm=`printf "Yes, %s" "$action"`
sure=`printf "%s\nNo, cancel" "$confirm" | rofi -dmenu -i -p "Are you sure"`

if [[ $sure != $confirm ]]; then
	exit 1
fi

if [[ $chosen != $SUSPEND ]]; then
	sh /home/elnu/scripts/graceful-shutdown/graceful_shutdown.sh
fi

case "$chosen" in
	$POWER_OFF) sudo poweroff ;;
	$REBOOT) sudo reboot ;;
	$SUSPEND) sudo systemctl suspend ;;
	$LOG_OUT) bspc quit ;;
	*) exit 1 ;;
esac
