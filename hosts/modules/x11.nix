{ pkgs, stable, unstable, ... }:

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
    #wget
    #zsh-completions
    #zsh-history-substring-search
    #zsh-syntax-highlighting
    #zsh-powerlevel10k
    #zsh-vi-mode

    bat
    bspwm
    btop
    dunst
    feh
    firefox
    fzf
    git-credential-keepassxc
    hsetroot
    i3lock-color
    keepassxc
    keepass-charactercopy
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
