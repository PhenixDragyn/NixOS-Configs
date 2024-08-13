# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ pkgs, stable, unstable, userSettings, systemSettings, ... }:

{
  # You can import other NixOS modules here
  imports = [
    # Import my host modules
    ../modules/syncthing.nix
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
      lightdm.greeters.slick.enable = true;
    };
  };

  # X2GO SERVER AND XRDP
  services.x2goserver.enable = true;
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startlxqt";
  services.xrdp.openFirewall = true;

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
  };

  environment.variables = {
    "QT_STYLE_OVERRIDE" = pkgs.lib.mkForce "adwaita-dark";
  };

  # LXQT SETTINGS
  services.xserver.desktopManager.lxqt.enable = true;

  xdg.portal = {
    enable = true;
    lxqt.enable = true;
    extraPortals = [ pkgs.lxqt.xdg-desktop-portal-lxqt ];
    xdgOpenUsePortal = true;
  };

  environment.lxqt.excludePackages = [
    pkgs.lxqt.lximage-qt
    pkgs.lxqt.obconf-qt
    pkgs.lxqt.qps
    pkgs.lxqt.qterminal
    pkgs.xscreensaver
  ];

  # SYSTEM PACKAGES 
  environment.systemPackages = with pkgs; [
    syncthingtray

    x2goclient
    xautolock
    xcbutilxrm
    xclip
		xdg-utils
    xdg-user-dirs
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
    i3lock-color
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

    featherpad
    kdePackages.qt6ct
    libsForQt5.qt5ct 
    lxqt.pavucontrol-qt
    lxqt.pcmanfm-qt
    lxqt.qlipper
    nm-tray
    qimgv
  
    numix-cursor-theme
    papirus-icon-theme
    pop-icon-theme
    pop-gtk-theme
    zafiro-icons

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
