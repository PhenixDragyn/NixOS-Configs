{ lib, pkgs, hostname, ... }:

{
  # NETWORKING
  networking = {
    hostName = hostname;

    #wireless.enable = true;
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  # Enable network manager applet
  #programs.nm-applet.enable = true;

  # Enable Avahi for Network/Printing discovery
  services.avahi = {
    publish.enable = true;
    publish.userServices = true;
    nssmdns4 = true;
    enable = true;
    openFirewall = true;
  };

  # Firewall 
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  # Fixes an issue of the service failing and hanging.
  #systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.NetworkManager-wait-online = {
    serviceConfig = {
      ExecStart = [ "" "${pkgs.networkmanager}/bin/nm-online -q" ];
    };
  };

  # BLUETOOTH
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
