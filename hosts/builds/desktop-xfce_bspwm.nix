# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ pkgs, stable, unstable, userSettings, systemSettings, ... }:

{
  # You can import other NixOS modules here
  imports = [
    # Import my host modules
    #../modules/syncthing.nix
  ];

  # Enable network manager applet
  programs.nm-applet.enable = false;

  # X11 SETTINGS
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    #xkbOptions = "caps:escape";
    excludePackages = with pkgs; [ xterm ];

    displayManager = {
      lightdm.enable = true;
      lightdm.greeters.slick = {
        enable = true;
        theme.name = "Zukitre-dark";
      };
      defaultSession = "xfce+bspwm";
    };
  };

  # SECURITY SERVICES
  security.pam.services.lightdm.enableGnomeKeyring = true;

  # Call dbus-update-activation-environment on login
  services.xserver.updateDbusEnvironment = true;

  # DBUS (GNOME)
  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  # X2GO SERVER AND XRDP
  #services.x2goserver.enable = true;
  #services.xrdp.enable = true;
  #services.xrdp.defaultWindowManager = "startlxqt";
  #services.xrdp.openFirewall = true;

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

  # Environment Variables
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    #ADW_DISABLE_PORTAL = 1;
  };

  #environment.variables = {
  #  "QT_STYLE_OVERRIDE" = pkgs.lib.mkForce "adwaita-dark";
  #};

  # XFCE SETTINGS
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.xfce.noDesktop = true;
  services.xserver.desktopManager.xfce.enableXfwm = false;
  services.xserver.windowManager.bspwm.enable = true;

  programs = {
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
  };

  # Is this needed??
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk];
    xdgOpenUsePortal = true;
    config.common.default = "*";
  };

  environment.xfce.excludePackages = with pkgs; [
    xfce.ristretto
    xfce.xfce4-appfinder
    xfce.xfce4-terminal
  ];

  # SYSTEM PACKAGES 
  environment.systemPackages = with pkgs; [
    syncthingtray

    #x2goclient
    xautolock
    xcbutilxrm
    xclip
		xdg-utils
    xdg-user-dirs
    xdg-desktop-portal-gtk
    xdotool
    xorg.xbacklight
    wget
    zsh-completions
    zsh-history-substring-search
    zsh-syntax-highlighting
    #zsh-powerlevel10k
    #zsh-vi-mode

    bat
    bspwm
    btop
    dunst
    feh
    firefox
    fzf
    hsetroot
    #i3lock-color
    keepassxc
    kitty
    libnotify
    lsd
    neofetch
    picom-pijulius
    polybar
    psmisc
    rofi
    sxhkd
    st
    termite
    thunderbird

    nitrogen

    numix-cursor-theme
    papirus-icon-theme
    pop-icon-theme
    pop-gtk-theme
    zafiro-icons
    zuki-themes

    (python3Full.withPackages(ps: with ps; [ requests ]))
  ] ++ (if (systemSettings.system == "x86_64-linux")
	        then [ pkgs.freeoffice pkgs.spotify ]
				else 
			  (if (systemSettings.system == "aarch64-linux" )
			    then [] 
				else []));

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
