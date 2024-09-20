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
      #   urAccepted = -1;
      #   localAnnouncedEnabled = true;
      #   relaysEnabled = false;
      # };
      options.gui = {
        theme = "dark";
      };
      devices = {
        "Macbook" = { 
          autoAcceptFolders = true;
          id = "VEV77YU-ZL74KVJ-203R7IX-5IQNQIM-4ZBUBLX-FGQWD06-SZTEEVI-JYYTKQX"; 
        };
        # "ArchLinux" = { 
        #   autoAcceptFolders = true;
        #   id = "T2KGAP2-3NUX7XQ-Q77CWIM-QJLB700-ZULQTH3-6JMYJR5-6EZUNKL-VRRCRAI"; 
        # };
      	#"NixOS-LT" = { id = "R376GRY-YR4MKG2-2UG3VFQ-5RJ7EEI-SZ2LQZX-TLPWXKS-KOPBIU4-SCSRQQO"; };
      };
 
      folders = {
        "Sync" = {
          id = "sync";
          path = "/home/${username}/Sync";
          #versioning.type = "trashcan";
          devices = [ "Macbook" "ArchLinux" ];
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
