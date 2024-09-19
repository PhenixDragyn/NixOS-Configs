{ config, desktop, lib, pkgs, ... }: 

let
  ifExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  imports = [  ];

  # ---------------------------------
  
  # USER ACCOUNT
  users = {
    mutableUsers = false;
    #users.ejvend = {
    users.nixos = {
      isNormalUser = true;
      description = "NixOS";
			password="";

      extraGroups = [ "networkmanager" "wheel" ] 
        ++ ifExists [ "keys"      ]
        ++ ifExists [ "audio"     ]
        ++ ifExists [ "video"     ] 
        ++ ifExists [ "power"     ]
        ++ ifExists [ "storage"   ]
        ++ ifExists [ "syncthing" ];
      shell = pkgs.zsh;

      packages = [ pkgs.home-manager ];

      #openssh.authorizedKeys.keyFiles = [ ../../../keys/ssh/keys.txt ];
    };
  };

  # Used in home-manager's atuin config
  # Used here instead of  home-manager because HM randomly needs to restart sops-nix and I can't 
  # find a way to do so
  # sops.secrets."atuin_key" = {
  #   sopsFile = ../../../secrets/users/ejvend.yaml;
  #   owner = "ejvend";
  # };
  #
  # sops.secrets."email_password" = {
  #   sopsFile = ../../../secrets/users/ejvend.yaml;
  #   owner = "ejvend"; 
  # };

  # ---------------------------------

  # USER ENVIRONMENT PACKAGES 
  environment.systemPackages = with pkgs; [];

  # ---------------------------------

  # USER SYMLINKS
  #system.userActivationScripts.linktosharedfolder.text = ''
  #  if [[ ! -h "${config.home.homeDirectory}/Sync/test.txt" ]]; then
  #    ln -s "${config.home.homeDirectory}/Sync/test.txt" "${config.home.homeDirectory}/.config/"
  #  fi
  #'';

  # ---------------------------------

  # USER NIX SETTINGS
  # Make this user trusted
  nix.settings.trusted-users = [ "nixos" ];
}
