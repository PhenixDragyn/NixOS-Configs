bspc rule -a firefox:Navigator -o node=@^1:^1:/1
bspc rule -a kitty:kitty -o node=@^1:^1:/2/1
bspc rule -a kitty:kitty -o node=@^1:^1:/2/2
bspc rule -a thunderbird:Mail -o node=@^1:^2:/

bspc wm --load-state "$(readlink --canonicalize-existing ~/.config/bspwm/layouts/load.json)"

sleep 1 && firefox &
sleep 2 && kitty &
sleep 2 && kitty &
sleep 2 && thunderbird &
sleep 2 && termite --class dropdown -e "zsh -i" &
