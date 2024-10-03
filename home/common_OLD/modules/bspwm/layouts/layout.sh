bspc wm --dump-state > state.json
~/.config/bspwm/scripts/bspwm-extract_canvas state.json > load.json
~/.config/bspwm/scripts/bspwm-induce_rules state.json > rules.sh
cat rules.sh
