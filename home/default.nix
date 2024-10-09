{ inputs, config, lib, pkgs, hostname, username, desktop, hmStateVersion, system, ... }: 

{
  imports = [ 
		# Modules
    ../modules/home/fastfetch.nix
    ../modules/home/nixvim.nix 
    ../modules/home/ranger.nix
		../modules/home/fzf.nix
		../modules/home/zsh.nix
    #../modules/home/lf.nix
    #../modules/home/yazi.nix

    # Secrets 
    #inputs.sops-nix.homeManagerModules.sops

    # Stylix
    #inputs.stylix.homeManagerModules.stylix
    ../stylix/stylix.nix

    # User configs
    ../users/${username}/home.nix
  ]
  ++ lib.optional (builtins.isString desktop) ../desktops/${desktop}/home.nix;

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

  # USER PROGRAMS ENABLED 
  programs = {
	  bat.enable = true;
    btop.enable = true;
		#fzf.enable = true;

    home-manager.enable = true;
  };

  # ---------------------------------

  # USER SERVICES ENABLED
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
