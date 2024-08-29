{ config, lib, pkgs, stable, unstable, buildSettings, ... }:

{ 
  environment.systemPackages = with pkgs; [
    syncthingtray
  ];

  services.syncthing = {
    enable = true;
    user = "${buildSettings.username}";
    dataDir = "/home/${buildSettings.username}/Sync";
    configDir = "/home/${buildSettings.username}/.config/syncthing";
    guiAddress = "127.0.0.1:8384";
    openDefaultPorts = true;

    overrideFolders = false;
    overrideDevices = false;

    settings = {
      options.gui = {
        theme = "dark";
      };
      devices = {
        "Macbook" = { id = "VEV77YU-ZL74KVJ-203R7IX-5IQNQIM-4ZBUBLX-FGQWD06-SZTEEVI-JYYTKQX"; };
        "ArchLinux" = { id = "T2KGAP2-3NUX7XQ-Q77CWIM-QJLB700-ZULQTH3-6JMYJR5-6EZUNKL-VRRCRAI"; };
      	#"NixOS-LT" = { id = "R376GRY-YR4MKG2-2UG3VFQ-5RJ7EEI-SZ2LQZX-TLPWXKS-KOPBIU4-SCSRQQO"; };
      };
 
      folders = {
        "Sync" = {
          id = "sync";
          path = "/home/${buildSettings.username}/Sync";
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
