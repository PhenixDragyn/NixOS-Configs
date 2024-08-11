{ userSettings, ... }:

{ 
  services.syncthing = {
    enable = true;
    user = "${userSettings.username}";
    dataDir = "/home/${userSettings.username}/Sync";
    configDir = "/home/${userSettings.username}/.config/syncthing";
    guiAddress = "127.0.0.1:8384";
    openDefaultPorts = true;

    overrideFolders = false;
    overrideDevices = false;

    settings = {
      devices = {
        "Macbook" = { id = "VEV77YU-ZL74KVJ-203R7IX-5IQNQIM-4ZBUBLX-FGQWD06-SZTEEVI-JYYTKQX"; };
        "ArchLinux" = { id = "T2KGAP2-3NUX7XQ-Q77CWIM-QJLB700-ZULQTH3-6JMYJR5-6EZUNKL-VRRCRAI"; };
	#"NixOS-LT" = { id = "R376GRY-YR4MKG2-2UG3VFQ-5RJ7EEI-SZ2LQZX-TLPWXKS-KOPBIU4-SCSRQQO"; };
      };
 
      folders = {
        "Sync" = {
          id = "sync";
          path = "/home/${userSettings.username}/Sync";
          devices = [ "Macbook" "ArchLinux" ];
        };
      };

      #options.globalAnnounceEnabled = false; # Only sync on LAN
    };

  # Don't create the default ~/Sync folder
  #environment.STNODEFAULTFOLDER = "true";
  };
}
