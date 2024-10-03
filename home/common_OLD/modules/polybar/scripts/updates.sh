#!/usr/bin/env bash

NOTIFY_ICON=/usr/share/icons/Papirus/32x32/apps/system-software-update.svg

get_total_updates() { UPDATES=$(~/.config/polybar/scripts/checkupdates 2>/dev/null | wc -l); }

while true; do
    get_total_updates

    # notify user of updates
    if hash notify-send &>/dev/null; then
        if (( UPDATES > 50 )); then
            notify-send -u critical -i $NOTIFY_ICON \
                "You really need to update!!" "$UPDATES New packages"
        elif (( UPDATES > 25 )); then
            notify-send -u normal -i $NOTIFY_ICON \
                "You should update soon" "$UPDATES New packages"
        elif (( UPDATES > 2 )); then
            notify-send -u low -i $NOTIFY_ICON \
                "$UPDATES New packages"
        fi
    fi


    COLOR_FG=$(xrdb -query | grep '*color4:' | awk '{print $NF}')
    COLOR_ALERT=$(xrdb -query | grep '*color1:' | awk '{print $NF}')

    # when there are updates available
    # every 10 seconds another check for updates is done
    while (( UPDATES > 0 )); do
        if (( UPDATES == 1 )); then
            #echo "%{F#ff0000}%{F-} $UPDATES"
            echo "%{F$COLOR_ALERT}%{F-} $UPDATES"
            #echo " $UPDATES"
            #echo "%{F#ff0000} %{F-} $UPDATES"
        elif (( UPDATES > 1 )); then
            #echo "%{F#ff0000}%{F-} $UPDATES"
            echo "%{F$COLOR_ALERT}%{F-} $UPDATES"
            #echo " $UPDATES"
            #echo "%{F#ff0000} %{F-} $UPDATES"
        else
            #echo "%{F#f4d67a}%{F-}"
            echo "%{F$COLOR_FG}%{F-}"
            #echo ""
            #echo ""
        fi
        sleep 10
        get_total_updates
    done

    # when no updates are available, use a longer loop, this saves on CPU
    # and network uptime, only checking once every 30 min for new updates
    while (( UPDATES == 0 )); do
        #echo "%{F#f4d67a}%{F-}"
        echo "%{F$COLOR_FG}%{F-}"
        #echo ""
        #echo ""
        sleep 1800
        get_total_updates
    done
done
