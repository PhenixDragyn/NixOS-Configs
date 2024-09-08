{ lib, pkgs, system, ... }:

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
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    #ADW_DISABLE_PORTAL = 1;

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

    #autoLogin.enable = true;
	  #autoLogin.user = 'ejvend';
   };

  # ---------------------------------

  # X11/XFCE SETTINGS
  services.xserver.displayManager.defaultSession = "xfce+bspwm";

  # Security Services
  security.pam.services.lightdm.enableGnomeKeyring = true;

  # DBus Setup
  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  # Call dbus-update-activation-environment on login
  services.xserver.updateDbusEnvironment = true;

  services.xserver = {
    desktopManager.xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };
    
    windowManager.bspwm.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk];
    xdgOpenUsePortal = true;
    config.common.default = "*";
  };

  # Program Setup
  programs = {
    dconf.enable = true;
    
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
  };

  # ---------------------------------

  # DEVICE MANAGEMENT SETTINGS
  # Thunar to have smb:// support
  services.gvfs.package = lib.mkForce pkgs.gnome3.gvfs;

  # Automount devices/system tray
  #services.udiskie.enable = true;

  # ---------------------------------

  # SYSTEM PACKAGES 
  environment.systemPackages = with pkgs; [
    nitrogen
    grsync
    tailscale-systray

    xfce.gigolo

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

  # XFCE PACKAGES EXCLUDES
  environment.xfce.excludePackages = with pkgs; [
    xfce.ristretto
    xfce.xfce4-appfinder
    xfce.xfce4-terminal
  ];

  # ---------------------------------

  # FONTS
  fonts.fontconfig.enable = true;
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    dejavu_fonts
    fira-code-nerdfont
    font-awesome
    jetbrains-mono
    nerdfonts
    noto-fonts
    noto-fonts-emoji
  ];
}
