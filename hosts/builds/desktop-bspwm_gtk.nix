{ pkgs, stable, unstable, userSettings, systemSettings, ... }:

{
  # You can import other NixOS modules here
  imports = [
    # Import my host modules
  ];

  # Enable network manager applet
  programs.nm-applet.enable = true;

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
    #displayManager.gdm.enable = true;
    #displayManager.sddm.enable = true;
  };

  # Enable security services
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;
  #security.pam.services.gdm.enableGnomeKeyring = true;

  # Call dbus-update-activation-environment on login
  services.xserver.updateDbusEnvironment = true;

  # Enable BSPWM
  services.xserver.windowManager.bspwm.enable = true;

  #xdg.portal.config.common.default = "*"
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [
          "gtk"
        ];
      };
    };
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
  #    pkgs.xdg-desktop-portal-gtk
    ];
    xdgOpenUsePortal = true;
  };

  # DBUS (GNOME)
  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  # DCONF
  programs.dconf.enable = true;
  
  # INPUT SETTINGS
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true; # default = false
      disableWhileTyping = false; # default = false
    };
    mouse = {
      naturalScrolling = true;
    };
  };

  # X2GO SERVER AND XRDP
  #services.x2goserver.enable = true;
  #services.xrdp.enable = true;
  #services.xrdp.defaultWindowManager = "startlxqt";
  #services.xrdp.openFirewall = true;

  # Environment Variables
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  environment.variables = {
    "QT_STYLE_OVERRIDE" = pkgs.lib.mkForce "adwaita-dark";
  };


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

    bat
    bspwm
    btop
    dunst
    feh
    firefox
    fzf
    hsetroot
    i3lock-color
    #keepassxc
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
  
    nemo-with-extensions
    geeqie
    #gnome-monitor-config
    dconf-editor
    file-roller
    #gnome.nautilus
    seahorse
    #gnome-secrets

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
