{ config, pkgs, inputs, username, ... }: 

# let
#   monitors = (import ./monitors.nix { }).${hostname};
# in
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      # pkgs.hyprlandPlugins.hyprbars
      pkgs.hyprlandPlugins.hyprexpo
      # pkgs.hyprlandPlugins.hy3
    ];
    extraConfig = ''
      # Resize
      bind = SUPER, R, exec, notify-send 'Entered resize mode.  Press ESC to quit.'
      bind = SUPER, R, submap, resize
      submap = resize
      binde = , H, resizeactive,-50 0
      binde = , L, resizeactive,50 0
      binde = , K, resizeactive,0 -50
      binde = , J, resizeactive,0 50
      binde = , left, resizeactive,-50 0
      binde = , right, resizeactive,50 0
      binde = , up, resizeactive,0 -50
      binde = , down, resizeactive,0 50
      bind  = , escape, submap, reset
      submap = reset
      '';
    settings = {
      #monitor = ",highrr,auto,1.175";
      #inherit (monitors) monitor workspace;
			# workspace = 1, monitor:eDP-1, default:true;
			# workspace = 2, monitor:eDP-1, default:true;
			# workspace = 3, monitor:eDP-1, default:true;
			# workspace = 4, monitor:DP-1, default:true;
			# workspace = 5, monitor:DP-1, default:true;
			# workspace = 6, monitor:DP-1, default:true;

			# monitor = [
   #      "eDP-1, 1920x1200, 0x0, 1" 
   #      "DP-1, 2560x1440, 0x-1440, 1" 
			# ];
			#
			# workspace = [ "1, monitor:DP-1, default:true"
			# 	"2, monitor:DP-1"
			# 	"3, monitor:DP-1"
			#
			# 	"4, monitor:eDP-1, default:true"
			# 	"5, monitor:eDP-1"
			# 	"6, monitor:eDP-1"
			# ];

      plugin = {
        hyprexpo = {
          gap_size = 8;
          workspace_method = "first 1";
          enable_gesture = true;
          gesture_fingers = 3;
          gesture_positive = false;
        };
        hyprbars = {
          bar_height = 25;
          bar_part_of_window = true;
          bar_color = config.lib.stylix.colors.base04;
          # example buttons (R -> L)
          # hyprbars-button = color, size, on-click
          hyprbars-button = [
            "rgb(ff4040), 10, 󰖭 , hyprctl dispatch killactive"
            "rgb(eeee11), 10,  , hyprctl dispatch fullscreen 1"
          ];
        };
      };
      layerrule = [
        #"blur, waybar"
        "blur, rofi"
        "blur, notifications"
        "ignorezero, notifications"
      ];
      xwayland.force_zero_scaling = false;
      general = {
          gaps_in = "5";
          gaps_out = "10";
          border_size = "2";
          resize_on_border = "true";
          extend_border_grab_area = "15";

          #col.active_border = conf.lib.stylix.colors.base04;
          #col.inactive_border = conf.lib.stylix.colors.base04;

          layout = "dwindle";
      };
      input = {
          kb_layout = "us";
          follow_mouse = "1";
          mouse_refocus = false;
          touchpad = {
              natural_scroll = true;
              disable_while_typing = true;
              tap-to-click = true;
              clickfinger_behavior = true;
              drag_lock = true;
          };
          sensitivity = 0;
      };
			# master = {
			#   new_status = master;
			# }
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };
      misc = {
        disable_hyprland_logo = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
				#background_color = 0x24273a;
      };
      decoration = {
        rounding = 0;
        active_opacity = 0.95;
        inactive_opacity = 0.8;
        fullscreen_opacity = 1.0;

        drop_shadow = true;
        shadow_range = 30;
        shadow_render_power = 3;
			
        #col.shadow = conf.lib.stylix.colors.base04;
        #col.shadow_inactive = 0xff$baseAlpha;

        blur = {
				  enabled = true;
          size = 12;
          passes = 3;
          ignore_opacity = true;
					new_optimizations = true;
					xray = true;
        };
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows,1,7,myBezier"
          "windowsOut,1,7,default,popin 80%"
          "border,1,10,default"
          "borderangle,1,8,default"
          "fade,1,7,default"
          "workspaces,1,6,default"
        ];
      };
      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true;# you probably want this
				#smart_split = true;
        #no_gaps_when_only = 1; # If it's the only window int he layout, 1=don't show gaps
      };
      windowrule = [
        "noblur,^(firefox)$" # disables blur for firefox
        "opacity 1.0 override,^(firefox)$" # Sets opacity to 1
        "noblur,^(thunderbird)$" # disables blur for firefox
        "opacity 1.0 override,^(thunderbird)$" # Sets opacity to 1
        "noblur,^(steam)$" # disables blur for steam
        "opacity 1.0 override,^(steam)$" # Sets opacity to 1
        "noblur,^(codium)$" # disables blur for codium
        "opacity 0.9 override,^(codium)$" # Sets opacity to 0.9
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
      ];

      windowrulev2 = [
        ''float, class:(rofi), title:(rofi)''
      ];

      bind = [
      ''SUPER,, hyprexpo:expo, toggle''
      ''SUPER, RETURN, exec, kitty''
      ''SUPER, W, exec, firefox''

      ''SUPER, Q, killactive,''
      ''SUPER, M, exit,''
      ''SUPER, F, togglefloating,''
      #''SUPER, P, pseudo, # dwindle''
      ''SUPER, J, togglesplit, # dwindle''
      #''SUPER, S, exec, steam -vgui''
      #''SUPER, B, exec, rofi-rbw --action copy --no-folder''
      ''SUPER_SHIFT, L, exec, logseq''

      # Move focus with mainMod + arrow keys
      # ''SUPER SHIFT, left, movefocus, l''
      # ''SUPER SHIFT, right, movefocus, r''
      # ''SUPER SHIFT, up, movefocus, u''
      # ''SUPER SHIFT, down, movefocus, d''
      #
      # ''SUPER SHIFT, H, movefocus, l''
      # ''SUPER SHIFT, L, movefocus, r''
      # ''SUPER SHIFT, K, movefocus, u''
      # ''SUPER SHIFT, J, movefocus, d''

      # Switch workspaces with mainMod + [0-9]
      ''SUPER, 1, workspace, 1''
      ''SUPER, 2, workspace, 2''
      ''SUPER, 3, workspace, 3''
      ''SUPER, 4, workspace, 4''
      ''SUPER, 5, workspace, 5''
      ''SUPER, 6, workspace, 6''
      # ''SUPER, 7, workspace, 7''
      # ''SUPER, 8, workspace, 8''
      # ''SUPER, 9, workspace, 9''
      # ''SUPER, 0, workspace, 10''

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      ''SUPER_ALT, 1, movetoworkspace, 1''
      ''SUPER_ALT, 2, movetoworkspace, 2''
      ''SUPER_ALT, 3, movetoworkspace, 3''
      ''SUPER_ALT, 4, movetoworkspace, 4''
      ''SUPER_ALT, 5, movetoworkspace, 5''
      ''SUPER_ALT, 6, movetoworkspace, 6''
      # ''SUPER SHIFT, 7, movetoworkspace, 7''
      # ''SUPER SHIFT, 8, movetoworkspace, 8''
      # ''SUPER SHIFT, 9, movetoworkspace, 9''
      # ''SUPER SHIFT, 0, movetoworkspace, 10''

      # Scroll through existing workspaces with mainMod + scroll
      ''SUPER, mouse_down, workspace, e+1''
      ''SUPER, mouse_up, workspace, e-1''

      #############################################################################
      # Custom keybinds
      # Show Rofi on SUPER-SPACE
      # ''SUPER, space, exec, fuzzel''
      ''SUPER, space, exec, rofi -show drun -show-icons''

      # Take a screenshot with the Print key''
      #'', Print, exec, grim -g "$(slurp)" | wl-copy -t image/png''

      ''SUPER, w, exec, firefox''
      ''SUPER, e, exec, thunderbird''
      ''SUPER, n, exec, nautilus''

      # Move to the previous / next workspace with SUPER-LEFT and SUPER-RIGHT
      # ''SUPER      , right, workspace, e+1''
      # ''SUPER      , left , workspace, e-1''
      # ''SUPER SHIFT, right, movetoworkspace, e+1''
      # ''SUPER SHIFT, left , movetoworkspace, e-1''
      # ''SHIFT ALT, L, workspace, e+1''
      # ''SHIFT ALT, H, workspace, e-1''

      # Lock the screen, send to swaylock and pause music
      ''SUPER, X, exec, hyprlock''
      ''SUPER, X, exec, playerctl pause''

      # to switch between windows in a floating workspace
      ''SUPER ,Tab, cyclenext,          # change focus to another window''
      ''SUPER ,Tab, bringactivetotop,   # bring it to the top''

			# Audo controls
      #'', XF86AudioMute, exec, swayosd --output-volume=mute-toggle''
      '', XF86AudioMute, exec, playerctl play-pause''
      '', XF86AudioPrev, exec, playerctl previous''
      '', XF86AudioNext, exec, playerctl next''
      ];
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        ''LCTRL SHIFT, mouse:272, movewindow''
        ''LCTRL SHIFT, mouse:273, resizewindow''
      ];
      binde = [
        '', XF86AudioPlay, exec, playerctl play-pause''
        '', XF86AudioNext, exec, playerctl next''
        '', XF86MonBrightnessDown, exec, swayosd-client --brightness=lower''
        '', XF86MonBrightnessUp,   exec, swayosd-client --brightness=raise''
        '', XF86AudioMute,         exec, swayosd-client --output-volume=mute-toggle''
        '', XF86AudioLowerVolume,  exec, swayosd-client --output-volume=lower''
        '', XF86AudioRaiseVolume,  exec, swayosd-client --output-volume=raise''
      ];
      bindl = [
        '',switch:on:1241ec0,exec,hyprctl keyword monitor "eDP-1, 2560x1600, 0x0, 1"''
        '',switch:off:1241ec0,exec,hyprctl keyword monitor "eDP-1, disable"''
      ];

      exec-once = ''bash ~/.config/hypr/start.sh'';
    };
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
          swww init
					swww-daemon --format xrgb

          # Waybar
          waybar &

          # Set up the idle management daemon
          # swayidle -w \
          #     timeout 120       'swaylock -f && playerctl pause' \
          #     timeout 180       'hyprctl dispatch dpms off' \
          #     timeout 300       'systemctl suspend-then-hibernate' \
          #          resume       'hyprctl dispatch dpms on' \
          #          before-sleep 'swaylock -f' \
          #          before-sleep 'playerctl pause' &

          # Automatic device mounting 
          udiskie &

          DIR=/home/${username}/Wallpapers
          IMG=`ls $DIR | shuf -n 1`
          swww img $DIR/$IMG -t random &

          # Notification listener
          #mako 
      '';
    };
  };

}
