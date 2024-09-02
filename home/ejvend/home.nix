{ inputs, outputs, lib, config, pkgs, stable, unstable, buildSettings, stateVersion, ... }:

{
  imports = [
    # Modules

    # Inputs
    inputs.nixvim.homeManagerModules.nixvim
    inputs.stylix.homeManagerModules.stylix
    inputs.nix-colors.homeManagerModules.default
    
    # Load desktop flake
    ../builds/desktop-${buildSettings.build}.nix
  ];
  # ] ++ (if (buildSettings.build == "xfce_bspwm")
	 #        then [ ../builds/desktop-xfce_bspwm.nix ]
		# 		else 
		# 	  (if (buildSettings.build == "lxqt_bspwm" )
		# 	    then [ ../builds/desktop-lxqt_bspwm.nix ] 
		# 		else 
		# 	  (if (buildSettings.build == "bspwm_gtk" )
		# 	    then [ ../builds/desktop-bspwm_gtk.nix ] 
		# 		else [])));
   
  # ---------------------------------

  # Nixpkgs configuration
  nixpkgs.config.allowUnfree = true;

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
  };

  # ---------------------------------

  # USER SETTINGS
  home = {
    username = buildSettings.username;
    homeDirectory = "/home/" + buildSettings.username;

    # User specific packages
    packages = with pkgs; [
      #hello
      #unstable.hello
      #hyprpaper
    ];
  };

  # ---------------------------------

  # USER PROGRAMS
  programs = {
    btop.enable = true;
    home-manager.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "PhenixDragyn";
    userEmail = "ejvend.nielsen@gmail.com";
    #extraConfig = {
    #  credential = {
    #    helper = "keepassxc --git-groups";
    #  };
    #};
    #ignores = [
    # "*.example"
    #];
  };

  programs.feh = {
    enable = true;
    keybindings = {
      menu_parent = [ "h" "Left" ];
      menu_child = [ "l" "Right" ];
      menu_down = [ "j" "Down" ];
      menu_up = [ "k" "Up" ];
      menu_select = [ "space" "Return" ];
      next_img = [ "j" "Right" "space" ];
      prev_img = [ "k" "Left" "BackSpace" ];
      scroll_up = [ "J" "C-Up" ];
      scroll_down = [ "K" "C-Down" ];
      scroll_left = [ "H" "C-Left" ];
      scroll_right = [ "L" "C-Right" ];
    };
  };

  programs.zsh = {
    enable = true;
    #dotDir = ".config/zsh";
    shellAliases = {
      nr="sudo nixos-rebuild switch --flake";
      hm="home-manager switch --flake";
      nb="nix-build --no-out-link"; 
      nu="nix flake update";
      nr-pkgs="nix-store --query --requisites /run/current-system | cut -d- -f2 | sort | uniq | fzf ";
     
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

      diff="diff --color=auto";
      grep="grep --color=auto";
    };

    initExtra = ''
      set -o vi
   
      # Ranger
      export RANGER_DEVICONS_SEPARATOR="  "
    '';
    
    envExtra = ''
      path=(~/.local/bin ~/.local/lib $path[@])
    '';

    #profileExtra = ''
    #'';

    history = {
      ignoreDups = true;
      ignoreSpace = true;
      save = 100000;
      share = true;
      size = 100000;
    };
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

  #if buildSettings.build == "lxqt_bspwm" then
  #  "Test";

  # ---------------------------------

  # SYMLINKS
  home.file = {
    ".fehbg-stylix".text = ''
      #!/bin/sh
      feh --no-fehbg --bg-fill ''+config.stylix.image+'';
    '';
  
    ".fehbg-stylix".executable = true;
  };

  # home.file = if buildSettings.build == "lxqt_bspwm" then {
  #   ".fehbg-stylix".text = ''
  #     #!/bin/sh
  #     feh --no-fehbg --bg-fill ''+config.stylix.image+'';
  #   '';
  #
  #   ".fehbg-stylix".executable = true;
  #
  #   "config/featherpad".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/featherpad";
  # } else {};
  
  # ---------------------------------

  # STYLIX
  stylix = {
    enable = true;
    autoEnable = true;
    
    base16Scheme = ./. + "/../../themes"+("/"+buildSettings.theme)+".yaml";
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
  home.stateVersion = stateVersion;
}
