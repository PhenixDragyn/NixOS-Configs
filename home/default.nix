{ inputs, config, lib, pkgs, hostname, username, desktop, hmStateVersion, system, ... }: 

{
  imports = [ 
    # Common configs
    #./common/software/cli

    # Software
    #../packages/qrsync/qrsync.nix

    # NixVIM
    #inputs.nixvim.homeManagerModules.nixvim

    # Secrets 
    #inputs.sops-nix.homeManagerModules.sops

    # Stylix
    inputs.stylix.homeManagerModules.stylix
    ../stylix/stylix.nix

    # User configs
    ../users/${username}/home.nix
  ]
  ++ lib.optional (builtins.isString desktop) ./common/desktops/${desktop}; 

  # ---------------------------------

  # USER SETTINGS
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    sessionPath = [ "$HOME/.local/bin" ];
  
	  sessionVariables = {
		  EDITOR = "nvim";
		};

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
			lf="lf";
			yz="yazi";
			fm="yazi";

      diff="diff --color=auto";
      grep="grep --color=auto";

      fastfetch="fastfetch --config ~/.config/fastfetch/fastfetch.jsonc";
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
  # home.file = {
  #   ".fehbg-stylix".text = ''
  #     #!/bin/sh
  #     feh --no-fehbg --bg-fill ''+config.stylix.image+'';
  #   '';
  # 
  #   ".fehbg-stylix".executable = true;
  # };

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

  # Silent news
  news.display = "silent";

  #Reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = hmStateVersion;
}
