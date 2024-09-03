# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ config, lib, pkgs, stable, unstable, buildSettings, ... }:

{
  # You can import other NixOS modules here
  imports = [
    # Import my host modules
    ../modules/x11.nix
  ];

  # ---------------------------------
  
  # NETWORKING
  # Enable network manager applet
  programs.nm-applet.enable = false;

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

  # LXQT PACKAGES EXCLUDES
  environment.lxqt.excludePackages = [
    pkgs.lxqt.lximage-qt
    pkgs.lxqt.obconf-qt
    pkgs.lxqt.qps
    pkgs.lxqt.qterminal
    pkgs.xscreensaver
  ];

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
  ] ++ (if (buildSettings.platform == "x86_64-linux")
	        then []
				else 
			  (if (buildSettings.platform == "aarch64-linux" )
			    then [] 
				else []));

}
