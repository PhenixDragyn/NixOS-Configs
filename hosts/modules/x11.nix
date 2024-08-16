{ pkgs, stable, unstable, buildSettings, ... }:

{
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
        #theme.name = "Zukitre-dark";
      };
      #defaultSession = "xfce+bspwm";
    };
  };

  # ---------------------------------

  # BLUETOOTH
  services.blueman.enable = true;

  # ---------------------------------

  # SYSTEM PACKAGES 
  environment.systemPackages = with pkgs; [
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
  ] ++ (if (buildSettings.platform == "x86_64-linux")
	        then [ pkgs.freeoffice pkgs.spotify ]
				else 
			  (if (buildSettings.platform == "aarch64-linux" )
			    then [] 
				else []));

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
