{ desktop, ... }:

let
  fm = if ( desktop == "lxqt_bspwm" ) then "pcmanfm-qt" 
       else if ( desktop == "xfce_bspwm") then "thunar"
       else if ( desktop == "bspwm_gtk") then "nemo"
       else "null";
  config = if ( desktop == "lxqt_bspwm" ) then "lxqt-config" 
       else if ( desktop == "xfce_bspwm") then "xfce4-settings-manager"
       else if ( desktop == "bspwm_gtk") then "null"
       else "null";
  imgview = if ( desktop == "lxqt_bspwm" ) then "qimgv ~/Wallpapers" 
       else if ( desktop == "xfce_bspwm") then "nitrogen ~/Wallpapers"
       else if ( desktop == "bspwm_gtk") then "qeegie"
       else "null";
  screenshot = if ( desktop == "lxqt_bspwm" ) then "screengrab" 
       else if ( desktop == "xfce_bspwm") then "null"
       else if ( desktop == "bspwm_gtk") then "null"
       else "null";
in
{
  #SXHKD
  home.file = {
    "./.config/sxhkd/sxhkdrc" = {

      text = ''
# SXHKD - BSWMRC
#-----------------------------------------------------#

# Restart bspwm
super + Escape
  bspc wm -r && notify-send "Restarting bspwm."

# Reload sxhkd
super + alt + Escape
  pkill -USR1 -x sxhkd && notify-send "Reloading sxhkd configuration."

# Reload polybar
super + ctrl + Escape
  pkill -USR1 -x polybar; sleep 1; bspc wm -r && notify-send "Reloading polybar configuration"

# Quit or Kill a node
super + {_,shift +}q
  bspc node -{c,k} && ~/.config/bspwm/scripts/bspwm-unhide

#-----------------------------------------------------#

# focus to the given desktop
super + {1-9,0}
  bspc desktop -f '^{1-9,10}'

# Send the node to the given desktop
super + alt + {1-9,0}
  bspc node -d '^{1-9,10}' && ~/.config/bspwm/scripts/bspwm-unhide

# focus/swap the node in the given direction
super + {_,shift + }{h,j,k,l}
  bspc node -{f,s} {west,south,north,east}

# control node layer
super + {control + shift + o, shift + o, o}
  bspc node -l {below,normal,above}

# Circulate tree {backward,forward}
super + bracket{left,right}
  bspc node @/ --circulate {backward,forward}

# alternate between the tiled and monocle layout
# super + ;
# 	bspc desktop -l next
# super + '
#   bspc node -f next

#-----------------------------------------------------#

# Set a preselect's direction
super + p; {h,j,k,l}
  bspc node -p {west,south,north,east}

# Set the preselect's ratio
super + p; {1-9}
  bspc node -o 0.{1-9}

# Cancel a preselection for the focused node
super + alt + p 
  bspc node -p cancel

# Cancel any preselection for the focused desktop
super + alt + shift + p
  bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel

# Move a marked node to the newest preselected node
super + p; {m}
  bspc node -g marked && bspc node newest.marked.local -n newest.\!automatic.local; \
  xdotool mousemove --window $(bspc query -N -n) 50 50

#-----------------------------------------------------#

# Insert a Receptacle
super + r; {h,j,k,l} 
  bspc node --presel-dir {west,south,north,east} -i

# Cancel a receptacle for the focused node receptacle
super + alt + r
  $HOME/.config/bspwm/scripts/bspmw-move_receptacle

# Cancel all receptacles for the focused desktop
super + alt + shift + r
  for win in `bspc query -N -n .leaf.\!window`; do `bspc node $win -k`; done

# Move a marked node to the newest receptable
super + r; {m}
  bspc node -g marked && bspc node newest.marked.local -n $(bspc query -N -n .leaf.\!window); \
  xdotool mousemove --window $(bspc query -N -n) 50 50

#-----------------------------------------------------#

# Toggle floating and tiling
super + f
  bspc node -t {floating,tiled}

# Toggle fullscreen 
super + BackSpace
  bspc node -t \~fullscreen


# Toggle node private (keeps the same tiling position/size)
super + minus
    bspc node focused --flag private; \
    window_name=$(bspc query -T -n $(bspc query -N -n focused) | jq -r .client.className); \
    if [ -z "$(bspc query -N -n focused.private)" ]; then \
	notify-send -u low -t 1500 "Unprivate $window_name"; \
    else \
	notify-send -u low -t 1500 "Private $window_name"; \
    fi
 
# Toggle node sticky (Stays in the focused desktop of it's monitor)
super + equal
  bspc node focused --flag sticky; \
    window_name=$(bspc query -T -n $(bspc query -N -n focused) | jq -r .client.className); \
    if [ -z "$(bspc query -N -n focused.sticky)" ]; then \
      notify-send -u low -t 1500 "Unsticky $window_name"; \
    else \
	    notify-send -u low -t 1500 "Sticky $window_name"; \
    fi


# Resize a window (i3 resizing)
super + alt + {h,j,k,l}
  $HOME/.config/bspwm/scripts/bspwm-resize {left,down,up,right}

super + alt + {comma,period,slash}
  bspc node -f @parent && bspc node --ratio {0.33,0.50,0.66}

super + ctrl + {comma,period,slash}
  bspc node -f @parent && bspc node --ratio {0.43,0.50,0.57}

super + shift + {comma,period,slash}
  bspc node -f @parent && bspc node --ratio {0.30,0.50,0.70}

super + ctrl + shift + slash
  fwid=$(bspc query -N -n focused.local); bspc node any.local -f && bspc node -B && bspc node $fwid -f


# Multimedia Keys
XF86Audio{Stop,Prev,Next,Play}
  playerctl {play-pause,previous,next,play-pause}

# Xbacklight has to be installed
XF86MonBrightness{Up,Down}
  xbacklight {-inc 5,-dec 5}

# Volume
#XF86Audio{Raise,Lower}Volume
#  amixer -q set Master {5%+,5%-} unmute
  #pactl set-sink-volume @DEFAULT_SINK@ {+5%,-5%}

XF86AudioRaiseVolume
  amixer -q set Master 5%+ unmute

XF86AudioLowerVolume
  amixer -q set Master 5%- unmute

XF86AudioMute 
  amixer -q set Master toggle
  #pactl set-sink-mute @DEFAULT_SINK@ toggle

XF86AudioMicMute 
  amixer -q set Capture toggle
  #pactl set-source-mute @DEFAULT_SOURCE@ toggle

#-----------------------------------------------------#

# Programs

# Mute notifications
super + m
  dunstctl set-paused toggle

# Hidden Apps
super + d 
  bspc node -g hidden

super + alt + d
  $HOME/.config/bspwm/scripts/bspwm-rofihidden

# Scratchpad 
super + u
  $HOME/.config/bspwm/scripts/bspwm-scratchpad dropdown

# Start firefox
super + w
  firefox

# Start firefox
super + e
  thunderbird

# Start pcmanfm
super + n
  ${fm}
  #pcmanfm-qt 
  #bspc rule -a pcmanfm-qt -o state=floating rectangle=875x540+100+100 && pcmanfm-qt

# Start ranger
super + shift + n
  bspc rule -a kitty -o state=floating rectangle=900x500+100+100 && kitty ranger

# Start Image Viewer
super + i
  ${imgview}
  #qimgv ~/Media/Pictures/Wallpapers/

# Start Vimiv
#super + v
#  vimiv

# Start lxqt-config
super + c
  ${config}
  #lxqt-config

# Lock the screen
super + x
  i3lock-color

# Start Kitty Terminal (Tiled, Floating)
super + {_,shift +} Return
  {kitty, bspc rule -a kitty -o state=floating rectangle=900x500+100+100 && kitty}	

# Screenshot
Print
  ${screenshot}
  #screengrab

# Program launcher
super + @space
	rofi --show-icons -show drun -run-shell-command '{terminal} -e zsh -ic "{cmd} && read"'

# App switcher and scratchpad manager
alt + Tab
  rofi -show window -window-thumbnail

# Hotkeys
alt + h
  sxhkhmenu
    '';
    };
  };
}
