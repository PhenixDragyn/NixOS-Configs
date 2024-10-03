{ config, desktop, ... }:

let
  bwall = if ( desktop == "lxqt_bspwm" ) then "~/.fehbg &" 
        else if ( desktop == "xfce_bspwm") then "nitrogen --restore &"
        else "";
in
{
  home.file = {
    ".config/bspwm/scripts" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/modules/home/bspwm/scripts";
      #source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/bspwm/scripts";
    };
    ".config/bspwm/layouts" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/modules/home/bspwm/layouts";
      #source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/bspwm/layouts";
    };

    "./.config/bspwm/bspwmrc" = {
      executable = true;
      text = ''
#! /bin/sh
xresource () { 
  xrdb -query | grep -E "^(bspwm|\*)$1" | sed -r "s/^[^:]+:\s+//" | tail -n 1 
}

num_monitors="$(xrandr --query | grep ' connected' | wc -l)"

main="$(xrandr | grep ' connected primary ' | cut -d' ' -f1)"
side="$(xrandr | grep ' connected ' | grep -v ' connected primary ' | cut -d' ' -f1)"

if [ $num_monitors -eq 1 ]; then
  bspc monitor $main -d I II III
  bspc config top_padding         25
else
  bspc monitor $side -d I II III 
  bspc monitor $main -d IV V VI
  bspc config -m $side top_padding         25
  bspc config -m $main top_padding        0
fi

bspc config remove_disabled_monitors true
bspc config remove_unplugged_monitors true
bspc config merge_overlapping_monitors true
bspc config honor_size_hints false

bspc config border_width         2
bspc config window_gap          13
#bspc config top_padding        22
bspc config bottom_padding      0
bspc config left_padding        0
bspc config right_padding       0
bspc config split_ratio         0.50

bspc config borderless_monocle   true
bspc config gapless_monocle      true
bspc config focus_follows_pointer true

bspc config focused_border_color $(xresource color4:)
bspc config normal_border_color $(xresource color0:)
bspc config active_border_color $(xresource color0:)
bspc config presel_feedback_color $(xresource color4:)

bspc config directional_focus_tightness low # Allows to focus floating windows

bspc config center_pseudo_tiled true
bspc config pointer_action1 move
bspc config pointer_action2 resize_corner


### RULES ###
bspc rule -r "*"

bspc rule -a \*:\* state=floating center=true

bspc rule -a kitty:kitty state=tiled
bspc rule -a firefox:Navigator state=tiled
bspc rule -a thunderbird:Mail state=tiled
bspc rule -a spotify:Spotify state=tiled 

#bspc rule -a jetbrains-pycharm-ce:jetbrains-pycharm-ce state=tiled

#bspc rule -a Gpicview:gpicview rectangle=1080x650+0+0 

#bspc rule -a "ONLYOFFICE Desktop Editors":DesktopEditors state=tiled
#bspc rule -a "ONLYOFFICE Desktop Editors" state=tiled

#bspc rule -a kitty -o state=floating rectangle=$(slop) && kitty

#bspc rule -a "Seafile Client" desktop='^12' state=floating rectangle=350x350+400+300 border=off rule -a Gimp desktop='^8' state=floating follow=on
#bspc rule -a Chromium desktop='^2'
#bspc rule -a Yelp state=floating
#bspc rule -a Kupfer.py focus=on
#bspc rule -a Screenkey manage=off

# bspc rule -a Yelp state=floating center=true
# bspc rule -a pcmanfm-qt state=floating center=true
# bspc rule -a lxqt-config state=floating center=true
# bspc rule -a lxqt-archiver state=floating center=true
# bspc rule -a lxqt-admin-user state=floating center=true
# bspc rule -a lximage-qt state=floating center=true
# bspc rule -a Lxappearance state=floating center=true
# bspc rule -a luckybackup state=floating center=true
# bspc rule -a fontmatrix state=floating center=true
# bspc rule -a obsidian state=floating center=true
# bspc rule -a Nitrogen state=floating center=true
# bspc rule -a qpdfview state=floating center=true
# bspc rule -a QtPass state=floating center=true
# bspc rule -a feh state=floating center=true
# bspc rule -a "Kvantum Manager" state=floating center=true
# bspc rule -a qt5ct state=floating center=true
# bspc rule -a qt6ct state=floating center=true
# bspc rule -a qtfm state=floating center=true
# bspc rule -a qimgv state=floating center=true
# bspc rule -a qv4l2 state=floating center=true
# bspc rule -a Nm-connection-editor state=floating center=true
# bspc rule -a Blueman-manager state=floating center=true
# bspc rule -a Firewall-config state=floating center=true
# bspc rule -a screengrab state=floating center=true
# bspc rule -a Syncthing state=floating center=true
# bspc rule -a Pavucontrol state=floating center=true
# bspc rule -a Soffice state=floating center=true
# bspc rule -a libreoffice state=floating center=true bspc rule -a libreoffice-startcenter state=floating center=true
# bspc rule -a libreoffice-writer state=floating center=true
# bspc rule -a libreoffice-impress state=floating center=true
# bspc rule -a libreoffice-math state=floating center=true
# bspc rule -a libreoffice-calc state=floating center=true
# bspc rule -a libreoffice-draw state=floating center=true
# bspc rule -a libreoffice-base state=floating center=true
# bspc rule -a Oomox state=floating center=true
#bspc rule -a spotify-qt state=floating center=true
#bspc rule -a Spotify state=floating center=true


### PROGRAMS ###

# Start Picom compositor for effects
killall "picom"
pgrep -x picom > /dev/null || picom --no-vsync &

# Start dunst for notifications
killall "dunst"
pgrep -x dunst > /dev/null || dunst --config ~/.config/dunst/dunstrc &

# Start polybar at startup
killall polybar; sleep 2 
pgrep -x polybar > /dev/null || ~/.config/polybar/launch.sh &
#pgrep -x polybar > /dev/null || (sleep 3; ~/.config/polybar/launch.sh) &

# Start sxhkd for Hotkeys
killall "sxhkd"
pgrep -x sxhkd > /dev/null || sxhkd &

# Screensaver
xautolock -time 30 -locker "i3lock-color" &

# Start unclutter to hide mouse when not in use
pgrep -x unclutter > /dev/null || unclutter &

# Scratchpad
#bspc rule -a scratchpad sticky=on state=floating hidden=on
## check scratchpad already running
[ "$(ps -x | grep -c 'scratchpad')" -eq "1" ] && st -c scratchpad -e ~/.local/bin/scratch &
#killall "termite"
pgrep -f termite | xargs -I{} kill -9 {}
bspc rule -a dropdown sticky=on state=floating layer=above hidden=on 
pgrep -x termite > /dev/null || termite --class dropdown -e "zsh -i" &

# Fix cursors
xsetroot -cursor_name left_ptr


### SET BACKGROUND/THEME ###

# Set background color
TMP_COLOR=$(echo "$(xresource color12:)" | cut -c2- | tr '[:lower:]' '[:upper:]')
TBG_COLOR=$(echo "obase=16;ibase=16;$TMP_COLOR-5F5F5F" | bc | awk '{printf "%06X\n", strtonum("0x"$0)}')
BG_COLOR=$(echo '#'$TBG_COLOR)
hsetroot -solid $BG_COLOR

# Restore wallpaper
${bwall}

# Call Autorandr
autorandr -c

# Start a terminal
kitty &


### SUBSCRIBE SCRIPTS ###

#@~/.config/bspwm/scripts/bspwm-subscribe_wbc-user &


### LAYOUT ###

#~/.config/bspwm/layouts/rules.sh
#bspc wm --load-state "$(readlink --canonicalize-existing ~/.config/bspwm/layouts/load.json)"
      '';
    };
  };
}

