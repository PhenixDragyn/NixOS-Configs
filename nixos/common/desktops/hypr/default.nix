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

  #environment.variables = {
  #  "QT_STYLE_OVERRIDE" = pkgs.lib.mkForce "adwaita-dark";
  #};

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

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk];
    xdgOpenUsePortal = true;
    config.common.default = "*";
  };

  # ---------------------------------

  # Automount devices/system tray
  #services.udiskie.enable = true;

  # ---------------------------------

  # SYSTEM PACKAGES 
  environment.systemPackages = with pkgs; [
    # waybar
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )

    libnotify            # Notification libraries
    mako                 # Notification daemon
    swww                 # Wallpaper daemon
    kitty                # Terminal emulator
    rofi-wayland         # App Launcher
    grim                 # Screenshots
    slurp                # Screenshots
    wl-clipboard         # Clipboard
    libinput-gestures    # Gesture Control
    glib                 # Set GTK theme settings
    greetd.tuigreet      # Greeter
    swayidle             # Idle management daemon - Automatic lock screen
    swayosd              # used for on-screen notifications for things like adjusting backlight, volume, etc
    wlogout              # Logout/shutdown/hibernate/lock screen modal UI
    bitwarden-cli        # Bitwarden for rofi
    bitwarden-menu       # Bitwarden for rofi
    calcurse             # TUI Calendar app

    # Themes
    gruvbox-gtk-theme    # Gruvbox Theme
    papirus-icon-theme   # Papirus Icons

    # wayland-packages
    #inputs.nixpkgs-wayland.packages.${platform}.wayprompt  # from nixpkgs-wayland exclusively - pinentry UI


    nitrogen

    xautolock
    xcbutilxrm
    xclip
		xdg-utils
    xdg-user-dirs
    xdotool
    xorg.xbacklight

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
