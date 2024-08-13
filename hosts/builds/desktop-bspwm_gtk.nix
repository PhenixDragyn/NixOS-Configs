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

  services.autorandr = {
    enable = true;
    profiles = {
      "Laptop" = {
        fingerprint = {
          Virtual-1 = "00ffffffffffff0049143412000000002a180104a520147806ee91a3544c99260f5054210800e1c0d1c0d100a940b300950081808140ea2900c051201c304026444045cb10000018000000f7000a004082002820000000000000000000fd00327d1ea0ff010a202020202020000000fc0051454d55204d6f6e69746f720a013a02030b00467d6560591f6100000010000000000000000000000000000000000010000000000000000000000000000000000010000000000000000000000000000000000010000000000000000000000000000000000010000000000000000000000000000000000010000000000000000000000000000000000000000000002f";
        };
        config = {
          Virtual-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "1920x1200";
            #gamma = "1.0:0.909:0.833";
            rate = "59.88";
            #rotate = "left";
          };
        };
      };

      "Monitor" = {
        fingerprint = {
          Virtual-1 = "00ffffffffffff0049143412000000002a180104a520147806ee91a3544c99260f5054210800e1c0d1c0d100a940b300950081808140ea2900c051201c304026444045cb10000018000000f7000a004082002820000000000000000000fd00327d1ea0ff010a202020202020000000fc0051454d55204d6f6e69746f720a013a02030b00467d6560591f6100000010000000000000000000000000000000000010000000000000000000000000000000000010000000000000000000000000000000000010000000000000000000000000000000000010000000000000000000000000000000000010000000000000000000000000000000000000000000002f";
        };
        config = {
          Virtual-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "2048x1152";
            #gamma = "1.0:0.909:0.833";
            rate = "60.00";
            #rotate = "left";
          };
        };
      };

    };
  };

  #services.udev.packages = [pkgs.autorandr];
  #services.udev.extraRules = ''ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr -c"'';

  # Enable security services
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;
  #security.pam.services.gdm.enableGnomeKeyring = true;

  # Call dbus-update-activation-environment on login
  services.xserver.updateDbusEnvironment = true;

  # Enable BSPWM
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

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

  xdg.autostart.enable = true;

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
    QT_QPA_PLATFORMTHEME = "gnome";
  };

  environment.variables = {
    "QT_STYLE_OVERRIDE" = pkgs.lib.mkForce "adwaita-dark";
  };


  # SYSTEM PACKAGES 
  environment.systemPackages = with pkgs; [
    syncthingtray

    autorandr

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
  
    nemo-with-extensions
    
    cheese
    dconf-editor
    file-roller
    geeqie
    seahorse
    snapshot
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
