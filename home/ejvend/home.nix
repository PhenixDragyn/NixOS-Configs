{ inputs, outputs, lib, config, pkgs, stable, unstable, userSettings, systemSettings, ...}: 

{
  imports = [
    # Modules

    # Inputs
    inputs.nixvim.homeManagerModules.nixvim
    inputs.stylix.homeManagerModules.stylix
    #inputs.spicetify-nix.homeManagerModules.spicetify-nix

  ] ++ (if (systemSettings.build == "xfce_bspwm")
	        then [ ../builds/desktop-xfce_bspwm.nix ]
				else 
			  (if (systemSettings.build == "lxqt_bspwm" )
			    then [ ../builds/desktop-lxqt_bspwm.nix ] 
				else 
			  (if (systemSettings.build == "bspwm_gtk" )
			    then [ ../builds/desktop-bspwm_gtk.nix ] 
				else [])));
   
  # ---------------------------------

  # Nixpkgs configuration
  nixpkgs.config.allowUnfree = true;

  # ---------------------------------

  # USER SETTINGS
  home = {
    username = userSettings.username;
    homeDirectory = "/home/" + userSettings.username;

    # User specific packages
    packages = with pkgs; [
      #hello
      #unstable.hello
    ];
  };

  # ---------------------------------

  # USER PROGRAMS
  programs = {
    btop.enable = true;
    feh.enable = true;
    firefox.enable = true;
    home-manager.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "PhenixDragyn";
    userEmail = "ejvend.nielsen@gmail.com";
    extraConfig = {
      credential = {
        helper = "keepassxc --git-groups";
      };
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      nr="sudo nixos-rebuild switch --flake";
      hm="home-manager switch --flake";
      nb="nix-build --no-out-link";
      nr-pkgs="nix-store --query --requisites /run/current-system | cut -d- -f2 | sort | uniq";
     
      q="exit";
      ls="lsd -F";
      la="lsd -F -a";
      ll="lsd -F -l";
      lla="lsd -F -la";

      rm="rm -v";

      open="xdg-open";

      gs="git status";
      ga="git add -A";
      gc="git commit -m";
      gpull="git pull origin";
      gpush="git push -u origin";
      gd="git diff * | bat";
      gl="git log --stat --graph --decorate --oneline";

      rr="ranger";
      vv="vimiv";
      lf="lfub";

      diff="diff --color=auto";
      grep="grep --color=auto";
    };
    initExtra = ''
set -o vi

# Ranger
export RANGER_DEVICONS_SEPARATOR="  "
    '';
  };

  # ---------------------------------

  # USER SERVICES
  services = {
    unclutter.enable = true;
  };

  # ---------------------------------

  # SETUP HOME DIRECTORY
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      #music = "${config.home.homeDirectory}/Media/Music";
      #pictures = "${config.home.homeDirectory}/Media/Pictures";
      #videos = "${config.home.homeDirectory}/Media/Videos";
      music = null;
      pictures = null;
      videos = null;
      desktop = null;
      templates= null;
      publicShare = null;
      extraConfig = {
        #XDG_ARCHIVE_DIR= "${config.home.homeDirectory}/Archive";
        #XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
        XDG_NIXOS_DIR = "${config.home.homeDirectory}/NixOS";
        XDG_PROJECTS_DIR= "${config.home.homeDirectory}/Projects";
        #XDG_WALLPAPERS_DIR = "${config.home.homeDirectory}/Wallpapers";
      };
    };

    #mime.enable = true;
    #mimeApps.enable = true;
    #mimeApps.association.added = {
      #"application/octet-stream" = "flstudio.desktop;";
    #};
  };

  # ---------------------------------

  # STYLIX
  stylix = {
    enable = true;
    autoEnable = true;
    
    base16Scheme = ./. + "/../../themes"+("/"+userSettings.theme)+".yaml";
    image = ../../files/wallpaper/NixOS-Nineish-Dark.png;

    # Remove rounded corners in Gnome
    targets.gtk = {
      extraCss = ''
        window.background { border-radius: 0; }
      '';
    };
  };

  # ---------------------------------

  # Silent news
  news.display = "silent";

  #Reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
