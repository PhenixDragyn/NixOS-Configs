#!/usr/bin/env bash

bspc rule -a firefox:Navigator -o node=@^1:^1:/1
bspc rule -a kitty:kitty -o node=@^1:^1:/2/1
bspc rule -a kitty:kitty -o node=@^1:^1:/2/2/1
#bspc rule -a dropdown:termite -o node=@^1:^1:/2/2/2
bspc rule -a thunderbird:Mail -o node=@^1:^2:/

bspc wm --load-state "$(readlink --canonicalize-existing ~/.config/bspwm/layouts/load.json)"

sleep 1 && firefox &
sleep 1 && kitty &
sleep 1 && kitty &
sleep 1 && thunderbird &
sleep 1 && termite --class dropdown -e "zsh -i" &

