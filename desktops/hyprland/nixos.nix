{ config, lib, pkgs, pkgs-unstable, username, hostname, system, ... }:

{ 
# You can import other NixOS modules here 
  imports = [
    # Import my host modules
    #../../modules/x11.nix
  ];
# ---------------------------------

  # NETWORKING
  # Enable network manager applet
  programs.nm-applet.enable = true;

  # ---------------------------------

  # BLUETOOTH
  services.blueman.enable = true;

  # ---------------------------------

  # INPUT SETTINGS
  services.libinput = {
    enable = true;
  #   touchpad = {
  #     naturalScrolling = true; #nc default = false
  #     disableWhileTyping = false; # default = false
  #   };
  #   mouse = {
  #     naturalScrolling = true;
  #   };
  };

  # ---------------------------------

  # SETUP ENVIRONMENT VARIABLES 
	environment.variables = {
	  WLR_RENDERER_ALLOW_SOFTWARE = 1;
		#WLR_NO_HARDWARE_CURSORS = 1;
		
    #GTK_THEME = "adw-gtk3";
    #HYPRCURSOR_SIZE = 24;
    #HYPRCURSOR_THEME = ${config.stylix.cursor.name}"_OVERRIDE" = pkgs.lib.mkForce "adwaita-dark";

		XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
		XDG_SESSION_DESKTOP = "Hyprland";

		#QT_STYLE_OVERRIDE = "qt6ct";
    #QT_QPA_PLATFORMTHEME = "qt5ct";
		#QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    QT_QPA_PLATFORM = "wayland;xcb";
		QT_AUTO_SCREEN_SCALE_FACTOR = 1;

		GDK_SCALE = 1;
		GDK_BACKEND = "wayland,x11,*"; CLUTTER_BACKEND = "wayland"; MOZ_ENABLE_WAYLAND =1; MOZ_USE_XINPUT2 = 1;
    #SWWW_TRANSITION_STEP,60;
    #SWWW_TRANSITION,simple;

		USE_GTK_PORTAL = 0;

		HOSTNAME = "${hostname}";
  };

  # ---------------------------------

  # LOGIN SETTINGS
  # services.greetd = {
	#   enable = true;
	# 	settings = {
	# 		default_session = let
	# 		  tuigreet = "${lib.getExe pkgs.greetd.tuigreet}";
	# 			
	# 			tuigreetOptions = [
  #        "--asterisks"
	# 			 "--remember"
	# 		   # "--remember-session"
	# 			 # "--sessions ${waylandSessions}:${xSessions}";
	# 			 "--time"
	# 			 "--theme 'border=lightblue;prompt=green;time=orange;button=yellow;container=black'"
	# 			 "--cmd Hyprland"
	# 			 "-g 'Authorized Personnel Only'"
	# 		  ];
  #        
	# 			flags = lib.concatStringsSep " " tuigreetOptions;
	# 	  in {
	# 		  command = "${tuigreet} ${flags}";
	# 		  user = "greeter";
	#     };
	# 	};
	# };

  services.greetd = {
	  enable = true;
		settings = {
			default_session = let
			  regreet = "${lib.getExe pkgs.greetd.regreet}";
		  in {
				command = ("${pkgs.hyprland}/bin/Hyprland --config " + ./hyprland-regreet.conf);
        #command = "${pkgs.dbus}/bin/dbus-run-session cage -s -- regreet";
			  #command = "cage -s -- regreet";
			  user = "greeter";
	    };
		};
	};

	programs.regreet = {
   enable = true;
	 settings = {
		 # Stylix not new enough to apply automatically
	   GTK = lib.mkForce {
	 	  application_prefer_dark_theme = true;
	 		font_name = "DejaVu Sans 12";
	 		cursor_theme_name = "${pkgs.volantes-cursors}";
	 		icon_theme_name = "Adwaita";
	 		theme_name = "Adwaita";
	 	 };
      
	   background = lib.mkForce {
	 	  #path = "${config.stylix.image}";
      path = ../../files/wallpaper/NixOS-Nineish-Dark.png;
	 		fit = "Fill";
	 	 };

   	 commands = {
	 		 reboot = [ "systemctl" "reboot" ];
	 		 poweroff = [ "systemctl" "poweroff" ];
	 	 };
	 };
	};
	

  services.logind.extraConfig = ''
    IdleActionSec=900
    IdleAction=suspend-then-hibernate
    HandleLidSwitch=suspend-then-hibernate
    HandleLidSwitchDocked=ignore
    HandleLidSwitchExternalPower=suspend
  '';

  # ---------------------------------

  # SYSTEM SLEEP SETTINGS
  systemd.sleep.extraConfig = ''
    AllowSuspend = yes
    AllowHibernate = yes
    AllowSuspendThenhibernate = yes
    AllowHybridSleep = yes

    HibernateDelaySec = 600
  '';

  # ---------------------------------

  # SECURITY
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';

  security.pam.services.hyprlock = {
    text = ''
      auth include login
    '';
  };

  # Gnome-Keyring Setup
	services.gnome.gnome-keyring.enable = true;
	security.pam.services.greetd.enableGnomeKeyring = true;

  # GPG agent
  programs.gnupg.agent = {
	  enable = true;
		enableSSHSupport = true;
	  pinentryPackage = lib.mkForce pkgs.pinentry-gnome3;
	};

  # ---------------------------------

  # DBus Setup
  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  # Call dbus-update-activation-environment on login
  services.xserver.updateDbusEnvironment = true;

  # ---------------------------------
 
  # XDG SETTINGS
  #xdg.autostart.enable = true;

  xdg.portal = {
    enable = true;
		wlr.enable = true;

    extraPortals = [ 
		  #pkgs.xdg-desktop-portal
		  pkgs.xdg-desktop-portal-gtk 
		  #pkgs.xdg-desktop-portal-gnome 
		  #pkgs.xdg-desktop-portal-wlr
		  pkgs.xdg-desktop-portal-hyprland
		];

    xdgOpenUsePortal = true;
    #config.common.default = "*";
    config.common.default = [ "hyprland" "gtk" ];
		config.common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
  };

  # ---------------------------------

  # HYPERLAND SETTINGS
  programs.hyprland = {
	  enable = true;
		xwayland.enable = true;
    systemd.setPath.enable = true;
	};

  # ---------------------------------

  # PROGRAM SETTINGS
  programs = {
		dconf.enable = true;
    dconf.profiles.user.databases = [
      {
        settings = with lib.gvariant; {
				  "org/nemo/plugins" = {
				 	  disabled-actions = [ 
				 		  "set-as-background.nemo_action" 
				 			"change-background.nemo_action" 
				 		];
				 	};
   
          "org/nemo/preferences" = {
				 	  #thumbnail-limit = lib.gvariant.mkUint64 [1073741824];
				 	  thumbnail-limit = mkUint64 [1073741824];
				 	};
   
				 	"org/nemo/window-state" = {
				 	  maximized = true;
				 		sidebar-bookmark-breakpoint = "0";
						start-with-sidebar = true;
					};

					"org/gnome/TextEditor" = {
					  keybindings = "vim";
						style-scheme = "builder-dark";
					};
        };
      }
    ];

    nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };

    file-roller.enable = true;
    seahorse.enable = true;
    udevil.enable = true;
    gnome-disks.enable = true;
    
    # thunar = {
    #   enable = true;
    #   plugins = with pkgs.xfce; [
    #     thunar-archive-plugin
    #     thunar-media-tags-plugin
    #     thunar-volman
    #   ];
    # };
  };
 
  # A quick previewer for Files (nautilus) file manager.
	services.gnome.sushi.enable = true;

  # ---------------------------------

  # SYSTEM PACKAGES 
  environment.systemPackages = with pkgs; [
    #wonderdraft 

    # waybar
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )

    #kdePackages.qt6ct
    #libsForQt5.qt5ct 
    adwaita-qt

		grimblast     # Screenshots
    # slurp                # Screenshots

    glib                 # Set GTK theme settings
    #calcurse             # TUI Calendar app
		udiskie            # Automaounter
		pulsemixer

		cliphist

		cage
    greetd.regreet       # Greeter
    #greetd.gtkgreet      # Greeter
    #greetd.tuigreet      # Greeter

		brightnessctl
    #mako                 # Notification daemon
    dunst                # Notification daemon
    libnotify            # Notification libraries
    libinput-gestures    # Gesture Control

		#pyprland
		
		hyprpicker
		hyprcursor
		hyprlock
		hypridle
		hyprpaper
		#hyprutils
		#hyprlandPlugins.hyprexpo
		#hyprland-monitor-attached
 
		#swww
		imv 	# image viewer
		mpv   # video viewer

		kanshi   # Dynamic display configuration for wayland (equivalent to autorandr)
		waybar
		pkgs-unstable.waypaper
		wdisplays
		#wf-recorder
		#wlr-randr
    wlogout              # Logout/shutdown/hibernate/lock screen modal UI
    wl-clipboard         # Clipboard
    rofi-wayland         # App Launcher
    #kanshi   # wayland autorndr
	  wl-clip-persist	

    # swayidle             # Idle management daemon - Automatic lock screen
		# swaylock
    swayosd              # used for on-screen notifications for things like adjusting backlight, volume, etc
		swayimg

		nwg-look     			# Theme changer
    nwg-displays			# Monitor display configuration

    # wayland-packages
		pkgs-unstable.wayprompt

    celluloid        # GTK+ frontend to mpv
		evince            # pdf document viewer
		guvcview          # Camera viewer
		#gnome.cheese
    snapshot           # Screenshots
    # v4l2-relayd
		# gst_all_1.gst-plugins-base
		# gst_all_1.gst-plugins-good
		# gst_all_1.gst-plugins-ugly

		#gnome.eog
    nautilus
		zenity
		gnome-text-editor
		#gedit
		gimp-with-plugins
		polkit_gnome
		evince

    pkgs-unstable.nemo-with-extensions

		#themechanger
		# shared-mime-info
		# gdk-pixbuf
		# librsvg
		webp-pixbuf-loader
		# libavif

		#qimgv
		#pcmanfm-qt

		#calcure
		
    #blueman

    kitty

    firefox
    thunderbird
		libreoffice
    
		_1password-gui
    keepassxc
    keepass-charactercopy
    git-credential-keepassxc
  ] ++ (if (system == "x86_64-linux")
	        then [ pkgs.freeoffice pkgs-unstable.spotify ]
	        #then [ pkgs.freeoffice ]
				else 
			  (if (system == "aarch64-linux" )
			    then [] 
				else []));

  # ---------------------------------

  # FONTS
  # fonts.fontconfig.enable = true;
  # fonts.fontDir.enable = true;
  # fonts.packages = with pkgs; [
  #   # dejavu_fonts
  #   # fira-code-nerdfont
  #   font-awesome
  #   #jetbrains-mono
  #   nerdfonts
  #   #noto-fonts
  #   #noto-fonts-emoji
  # ];
}
