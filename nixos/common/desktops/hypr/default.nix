{ lib, pkgs, pkgs-unstable, username, system, ... }:

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

  # X2GO SERVER AND XRDP
  #services.x2goserver.enable = true;
  #services.xrdp.enable = true;
  #services.xrdp.defaultWindowManager = "startxfce4";
  #services.xrdp.openFirewall = true;

  # ---------------------------------

  # INPUT SETTINGS
  services.libinput = {
    enable = true;
  #  touchpad = {
  #    naturalScrolling = true; #nc default = false
  #    disableWhileTyping = false; # default = false
  #  };
  #  mouse = {
  #    naturalScrolling = true;
  #  };
  };

  # ---------------------------------

  # SETUP ENVIRONMENT VARIABLES
  # Environment Variables
  # environment.sessionVariables = {
  #   QT_QPA_PLATFORMTHEME = "qt5ct";
  #   #ADW_DISABLE_PORTAL = 1;
  #
  #   # Mozilla Touchscreen scroll
  #   MOZ_USE_XINPUT2 = 1;
  # };

  environment.variables = {
	  WLR_RENDERER_ALLOW_SOFTWARE = 1;
		#WLR_NO_HARDWARE_CURSORS = 1;
		#NIXOS_OZONE_WL = 1;
    #"QT_STYLE_OVERRIDE" = pkgs.lib.mkForce "adwaita-dark";

		XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
		XDG_SESSION_DESKTOP = "Hyprland";

    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    #QT_QPA_PLATFORMTHEME = "qt6ct";
		QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
		QT_AUTO_SCREEN_SCALE_FACTOR = 1;

		GDK_SCALE = 1;
		GDK_BACKEND = "wayland,x11,*";
	  CLUTTER_BACKEND = "wayland";

		MOZ_ENABLE_WAYLAND =1;
    MOZ_USE_XINPUT2 = 1;
  };

  # ---------------------------------

  # X11 SETTINGS
  services.greetd = {
	  enable = true;
		settings = {
		  default_session = {
			  command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland -g 'Authorized Personnel Only'";
				user = "greeter";
			};
		};
	};

  programs.hyprland = {
	  enable = true;
		xwayland.enable = true;
    systemd.setPath.enable = true;
	};

  programs.gnupg.agent = {
	  enable = true;
		enableSSHSupport = true;
	  pinentryPackage = lib.mkForce pkgs.pinentry-gnome3;
	};

  services.logind.extraConfig = ''
    IdleActionSec=900
    IdleAction=suspend-then-hibernate
    HandleLidSwitch=suspend-then-hibernate
    HandleLidSwitchDocked=ignore
    HandleLidSwitchExternalPower=suspend
  '';

  systemd.sleep.extraConfig = ''
    AllowSuspend = yes
    AllowHibernate = yes
    AllowSuspendThenhibernate = yes
    AllowHybridSleep = yes

    HibernateDelaySec = 600
  '';

  # services.xserver = {
  #   enable = true;
  #   xkb.layout = "us";
  #   xkb.variant = "";
  #   #xkbOptions = "caps:escape";
  #   #excludePackages = with pkgs; [ xterm ];
  #   excludePackages = with pkgs; [ ];
  #
  #   # displayManager = {
  #   #   lightdm.enable = true;
  #   #   lightdm.greeters.slick = {
  #   #     enable = true;
  #   #     #theme.name = "Zukitre-dark";
  #   #   };
  #   #   defaultSession = "none+bspwm";
  #   # };
  #
  #    displayManager = {
		# 	 startx.enable = true;
		# 	
  #      autoLogin.enable = true;
	 #     autoLogin.user = "${username}";
  #
  #      defaultSession = "none+bspwm";
  #    };
  #
  #    windowManager.bspwm.enable = true;
  #  };

  # ---------------------------------

  # X11/XFCE SETTINGS
  #services.xserver.displayManager.defaultSession = "none+bspwm";

  # Security Services
  #security.pam.services.lightdm.enableGnomeKeyring = true;
	#security.pam.services.swaylock = {};

	#security.pam.services.hyprlock = {};
	#security.polkit.enable = true;

  # Security / Polkit
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


  # DBus Setup
	services.gnome.gnome-keyring.enable = true;

	# services = {
	#   dbus = {
	#     enable = true;
 #      #implementation = "broker";
	# 	  #packages = with pkgs; [ dconf gcr ];
	#   };
	#
	#   devmon.enable = true;
	#
	#   gnome = {
	#     gnome-keyring.enable = true;
	#     #sushi.enable = true;
	#   };
	# };

  # Call dbus-update-activation-environment on login
  #services.xserver.updateDbusEnvironment = true;

  xdg.autostart.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ 
		  pkgs.xdg-desktop-portal
		  pkgs.xdg-desktop-portal-gtk 
		  #pkgs.xdg-desktop-portal-xapp
		  pkgs.xdg-desktop-portal-hyprland
		];
    xdgOpenUsePortal = true;
    #config.common.default = "*";
    config.common.default = [ "hyprland" "gtk" ];
		config.common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
  };

  # ---------------------------------

  programs = {
    # dconf.profiles.user.databases = [
    #   {
    #     settings = with lib.gvariant; {
    #       "org/gnome/desktop/interface" = {
    #         clock-format = "24h";
    #         color-scheme = "prefer-dark";
    #         cursor-size = mkInt32 48;
    #         #cursor-theme = "catppuccin-mocha-blue-cursors";
    #         document-font-name = "Work Sans 12";
    #         font-name = "Work Sans 12";
    #         #gtk-theme = "catppuccin-mocha-blue-standard+default";
    #         gtk-enable-primary-paste = true;
    #         icon-theme = "Papirus-Dark";
    #         monospace-font-name = "FiraCode Nerd Font Mono Medium 13";
    #         text-scaling-factor = mkDouble 1.0;
    #       };
    #
    #       "org/gnome/desktop/sound" = {
    #         theme-name = "freedesktop";
    #       };
    #
    #       "org/gtk/gtk4/Settings/FileChooser" = {
    #         clock-format = "12h";
    #       };
    #
    #       "org/gtk/Settings/FileChooser" = {
    #         clock-format = "12h";
    #       };
    #     };
    #   }
    # ];
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };
    file-roller.enable = true;
    gnome-disks.enable = true;
    seahorse.enable = true;
    udevil.enable = true;
  };

  # ---------------------------------

  # SYSTEM PACKAGES 
  environment.systemPackages = with pkgs; [
    # waybar
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )

		# grimblast
    # slurp                # Screenshots

    glib                 # Set GTK theme settings
    # bitwarden-cli        # Bitwarden for rofi
    # bitwarden-menu       # Bitwarden for rofi
    calcurse             # TUI Calendar app
		udiskie
		pulsemixer

		cliphist

    greetd.tuigreet      # Greeter

    libnotify            # Notification libraries
    libinput-gestures    # Gesture Control

		#pyprland
		
		hyprpicker
		hyprcursor
		hyprlock
		hypridle
		hyprpaper
		#hyprutils
 
    #kanshi   # wayland autorndr

		swww
		imv 	# image viewer
		mpv   # video viewer
		#vimiv-qt

		waybar
		waypaper
		wdisplays
		wlr-randr
    wlogout              # Logout/shutdown/hibernate/lock screen modal UI
    wl-clipboard         # Clipboard

    mako                 # Notification daemon
    rofi-wayland         # App Launcher

    # swayidle             # Idle management daemon - Automatic lock screen
		# swaylock
    swayosd              # used for on-screen notifications for things like adjusting backlight, volume, etc
		swayimg

		# gum
		# figlet
		# stow
    # eww

		nwg-look     			# Theme changer
    nwg-displays			# Monitor display configuration

    # wayland-packages
    #inputs.nixpkgs-wayland.packages.${system}.wayprompt  # from nixpkgs-wayland exclusively - pinentry UI
		pkgs-unstable.wayprompt

    gnome.nautilus
		gnome.zenity
		polkit_gnome
		#themechanger

		cinnamon.nemo
		cinnamon.nemo-with-extensions
		cinnamon.nemo-emblems
		cinnamon.nemo-fileroller
		cinnamon.folder-color-switcher
		#cinnamon.pix
		#cinnamon.xviewer
		#cinnamon.xreader


    blueman

    kitty
    
    firefox
    thunderbird
    
    keepassxc
    keepass-charactercopy
    git-credential-keepassxc
  ] ++ (if (system == "x86_64-linux")
	        then [ pkgs.freeoffice pkgs.spotify ]
				else 
			  (if (system == "aarch64-linux" )
			    then [] 
				else []));

  # ---------------------------------

  # FONTS
  fonts.fontconfig.enable = true;
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    # dejavu_fonts
    # fira-code-nerdfont
    font-awesome
    #jetbrains-mono
    nerdfonts
    #noto-fonts
    #noto-fonts-emoji
  ];
}
