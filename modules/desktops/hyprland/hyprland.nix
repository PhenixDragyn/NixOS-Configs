{ config, lib, pkgs, inputs, username, ... }: 

let
  rgb = color: "rgb(${color})";
  rgba = color: alpha: "rgba(${color}${alpha})";
	#mainMonitor = "monitor:desc:ViewSonic Corporation VG3456 WFN214700166";
  #sideMonitor = "monitor:desc:AU Optronics 0x0BA4";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    #configType = "hyprlang"; # Forces generation of hyprland.conf

		settings = {
			config = {
				general = {
		 	 		gaps_in = 5;
		 	 		gaps_out = 10;
		 	 		border_size = 2;
		 	 		resize_on_border = true;
		 	 		extend_border_grab_area = 15;
		 	 		#layout = "dwindle";
		 		};

      	input = {
          kb_layout = "us";
          follow_mouse = true;
          mouse_refocus = false;
					natural_scroll = true;
				
          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
            tap_to_click = true;
            clickfinger_behavior = true;
            drag_lock = true;
          };
          sensitivity = 0;
				};

      	misc = {
        	disable_hyprland_logo = true;
        	mouse_move_enables_dpms = true;
        	key_press_enables_dpms = true;
					#background_color = 0x24273a;
      	};

      	decoration = {
        	rounding = 1;
        	active_opacity = 0.98;
        	inactive_opacity = 0.7;
        	fullscreen_opacity = 1.0;

        	shadow = {
						enabled = true;
						range = 30;
          	render_power = 3;

			    	# Uncomment for colored matching border shadows (Glow effect)
          	#"col.shadow" = lib.mkForce (rgba config.lib.stylix.colors.base0D "99");
          	#"col.shadow_inactive" = lib.mkForce (rgba config.lib.stylix.colors.base00 "99");
					};
					
        	blur = {
				  	enabled = true;
          	size = 12;
          	passes = 2;
          	ignore_opacity = true;
						new_optimizations = true;
						xray = true;
        	};
				};

      	dwindle = {
        	# See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        	#pseudotile = false; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
					force_split = 2;
        	preserve_split = true;# you probably want this
					#smart_split = true;
        	#no_gaps_when_only = 1; # If it's the only window int he layout, 1=don't show gaps
      	};

				"exec-once" = [
					"bash ~/.config/hypr/start.sh"
				];
		 	};
		};

		extraConfig = ''
		-- Workspaces
		hl.workspace_rule({ workspace = "1", monitor = "DP-1" })
		hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
		hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
	
		hl.workspace_rule({ workspace = "4", monitor = "eDP-1" })
		hl.workspace_rule({ workspace = "5", monitor = "eDP-1" })
		hl.workspace_rule({ workspace = "6", monitor = "eDP-1" })
		hl.workspace_rule({ workspace = "7", monitor = "eDP-1" })
		
		-- Layer Rules
		hl.layer_rule({ match = { namespace = "rofi" }, blur = true })
		hl.layer_rule({ match = { namespace = "notifications" }, blur = true })
		hl.layer_rule({ match = { namespace = "logout_dialog" }, blur = true })
		
		-- Key Bindings
		hl.bind("SUPER + M", hl.dsp.exit())
		hl.bind("SUPER + Q", hl.dsp.window.close())
		hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))

		hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"))
    hl.bind("SUPER + W", hl.dsp.exec_cmd("chromium"))
    hl.bind("SUPER + E", hl.dsp.exec_cmd("evolution"))
    hl.bind("SUPER + W", hl.dsp.exec_cmd("firefox"))
    hl.bind("SUPER + E", hl.dsp.exec_cmd("thunderbird"))

    hl.bind("SUPER + N", hl.dsp.exec_cmd("nemo"))
    hl.bind("SUPER + I", hl.dsp.exec_cmd("waypaper --folder ~/Wallpapers"))

		hl.bind("SUPER + 1", hl.dsp.focus({ workspace = "1" }))
		hl.bind("SUPER + 2", hl.dsp.focus({ workspace = "2" }))
		hl.bind("SUPER + 3", hl.dsp.focus({ workspace = "3" }))
		hl.bind("SUPER + 4", hl.dsp.focus({ workspace = "4" }))
		hl.bind("SUPER + 5", hl.dsp.focus({ workspace = "5" }))
		hl.bind("SUPER + 6", hl.dsp.focus({ workspace = "6" }))
		hl.bind("SUPER + 7", hl.dsp.focus({ workspace = "7" }))

		hl.bind("SUPER + ALT + 1", hl.dsp.window.move({ workspace = "1" }))
		hl.bind("SUPER + ALT + 2", hl.dsp.window.move({ workspace = "2" }))
		hl.bind("SUPER + ALT + 3", hl.dsp.window.move({ workspace = "3" }))
		hl.bind("SUPER + ALT + 4", hl.dsp.window.move({ workspace = "4" }))
		hl.bind("SUPER + ALT + 5", hl.dsp.window.move({ workspace = "5" }))
		hl.bind("SUPER + ALT + 6", hl.dsp.window.move({ workspace = "6" }))
		hl.bind("SUPER + ALT + 7", hl.dsp.window.move({ workspace = "7" }))

		hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
		hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

		hl.bind("SUPER + TAB", function()
			hl.dispatch(hl.dsp.window.cycle_next())
			hl.dispatch(hl.dsp.window.bring_to_top())
		end)

		hl.bind("SUPER + SHIFT + TAB", function()
			hl.dispatch(hl.dsp.window.cycle_prev())
			hl.dispatch(hl.dsp.window.bring_to_top())
		end)

		hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -q s +10%"))
		hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 10%-"))
		hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
		hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
		hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

		hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("~/.config/waybar/scripts/spotify-pause.sh"))

		hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"))
		hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
		hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
		hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))

		hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness=lower"))
		hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness=raise"))
		hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume=lower"))
		hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume=raise"))

		-- hl.bind("switch:on:Lid Switch", function()
		hl.bind("switch:on:1231ec0", function()
			hl.monitor({ output = "eDP-1", disabled = true})
		end, { locked = true })

		-- hl.bind("switch:off:Lid Switch", function()
		hl.bind("switch:off:1231ec0", function()
			hl.monitor({ output = "eDP-1", disabled = false})
		end, { locked = true })

		-- hl.bind("XF86Lock", hl.dsp.exec_cmd("hyprlock"))

		hl.bind("code:238", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +10"))
		hl.bind("code:237", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s 10-"))

		hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = "true" })
		hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = "true" })

		hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("rofi -show drun -show-icons"))
		hl.bind("SUPER + X", hl.dsp.exec_cmd("hyprlock"))

		hl.bind("PRINT", hl.dsp.exec_cmd("grimblast copy area"))
		'';
  };

  home.file = {
    # Set the custom launcher script
    ".config/hypr/start.sh" = {
        enable = true;
        executable = true;

        text = ''
          #!/usr/bin/env bash
          # https://wiki.hyprland.org/FAQ/#some-of-my-apps-take-a-really-long-time-to-open
          dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &

          # Set the wallpaper
          #swww init
					#swww-daemon --format xrgb

          # Set a random wallpaper
          #DIR=/home/${username}/Wallpapers
          #IMG=`ls $DIR | shuf -n 1`
          #swww img $DIR/$IMG -t random &

          # Restore last wallpaper
					waypaper --restore

          # Start Waybar
          waybar &

					# Clipboard history
					# wl-paste --watch cliphist store &
					# wl-paste --type text --watch cliphist store
					# wl-paste --type image --watch cliphist store
					# wl-clip-persist --clipboard regular
					
          # Autostart Programs
 				  blueman-applet &
				  sleep 1
					keepassxc &
					sleep 2
					syncthingtray --wait &

          # Set up the idle management daemon
          # swayidle -w \
          #     timeout 120       'swaylock -f && playerctl pause' \
          #     timeout 180       'hyprctl dispatch dpms off' \
          #     timeout 300       'systemctl suspend-then-hibernate' \
          #          resume       'hyprctl dispatch dpms on' \
          #          before-sleep 'swaylock -f' \
          #          before-sleep 'playerctl pause' &

          # Automatic device mounting 
          #udiskie --no-automount --smart-tray &
          udiskie --smart-tray &

          # Notification listener
					dunst

					#lxqt-session
      '';
    };
  };

}

