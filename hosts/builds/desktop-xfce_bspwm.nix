# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ config, lib, pkgs, stable, unstable, buildSettings, ... }:

{
  # You can import other NixOS modules here
  imports = [
    # Import my host modules
    #../modules/syncthing.nix
    ../modules/x11.nix
  ];

  # ---------------------------------

  # NETWORKING
  # Enable network manager applet
  programs.nm-applet.enable = true;


  # ---------------------------------

  # DEVICE MANAGEMENT SETTINGS
  # Thunar to have smb:// support
  services.gvfs.package = lib.mkForce pkgs.gnome3.gvfs;

  # Automount devices/system tray
  services.udiskie.enable = true;

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
  };

  #environment.variables = {
  #  "QT_STYLE_OVERRIDE" = pkgs.lib.mkForce "adwaita-dark";
  #};

  # ---------------------------------

  # XFCE PACKAGES EXCLUDES
  environment.xfce.excludePackages = with pkgs; [
    xfce.ristretto
    xfce.xfce4-appfinder
    xfce.xfce4-terminal
  ];

  # ---------------------------------

  # SYSTEM PACKAGES 
  environment.systemPackages = with pkgs; [

    nitrogen
    grsync
    tailscale-systray

    xfce.gigolo

  ] ++ (if (buildSettings.platform == "x86_64-linux")
	        then []
				else 
			  (if (buildSettings.platform == "aarch64-linux" )
			    then [] 
				else []));
}
