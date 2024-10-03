{ lib, pkgs, system, ... }:

{
  # You can import other NixOS modules here
  imports = [
    # Import my host modules
    #../../modules/x11.nix
    ../../modules/nixos/autorandr.nix
  ];

  # ---------------------------------
  
  # NETWORKING
  # Enable network manager applet
  programs.nm-applet.enable = false;

  # ---------------------------------

  # BLUETOOTH
  services.blueman.enable = true;

  # ---------------------------------

  # X2GO SERVER AND XRDP
  services.x2goserver.enable = true;
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startlxqt";
  services.xrdp.openFirewall = true;

  # ---------------------------------

  # INPUT SETTINGS
  services.libinput = {
    enable = true;
  #  touchpad = {
  #    naturalScrolling = true; # default = false
  #    disableWhileTyping = false; # default = false
  #  };
  #  mouse = {
  #    naturalScrolling = true;
  #  };
  };
  
  # ---------------------------------

  # SETUP ENVIRONMENT VARIABLES
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";

    # Mozilla Touchscreen scroll
    MOZ_USE_XINPUT2 = 1;
  };

  #environment.variables = {
  #  "QT_STYLE_OVERRIDE" = pkgs.lib.mkForce "adwaita-dark";
  #};

  # ---------------------------------

  # X11 SETTINGS
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    #xkbOptions = "caps:escape";
    #excludePackages = with pkgs; [ xterm ];
    excludePackages = with pkgs; [ ];

    displayManager = {
      lightdm.enable = true;
      lightdm.greeters.slick = {
        enable = true;
        #theme.name = "Zukitre-dark";
      };
      #defaultSession = "xfce+bspwm";
    };

   #  displayManager = {
			# startx.enable = true;
			#
   #    autoLogin.enable = true;
	  #   autoLogin.user = "nixos";
   #  };
  };

  # ---------------------------------

  # X11/LXQT SETTINGS
  #services.xserver.displayManager.defaultSession = "lxqt+bspwm";
  services.xserver.desktopManager.lxqt.enable = true;

  xdg.portal = {
    enable = true;
    lxqt.enable = true;
    extraPortals = [ pkgs.lxqt.xdg-desktop-portal-lxqt ];
    xdgOpenUsePortal = true;
  };

  # ---------------------------------

  # SYSTEM PACKAGES 
  environment.systemPackages = with pkgs; [
    # Personal Package
    #qrsync

    # Develop 
    #jetbrains.pycharm-community

    # LXQT Packages
    featherpad
    kdePackages.qt6ct
    libsForQt5.qt5ct 
    lxqt.pavucontrol-qt
    lxqt.pcmanfm-qt
    lxqt.qlipper
    mpv
    nm-tray
    qimgv

    x2goclient
    xautolock
    xcbutilxrm
    xclip
		xdg-utils
    xdg-user-dirs
    xdotool
    xorg.xbacklight

    arandr
    autorandr
    blueman

    bspwm
    dunst
    feh
    hsetroot
    i3lock-color
    libnotify
    picom-pijulius
    polybar
    rofi
    sxhkd

    kitty
    st
    termite
    
    firefox
    thunderbird

    keepassxc
    keepass-charactercopy
    git-credential-keepassxc

    numix-cursor-theme
    papirus-icon-theme
    pop-icon-theme
    pop-gtk-theme
    zafiro-icons

    # Development
    (python3Full.withPackages(ps: with ps; [ requests ]))
  ] ++ (if (system == "x86_64-linux")
	        then [ pkgs.freeoffice pkgs.spotify ]
				else 
			  (if (system == "aarch64-linux" )
			    then [] 
				else []));

  # ---------------------------------

  # LXQT PACKAGES EXCLUDES
  environment.lxqt.excludePackages = [
    pkgs.lxqt.lximage-qt
    pkgs.lxqt.obconf-qt
    pkgs.lxqt.qps
    pkgs.lxqt.qterminal
    pkgs.xscreensaver
  ];

  # ---------------------------------

  # FONTS
  fonts.fontconfig.enable = true;
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    #dejavu_fonts
    fira-code-nerdfont
    font-awesome
    jetbrains-mono
    nerdfonts
    noto-fonts
    noto-fonts-emoji
  ];
}
