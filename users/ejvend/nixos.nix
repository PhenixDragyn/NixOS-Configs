{ config, desktop, lib, pkgs, ... }: 

let
  ifExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  imports = [  ];

  # ---------------------------------
  
  # USER ACCOUNT
  users = {
    mutableUsers = false;
    users.ejvend = {
      isNormalUser = true;
      description = "Ejvend Nielsen";
      hashedPassword = "$6$5gHF51rq$EpCOchpVHkBXNXJlJSeqa2Uwc7kZlw97r5wnYDzoO2uNXDLRS6rNl3bRJxzttyK3Pd4V6tzwNSz3DcbLeCkZm/";

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

    # groups.ejvend = {
    #   gid = 1000;
    #   name = "ejvend";
    #   members = [ "ejvend" ];
    # };
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

  environment.systemPackages = with pkgs; [
  ];

  # ---------------------------------

  # USER SYMLINKS
  #system.userActivationScripts.linktosharedfolder.text = ''
  #  if [[ ! -h "${config.home.homeDirectory}/Sync/test.txt" ]]; then
  #    ln -s "${config.home.homeDirectory}/Sync/test.txt" "${config.home.homeDirectory}/.config/"
  #  fi
  #'';

  # ---------------------------------

  # Make this user trusted
  nix.settings.trusted-users = [ "ejvend" ];
}
