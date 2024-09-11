{ lib, pkgs, username, system, ... }:

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

  #programs.gnupg.agent.pinentryPackage = lib.mkForce pkgs.pinentry-gnome3;

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
	security.pam.services.hyprlock = {};
	security.polkit.enable = true;

  # DBus Setup
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
		  pkgs.xdg-desktop-portal-hyprland
		];
    xdgOpenUsePortal = true;
    #config.common.default = "*";
    config.common.default = [ "hyprland" "gtk" ];
		config.common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
  };

  # ---------------------------------

  programs = {
    dconf.profiles.user.databases = [
      {
        settings = with lib.gvariant; {
          "org/gnome/desktop/interface" = {
            clock-format = "24h";
            color-scheme = "prefer-dark";
            cursor-size = mkInt32 48;
            cursor-theme = "catppuccin-mocha-blue-cursors";
            document-font-name = "Work Sans 12";
            font-name = "Work Sans 12";
            gtk-theme = "catppuccin-mocha-blue-standard+default";
            gtk-enable-primary-paste = true;
            icon-theme = "Papirus-Dark";
            monospace-font-name = "FiraCode Nerd Font Mono Medium 13";
            text-scaling-factor = mkDouble 1.0;
          };

          "org/gnome/desktop/sound" = {
            theme-name = "freedesktop";
          };

          "org/gtk/gtk4/Settings/FileChooser" = {
            clock-format = "24h";
          };

          "org/gtk/Settings/FileChooser" = {
            clock-format = "24h";
          };
        };
      }
    ];
    file-roller.enable = true;
    gnome-disks.enable = true;
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };
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

    grim                 # Screenshots
    slurp                # Screenshots
    glib                 # Set GTK theme settings
    bitwarden-cli        # Bitwarden for rofi
    bitwarden-menu       # Bitwarden for rofi
    calcurse             # TUI Calendar app

    greetd.tuigreet      # Greeter

    libnotify            # Notification libraries
    libinput-gestures    # Gesture Control

		pyprland
		
		hyprpicker
		hyprcursor
		hyprlock
		hypridle
		hyprpaper

		waybar
		wdisplays
		wlr-randr
    wlogout              # Logout/shutdown/hibernate/lock screen modal UI
    wl-clipboard         # Clipboard

    mako                 # Notification daemon
    rofi-wayland         # App Launcher

    swayidle             # Idle management daemon - Automatic lock screen
		swaylock
    swayosd              # used for on-screen notifications for things like adjusting backlight, volume, etc

    # Themes
    #gruvbox-gtk-theme    # Gruvbox Theme
    papirus-icon-theme   # Papirus Icons

    # wayland-packages
    #inputs.nixpkgs-wayland.packages.${platform}.wayprompt  # from nixpkgs-wayland exclusively - pinentry UI

    gnome.nautilus
		gnome.zenity
		polkit_gnome

    #imv
    #nitrogen

    #xautolock
    #xcbutilxrm
    #xclip
		#xdg-utils
    #xdg-user-dirs
    #xdotool
    #xorg.xbacklight

    #arandr
    #autorandr
    blueman

    kitty
    
    firefox
    # thunderbird
    
    # keepassxc
    # keepass-charactercopy
    # git-credential-keepassxc
    
    # numix-cursor-theme
    # papirus-icon-theme
    # pop-icon-theme
    # pop-gtk-theme
    zafiro-icons

    # Development
    #(python3Full.withPackages(ps: with ps; [ requests ]))
  ] ++ (if (system == "x86_64-linux")
	        then []
	        #then [ pkgs.freeoffice pkgs.spotify ]
				else 
			  (if (system == "aarch64-linux" )
			    then [] 
				else []));

  # ---------------------------------

  # XFCE PACKAGES EXCLUDES
  # environment.xfce.excludePackages = with pkgs; [
  #   xfce.ristretto
  #   xfce.xfce4-appfinder
  #   xfce.xfce4-terminal
  # ];

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
