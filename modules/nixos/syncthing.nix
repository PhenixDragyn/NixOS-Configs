{ pkgs, username, hostname, ... }:

{ 
  # sops.secrets."syncthing_cert" = {
  #   owner = "root";
  #   sopsFile = ../../../secrets/${deployment_type}/${hostname}.yaml;
  #   restartUnits = [ "syncthing.service" ];
  # };
  #
  # sops.secrets."syncthing_key" = {
  #   owner = "root";
  #   sopsFile = ../../../secrets/${deployment_type}/${hostname}.yaml;
  #   restartUnits = [ "syncthing.service" ];
  # };
  
  environment.systemPackages = with pkgs; [
    syncthingtray
  ];

  services.syncthing = {
    enable = true;
    user = "${username}";
    dataDir = "/home/${username}/Sync";
    configDir = "/home/${username}/.config/syncthing";
    guiAddress = "127.0.0.1:8384";
    openDefaultPorts = true;

    #cert = "/run/secrets/syncthing_cert";
    #key = "/run/secrets/syncthing_key";

    # overrideFolders = true;
    # overrideDevices = true;
    overrideFolders = false;
    overrideDevices = false;

    settings = {
      # options = {
      #   urAccepted = 3;
      #   localAnnouncedEnabled = true;
			#   globalAnnouncedEnabled = true;
      #   natEnabled = true;
      # };
      options.gui = {
        theme = "dark";
      };
      devices = {
        "Macbook" = { 
          autoAcceptFolders = true;
          id = "VEV77YU-ZL74KVJ-203R7IX-5IQNQIM-4ZBUBLX-FGQWD06-SZTEEVI-JYYTKQX"; 
        };
        "Macbook-Air" = { 
          autoAcceptFolders = true;
          id = "A5CANTE-E3E4PYO-WHNZXKS-PZRBX32-EYKWMB5-GNCRUV5-WEL3SGO-JMBESAL";
        };
        "NixOS-LT" = { 
          autoAcceptFolders = true;
				  id = "TMYBKYP-CAAHX43-FF542D2-I53C5JX-XJWP6DT-U2LHOV3-AQO4MHB-3T5ZFAV";
        };
      };
 
      folders = {
        "Sync" = {
          id = "sync";
          path = "/home/${username}/Sync";
          #versioning.type = "trashcan";
          devices = [ "Macbook-Air" ];
          #devices = [ "Macbook" "ArchLinux" ];
        };
      };

      #gui = {
      #  user = "";
      #  password = "";
      #};

      #options.globalAnnounceEnabled = false; # Only sync on LAN
    };

  # Don't create the default ~/Sync folder
  #environment.STNODEFAULTFOLDER = "true";
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
