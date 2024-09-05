{ system, ... }:

let 
  xbackend = if ( system == "x86_64-linux" ) then "xrender" else "xrender"; 
in
{
  services.picom = {
    enable = true;
    settings = {
      transition-length = 1;
      transition-pow-x = 1;
      transition-pow-y = 1;
      transition-pow-w = 1;
      transition-pow-h = 1;
      size-transition = true;

      #animations = true;
      #animation-stiffness = 300.0;
      #animation-dampening = 35.0;
      #animation-clamping = false;
      #animation-mass = 1;
      #animation-for-workspace-switch-in = "auto";
      #animation-for-workspace-switch-out = "auto";
      #animation-for-open-window = "slide-down";
      #animation-for-menu-window = "none";
      #animation-for-transient-window = "slide-down";

      shadow = true;
      shadow-radius = 15;
      shadow-offset-x = -15;
      shadow-offset-y = -15;
      shadow-red = 0.356863;
      shadow-green = 0.611765;
      shadow-blue = 0.792157;
      shadow-exclude = [ 
        "!focused"
        "name = 'Notification'"
        "name = 'qtfm'"
        "name = 'qimgv'"
        "name = 'qt5ct'"
        "name = 'qt6ct'"
        "name = 'qpdfview'"
        "name = 'screengrab'"
        "name = 'luckybackup'"
        "name = 'Syncthingtray'"
        "name = 'arqiver'"
        "name = 'Notes'"
        "name = 'QtPass'"
        "name = 'nm-tray'"
        "name = 'nobleNote'"
        "name = 'steam'"
        "class_g = 'i3bar'"
        "class_g ?= 'Conky'"
        "class_g ?= 'rofi'"
        "class_g ?= 'Syncthingtray'"
        "class_g ?= 'Syncthing Tray'"
        "class_g ?= 'qlipper'"
        "class_g ?= 'Notify-osd'"
        "window_type = 'menu'"
        "window_type = 'dropdown_menu'"
        "window_type = 'popup_menu'"
        "window_type = 'tooltip'" 
      ];

      fading = true;
      fade-in-step = 0.03;
      fade-out-step = 0.03;
      fade-delta = 30;
      fade-exclude = [ 
        "class_g = 'dmenu'"
        "window_type = 'menu'"
        "window_type = 'dropdown_menu'"
        "window_type = 'popup_menu'"
        "window_type = 'tooltip'" 
      ];

      active-opacity = 0.95;
      inactive-opacity = 0.85;
      frame-opacity = 1.0;
      inactive-opacity-override = false;
      opacity-rule = [ 
        "100:class_g *= 'vlc'"
        "100:class_g *= 'obs'"
        "100:class_g *= 'steam'"
        "100:class_g *= 'dota'"
        "100:class_g *= 'Zathura'"
        "100:class_g *= 'libreoffice'"
        "100:class_g *= 'Virt-manager'"
        "0:_NET_WM_STATE@[0]:32a *= '_NET_WM_STATE_HIDDEN'"
        "0:_NET_WM_STATE@[1]:32a *= '_NET_WM_STATE_HIDDEN'"
        "0:_NET_WM_STATE@[2]:32a *= '_NET_WM_STATE_HIDDEN'"
        "0:_NET_WM_STATE@[3]:32a *= '_NET_WM_STATE_HIDDEN'"
        "0:_NET_WM_STATE@[4]:32a *= '_NET_WM_STATE_HIDDEN'" 
      ];

      focus-exclude = [ 
        "class_g = 'Cairo-clock'" 
      ];

      corner-radius = 0;
      rounded-corners-exclude = [ 
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "class_g = 'dmenu'"
        "class_g = 'polybar'" 
      ];

      #blur-kern = "3x3box";
      #blur = {
      #  method = "kernel";
      #  strength = 8;
      #  background = false;
      #  background-frame = false;
      #  background-fixed = false;
      #	kern = "3x3box";
      #};
      blur-background-frame = false;
      blur-background = false;
      blur-background-exclude = [ 
        "class_g = 'slop'"
        "class_g = 'i3bar'"
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "window_type = 'menu'"
        "window_type = 'dropdown_menu'"
        "window_type = 'popup_menu'"
        "window_type = 'tooltip'"
        "_GTK_FRAME_EXTENTS@:c" 
      ];

			backend = xbackend;
      #backend = "glx";
      #backend = "xrender";

      vsync = true;
      mark-wmwin-focused = true;
      mark-ovredir-focused = false;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      #detect-client-leader = true;
      use-damage = true;
      log-level = "info";

      wintypes = {
        normal = { fade = true; shadow = false; };
        tooltip = { fade = true; shadow = false; opacity = 0.75; focus = true; full-shadow = false; };
        dock = { shadow = false; clip-shadow-above = true; };
        dnd = { shadow = false; };
        popup_menu = { opacity = 0.8; shadow = false; fade = true; focus = true; };
        dropdown_menu = { opacity = 0.8; };
	      notification = { fade = true; opacity = 0.9; focus = true; shadow = true; };
        dialog = { opacity = 0.95; focus = true; fade = true; shadow = true; };
        menu = { focus = true; fade = true; shadow = false; opacity = 0.95; };
        unknown = { opacity = 0.0; };
      };
    };
  };
}
