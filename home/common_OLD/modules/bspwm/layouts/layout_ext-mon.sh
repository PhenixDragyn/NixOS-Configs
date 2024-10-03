bspc wm --dump-state > state_ext-mon.json
~/.config/bspwm/scripts/bspwm-extract_canvas state_ext-mon.json > load_ext-mon.json
~/.config/bspwm/scripts/bspwm-induce_rules state_ext-mon.json > rules_ext-mon.sh
cat rules_ext-mon.sh
