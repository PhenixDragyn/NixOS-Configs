{ pkgs, stable, unstable, buildSettings, ... }:

{
  home.file = { 
    ".config/polybar/launch.sh" = {
      executable = true;

      text = ''
#!/bin/sh

set -ex

export PATH="$PATH:${pkgs.xorg.xrandr}/bin"

sleep 1
num_monitors="$(xrandr --query | grep ' connected' | wc -l)"

main=$(xrandr | grep ' connected primary ' | cut -d' ' -f1)
side=$(xrandr | grep ' connected ' | grep -v ' connected primary ' | cut -d' ' -f1)

if [ $num_monitors -eq 1 ]; then
  polybar laptop1 2>&1 | tee -a /tmp/polybar.log & disown
  polybar laptop2 2>&1 | tee -a /tmp/polybar.log & disown
  polybar laptop3 2>&1 | tee -a /tmp/polybar.log & disown
  polybar laptop4 2>&1 | tee -a /tmp/polybar.log & disown
  polybar laptop5 2>&1 | tee -a /tmp/polybar.log & disown
else
  MONITOR=$side polybar monitor1 2>&1 | tee -a /tmp/polybar.log & disown
  MONITOR=$side polybar monitor2 2>&1 | tee -a /tmp/polybar.log & disown
  MONITOR=$side polybar monitor3 2>&1 | tee -a /tmp/polybar.log & disown
  MONITOR=$side polybar monitor4 2>&1 | tee -a /tmp/polybar.log & disown
  MONITOR=$side polybar monitor5 2>&1 | tee -a /tmp/polybar.log & disown
fi

#for s in $side; do
#  MONITOR="$s" polybar monitor1 &
#done

#MONITOR="$main" polybar laptop1 &
      '';
    };

    ".config/polybar/scripts" = {
      source = ../${buildSettings.username}/config/polybar/scripts;
      recursive = true;
    };
  };
  
  services = {
    polybar = {
      enable = true;

      package = pkgs.polybar.override {
        pulseSupport = true;
      };

      script = with pkgs; ''
      '';

      config = let
        #background = "\${xrdb:background}";
        #background-alt = "\${xrdb:color0}";
        #foreground = "\${xrdb:color7}";
        #foreground-alt = "\${xrdb:color12}";
        #blue = "\${xrdb:color4}";
        #orange = "\${xrdb:color9}";
      	#yellow = "\${xrdb:color3}";
      	#purple = "\${xrdb:color5}";
        #green = "\${xrdb:color2}";
        #alert = "\${xrdb:color1}";
      	#border = "\${xrdb:color12}";

        fonts = {
          font-0 = "Fira Code Nerd Font:size=10;2";
          font-1 = "JetBrainsMono Nerd Font:size=10;3";
          font-2 = "Siji:size=14;2";
          font-3 = "Font Awesome 5 Free:style=Regular:pixelsize=10;1";
          font-4 = "Font Awesome 5 Free:style=Solid:pixelsize=10;1";
          font-5 = "Font Awesome 5 Brands:pixelsize=10;1";
        };

      in 
      {
        "colors" = {
           background = "\${xrdb:background}";
           background-alt = "\${xrdb:color0}";
           foreground = "\${xrdb:color7}";
           foreground-alt = "\${xrdb:color12}";
           blue = "\${xrdb:color4}";
           orange = "\${xrdb:color9}";
           yellow = "\${xrdb:color3}";
           purple = "\${xrdb:color5}";
           green = "\${xrdb:color2}";
           alert = "\${xrdb:color1}";
           border = "\${xrdb:color8}";
         };

        "bar/laptop1" = fonts // {
          monitor = "\${env:MONITOR:}";

          override-redirect = false;

          wm-restack = "bspwm";

          height = 23;
          width = 55;
          offset-x = "0.5%";
          offset-y = 3;
          radius = 0;

          fixed-center = true;
          bottom = false ;

          background = "\${colors.background}";
          foreground = "\${colors.foreground}";

          line-size = 3;
          line-color = "\${colors.alert}";

          border-size = 2;
	        border-color = "\${colors.border}";

          padding-left = 1;
          padding-right = 1;

          module-margin-left = 1;
          module-margin-right = 1;

          modules-center = "nixos";

          #tray-position = "right";
          #tray-padding = 3;

          #scroll-up = "i3wm-wsnext";
          #scroll-down = "i3wm-wsprev";
        };

        "bar/laptop2" = fonts // {
          "inherit" = "bar/laptop1";
          monitor = "\${env:MONITOR:}";

          width = 465;
	        height = 23;
          offset-x = "4%";
	        offset-y = 3;

          modules-center = "uptime sep weather";
        };

        "bar/laptop3" = fonts // {
          "inherit" = "bar/laptop1";
          monitor = "\${env:MONITOR:}";

          width = 820;
	        height = 23;
          offset-x = "28.7%";
	        offset-y = 3;

          modules-center = "cpu memory filesystem sep wlan eth battery backlight-acpi pulseaudio sep tray";
        };

        "bar/laptop4" = fonts // {
          "inherit" = "bar/laptop1";
          monitor = "\${env:MONITOR:}";

          width = 465;
	        height = 23;
          offset-x = "72%";
	        offset-y = 3;

          modules-center = "bspwm sep date time";
        };

        "bar/laptop5" = fonts // {
          "inherit" = "bar/laptop1";
          monitor = "\${env:MONITOR:}";

          width = 55;
	        height = 23;
          offset-x = "96.75%";
	        offset-y = 3;

          modules-center = "power";
        };

	
        "bar/monitor1" = fonts // {
          "inherit" = "bar/laptop1";
          monitor = "\${env:MONITOR:}";

          width = 55;
          height = 23;
          offset-x = "0.25%";
          offset-y = 3;

          modules-center = "nixos";
        };

      	"bar/monitor2" = fonts // {
          "inherit" = "bar/laptop1";
          monitor = "\${env:MONITOR:}";

          width = 665;
          height = 23;
          offset-x = "6%";
          offset-y = 3;

          modules-center = "weather sep spotify spo-previous spo-pause spo-next";
	      };

	      "bar/monitor3" = fonts // {
          "inherit" = "bar/laptop1";
          monitor = "\${env:MONITOR:}";

          width = 940;
          height = 23;
          offset-x = "36.3%";
          offset-y = 3;

          modules-center = "cpu memory filesystem sep wlan eth battery backlight-acpi pulseaudio sep hiddenWindows sep tray";
	      };

      	"bar/monitor4" = fonts // {
          "inherit" = "bar/laptop1";
          monitor = "\${env:MONITOR:}";

          width = 665;
          height = 23;
          offset-x = "75%";
          offset-y = 3;

          modules-center = "bspwm2 sep date time";
	      };

       	"bar/monitor5" = fonts // {
          "inherit" = "bar/laptop1";
          monitor = "\${env:MONITOR:}";

          width = 55;
          height = 23;
          offset-x = "98.25%";
          offset-y = 3;

          modules-center = "power";
	      };


        "settings" = {
          screenchange-reload = "true";
          pseudo-transparency = "false";

          compositing-background = "source";
          compositing-foreground = "over";
          compositing-overline = "over";
          compositing-underline = "over";
          compositing-border = "over";
        };

        "global/wm" = {
          margin-top = 0;
          margin-bottom = 0;
        };


        "module/sep" = {
          type = "custom/text";
          format = "|";
        };

        "module/arrow" = {
          type = "custom/text";
          content = "%{T2} %{T-}";
          content-font = 2;
          content-foreground = "\${colors.foreground}";
          content-background = "\${colors.background}";
        };

        "module/bspwm" = {
          type = "internal/bspwm";
          pin-workspaces = "false";
          ws-icon-0 = "I;%{T3} %{T-}";
          ws-icon-1 = "II;%{T3}%{T-}";
          ws-icon-2 = "III;%{T3}%{T-}";
          format = "<label-state> <label-mode>";
          label-focused = "%icon%";
          label-focused-foreground = "\${colors.blue}";
          label-focused-background= "\${colors.background}";
          label-occupied = "%icon%";
          label-occupied-foreground = "\${colors.yellow}";
          label-urgent = "%icon%";
          label-urgent-foreground = "\${colors.alert}";
          label-urgent-background = "\${colors.background}";
          label-urgent-underline = "\${colors.alert}";
          label-empty = "%icon%";
          label-empty-foreground = "\${colors.foreground}";
          label-separator = " ";
          label-separator-foreground = "\${colors.foreground-alt}";
          label-separator-padding = 1;
      	};

        "module/bspwm2" = {
          type = "internal/bspwm";
          pin-workspaces = "false";
          ws-icon-0 = "I;%{T3}%{T-}";
          ws-icon-1 = "II;%{T3}%{T-}";
          ws-icon-2 = "III;%{T3}%{T-}  / ";
          ws-icon-3 = "IV;%{T3}%{T-}";
          ws-icon-4 = "V;%{T3}%{T-}";
          ws-icon-5 = "VI;%{T3}%{T-}";
          format = "<label-monitor><label-state><label-mode>";
          label-monitor = "%name%: ";
          label-focused = "%icon%";
          label-focused-foreground = "\${colors.blue}";
          label-focused-background= "\${colors.background}";
          label-occupied = "%icon%";
          label-occupied-foreground = "\${colors.yellow}";
          label-urgent = "%icon%";
          label-urgent-foreground = "\${colors.alert}";
          label-urgent-background = "\${colors.background}";
          label-urgent-underline = "\${colors.alert}";
          label-empty = "%icon%";
          label-empty-foreground = "\${colors.foreground}";
          label-separator = " ";
          label-separator-foreground = "\${colors.foreground-alt}";
          label-separator-padding = 1;
        };

        "module/xwindow" = {
          type = "internal/xwindow";
          #label = "%title:0:30:...%";
          label = "%title%";
          label-maxlen = 30;
          label-empty = " Desktop";
        };

        "module/pulseaudio" = {
          type = "internal/pulseaudio";
          use-ui-max = "false";
          interval = "5";
          click-right = "pavucontrol-qt";
          format-volume = "<ramp-volume> <label-volume>";
          label-volume = "%percentage%";
          label-volume-foreground = "\${colors.foreground}";
          label-muted = "%{T3}%{T-}";
          label-muted-foreground = "\${colors.alert}";
          ramp-volume-0 = "%{T3}%{T-}";
          ramp-volume-1 = "%{T3}%{T-}";
          ramp-volume-2 = "%{T3}%{T-}";
          bar-volume-width = 10;
          bar-volume-foreground-0 = "\${colors.foreground}";
          bar-volume-foreground-1 = "\${colors.foreground}";
          bar-volume-foreground-2 = "\${colors.foreground}";
          bar-volume-foreground-3 = "\${colors.foreground}";
          bar-volume-foreground-4 = "\${colors.foreground}";
          bar-volume-foreground-5 = "\${colors.blue}";
          bar-volume-foreground-6 = "\${colors.orange}";
          bar-volume-gradient = "false";
          bar-volume-indicator = "|";
          bar-volume-indicator-font = 2;
          bar-volume-fill = "─";
          bar-volume-fill-font = 2;
          bar-volume-empty = "─";
          bar-volume-empty-font = 2;
          bar-volume-empty-foreground = "\${colors.foreground}";
        };

        "module/battery" = {
          type = "internal/battery";
          battery = "BAT0";
          adapter = "ACAD";
          full-at = 98;
          format-charging = "<animation-charging> <label-charging>";
          label-charging = "%percentage%%";
          #format-charging-underline = "#ffb52a";
          format-discharging = "<ramp-capacity> <label-discharging>";
          label-discharging = "%percentage%%";
          #;format-discharging-underline = ${self.format-charging-underline};
          #format-full-prefix = " ";
          format-full-prefix = "  ";
          format-full = "<label-full>";
          #label-full = %{T2}%{F#A3BE8C} %{F-}%{T-} %percentage%
          #format-full-prefix-foreground = ${colors.foreground-alt}
          #label-full = %{T2} %{T-} %percentage%
          label-full = "%percentage%";
          #label-full-foreground = ${color.color3}
          format-full-prefix-foreground = "\${colors.foreground}";
          #format-full-underline = ${self.format-charging-underline}

          ramp-capacity-0 = "%{T2} %{T-}";
          ramp-capacity-0-foreground = "\${colors.alert}";
          ramp-capacity-1 = "%{T2} %{T-}";
          ramp-capacity-1-foreground = "\${colors.alert}";
          ramp-capacity-2 = "%{T2} %{T-}";
          ramp-capacity-2-foreground = "\${colors.alert}";
          ramp-capacity-3 = "%{T2} %{T-}";
          ramp-capacity-3-foreground = "\${colors.yellow}";
          ramp-capacity-4 = "%{T2} %{T-}";
          ramp-capacity-4-foreground = "\${colors.yellow}";
          ramp-capacity-5 = "%{T2} %{T-}";
          ramp-capacity-5-foreground = "\${colors.yellow}";
          ramp-capacity-6 = "%{T2} %{T-}";
          ramp-capacity-6-foreground = "\${colors.yellow}";
          ramp-capacity-7 = "%{T2} %{T-}";
          ramp-capacity-7-foreground = "\${colors.green}";
          ramp-capacity-8 = "%{T2} %{T-}";
          ramp-capacity-8-foreground = "\${colors.green}";
          ramp-capacity-9 = "%{T2} %{T-}";
          ramp-capacity-9-foreground = "\${colors.green}";
          ramp-capacity-foreground = "\${colors.foreground}";

          animation-charging-0 = "%{T2} %{T-}";
          animation-charging-1 = "%{T2} %{T-}";
          animation-charging-2 = "%{T2} %{T-}";
          animation-charging-3 = "%{T2} %{T-}";
          animation-charging-4 = "%{T2} %{T-}";
          animation-charging-5 = "%{T2} %{T-}";
          animation-charging-6 = "%{T2} %{T-}";
          animation-charging-foreground = "\${colors.purple}";
          animation-charging-framerate = 750;

          #animation-discharging-0 = " ";
          #animation-discharging-1 = " ";
          #animation-discharging-2 = " ";
          #animation-discharging-foreground = "\${colors.foreground-alt}";
          #animation-discharging-framerate = 750;
        };

        "module/cpu" = {
          type = "internal/cpu";
          interval = "2";

          format-prefix = " ";
          #format-prefix = " ";
          #format-prefix = "舘 ";
          format-prefix-foreground = "\${colors.orange}";
          #format-underline = "#07ACFF";
          label = "%percentage%%";
          #label = "%percentage:3%%";

          #ramp-coreload-0 = "▁";
          #amp-coreload-1 = "▂";
          #amp-coreload-2 = "▃";
          #amp-coreload-3 = "▄";
          #ramp-coreload-4 = "▅";
          #ramp-coreload-5 = "▆";
          #ramp-coreload-6 = "▇";
          #ramp-coreload-7 = "█";
        };

        "module/memory" = {
          type = "internal/memory";
          interval = "2";
          format-prefix = " ";
          #format-prefix = " "
          format-prefix-foreground = "\${colors.green}";
          #format-underline = "#05D8E8";
          #label = "%gb_used%";
	        label = "%percentage_used%%";
        };

        "module/filesystem" = {
          type = "internal/fs";
          interval = "10";
	        fixed-values = "false";

          mount-0 = "/";
          #mount-1 = "/home";
          #mount-2 = "/var";

          format-mounted-prefix = " ";
          format-mounted-foreground = "\${colors.purple}";
          #format-mounted-underline = "#06E87A";

          #label-mounted = "%{T2}%mountpoint%%{T-}:%free%%";
          label-mounted = "%{T2}%mountpoint%%{T-}:%percentage_used%%";
          #label-mounted-foreground = "\${colors.foreground-alt}";

          label-unmounted = "%{T2}%mountpoint%%{T-} not mounted";
          #label-unmounted-foreground = "\${colors.alert}";
        };

        "module/time" = {
          type = "internal/date";
          interval = "1.0";

          time = "%I:%M %p";

          label = "%time%";
          #label-foreground = "\${colors.foreground-alt}";

          format-prefix = "%{T2}  %{T-}";
          format-prefix-foreground = "\${colors.blue}";
        };

        "module/date" = {
          type = "internal/date";
          interval = "1.0";

          date = "%a, %e %b";

          label = "%date%";
          #label-foreground = "\${colors.foreground-alt}";

          format-prefix ="%{T2}  %{T-}";
          format-prefix-foreground = "\${colors.green}";
        };

        "module/datetime" = {
          type = "nternal/date";
          interval = "1.0";

          date ="%{T2} %{T-} %a, %e %b";
          date-alt = "%{T2} %{T-} %a, %e %b %Y ";

          time = "%{T2} %{T-} %I:%M %p";
          time-alt = "%{T2} %{T-} %I:%M:%S %p";

          format-prefix = "";
          format-prefix-foreground = "\${colors.yellow}";
          #format-underline = #0a6cf5

          label = "%date%  %time%";
        };

        "module/eth" = {
          type = "internal/network";
          interval = "3.0";

       	  interface = "enp0s1";

          format-connected-prefix = " ";
          #format-connected-underline = "#06FFCC";
          format-connected-prefix-foreground = "\${colors.foreground}";

	        label-connected = "%local_ip%";
          #label-connected = "%ifname% ( %upspeed:9%  %downspeed:9%)";

          format-disconnected = "<label-disconnected>";
          #format-disconnected-underline = "#06FFCC";
          label-disconnected = "";
          label-disconnected-foreground = "\${colors.foreground}";
        };

        "module/wlan" = {
          type = "internal/network";
          interval = "3.0";

          interface = "wlp0s20f3";

          #format-connected = "<ramp-signal> <label-connected>";
          format-connected-prefix = " ";
          format-connected-prefix-foreground = "\${colors.foreground}";

	        label-connected = "%local_ip%";
          #label-connected = "%essid% ( %upspeed:9%  %downspeed:9%)";

          ramp-signal-0 = "▁";
          ramp-signal-1 = "▂";
          ramp-signal-2 = "▃";
          ramp-signal-3 = "▄";
          ramp-signal-4 = "▅";
          ramp-signal-5 = "▆";
          ramp-signal-6 = "▇";
          ramp-signal-7 = "█";
          ramp-signal-foreground = "\${colors.foreground}";
        };

        "module/xkeyboard" = {
          type = "nternal/xkeyboard";

          blacklist-0 = "scroll lock";
          blacklist-1 = "num lock";

          #format = "<label-layout> <label-indicator>";
          format = "  <label-indicator>";
          format-spacing = 0;

          #format-prefix = "  ";
          #format-prefix-foreground = ${color.color2};
          ##format-prefix-underline = ${colors.orange};

          label-layout = "%icon%";
          #label-layout = "%name%";
          label-layout-padding = 2;
          label-layout-background = "\${colors.orange}";
          #label-layout-underline = "\${colors.orange}";

          label-indicator-on = "%icon%";
          #label-indicator-on = "+%icon%";
          #label-indicator-off = "-%icon%";
          #label-indicator-on = "+%name%";
          #label-indicator-off = "-%name%";

          label-indicator-padding = 0;
          label-indicator-margin = 0;
          #label-indicator-background = "\${colors.orange}";
          #label-indicator-underline = "\${colors.orange}";

          layout-icon-default = "";
          #layout-icon-default = " ";
          #layout-icon-0 = " ";
          #layout-icon-1 = " ";
          layout-icon-0 = "us;U";
          layout-icon-1 = "ch;C";

          indicator-icon-default = "";
          indicator-icon-0 = "caps lock;;";
          indicator-icon-1 = "scroll lock;;";
          indicator-icon-2 = "num lock;;";
          #indicator-icon-0 = "caps lock;-CL;+CL";
          #indicator-icon-1 = "scroll lock;;+SL";
          #indicator-icon-2 = "num lock;-NL;+NL";
        };

        "module/temperature" = {
          type = "internal/temperature";
          thermal-zone = "0";
          warn-temperature = "60";

          #format-underline = "#0561E8";
          format = "<ramp> <label>";
          #format-warn-underline = "#0561E8";
          format-warn = "<ramp> <label-warn>";

          label = "%temperature-c%";
          label-warn = "%temperature-c%";
          label-warn-foreground = "\${colors.alert}";

          ramp-0 = "";
          ramp-1 = "";
          ramp-2 = "";
          ramp-foreground = "\${colors.blue}";
        };

        "module/xbacklight" = {
          type = "internal/xbacklight";

          format = "<label> <bar>";
          label = "BL";

          bar-width = "10";
          bar-indicator = "|";
          bar-indicator-foreground = "\${colors.orange}";
          bar-indicator-font = "2";
          bar-fill = "─";
          bar-fill-font = "2";
          bar-fill-foreground = "\${colors.orange}";
          bar-empty = "─";
          bar-empty-font = "2";
          bar-empty-foreground = "\${colors.orange}";
        };

        "module/backlight-acpi" = {
          "inherit" = "module/xbacklight";

          type = "internal/backlight";
          card = "intel_backlight";
          enable-scroll = "true";

          #format-prefix = "%{T2}%{T-} "
          format = "<ramp> <label>";

          label = "%percentage%";

          ramp-0 = "%{T2}%{T-}";
          ramp-0-foreground = "\${colors.orange}";
          ramp-1 = "%{T2}%{T-}";
          ramp-1-foreground = "\${colors.orange}";
          ramp-2 = "%{T2}%{T-}";
          ramp-2-foreground = "\${colors.orange}";
        };

              "module/tray" = {
          type = "internal/tray";

          tray-postion = "adaptive";
          tray-padding = 5;
        };

        "module/power" = {
          type = "custom/text";
          format-spacing = 2;
          format = "%{T2} %{T-}";
          format-foreground = "\${colors.orange}";
          format-padding=1;
          click-left = "lxqt-leave";
        };

        "module/powermenu" = {
          type = "custom/menu";

          format-spacing = "1";

          label-open = "";
          label-open-foreground = "\${colors.orange}";
          label-close = " cancel";
          label-close-foreground = "\${colors.alert}";
          label-separator = "|";
          label-separator-foreground = "\${colors.foreground-alt}";

          menu-0-0 = "reboot";
          menu-0-0-exec = "menu-open-1";
          menu-0-1 = "power off";
          menu-0-1-exec = "menu-open-2";

          menu-1-0 = "cancel";
          menu-1-0-exec = "menu-open-0";
          menu-1-1 = "reboot";
          menu-1-1-exec = "systemctl reboot";

          menu-2-0 = "power off";
          menu-2-0-exec = "systemctl poweroff";
          menu-2-1 = "cancel";
          menu-2-1-exec = "menu-open-0";
        };

        "module/nixos" = {
          type = "custom/text";
          content = " ";
          content-font = 2;
          content-foreground = "\${colors.blue}";
          content-margin = 0;
        };

        "module/calendar" = {
          type = "custom/text";
          content = " ";
          content-font = 2;
          content-foreground = "\${colors.yellow}";
          content-margin = 0;
          click-left = "~/.config/polybar/scripts/Calendar/calendar.sh";
        };

        "module/hiddenWindows" = {
          type = "custom/script";
          exec = "bspc query -N -n .hidden.window | wc -l";
          format-prefix = " ";
          format-prefix-foreground = "\${colors.foreground-alt}";
          interval = "2";
        };

        "module/weather" = {
          type = "custom/script";
          exec = "python -u ~/.config/polybar/scripts/weather.py";
          interval = "10";

          format = "<label>";
          format-prefix = "  ";
          format-prefix-foreground = "\${colors.blue}";

          tail = "true";
        };

        "module/uptime" = {
          type = "custom/script";
          exec = "uptime | awk -F, '{sub(\".*up \",x,$1); print $1}'";
          interval = "100";

          format = "<label>";
          format-prefix = "  ";
          format-prefix-foreground = "\${colors.purple}";

          label = "Uptime: %output%";
        };

        "module/spo" = {
          type = "custom/text";
          content = " ";
          content-font = 2;
          content-foreground = "\${colors.green}";
          content-margin = 0;
        };

        "module/spotify" = {
          type = "custom/script";
          exec = "~/.config/polybar/scripts/Spotify/spotify.sh";
          interval = "1";

          label = "%output%";
          #label-foreground = "\${colors.foreground-alt}";

          format = "<label>";
          format-prefix = "%{T2}  %{T-}";
          format-prefix-foreground = "\${colors.green}";

          click-left = "spotify";
        };

        "module/spo-previous" = {
          type = "custom/text";
          exec = "~/.config/polybar/scripts/Spotify/spotify-previous.sh";
          content = "󰒮";
          content-font = 2;
          #content-foreground = "\${colors.foreground-alt}";
          content-margin = 0;
          click-left = "~/.config/polybar/scripts/Spotify/spotify-previous.sh";
        };

        "module/spo-next" = {
          type = "custom/text";
          exec = "~/.config/polybar/scripts/Spotify/spotify-next.sh";
          content = "󰒭";
          content-font = 2;
          #content-foreground = "\${colors.foreground-alt}";
          content-margin = 0;
          click-left = "~/.config/polybar/scripts/Spotify/spotify-next.sh";
        };

        "module/spo-pause" = {
          type = "custom/script";
          exec = "~/.config/polybar/scripts/Spotify/spotify-status.sh";
          #format-foreground = "\${colors.foreground-alt}";
          format = "<label>";
          format-font = 2;
          label = "%output%";
          interval = "0.1";
          click-left = "~/.config/polybar/scripts/Spotify/spotify-pause.sh";
        };
      };
    };
  };
}
