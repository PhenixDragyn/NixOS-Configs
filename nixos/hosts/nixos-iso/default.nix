{ config, lib, pkgs, modulesPath, system, desktop, username, hostname, ... }: 

{
  #nix build .#imageConfigurations.nixos-iso.config.system.build.isoImage

  nixpkgs.hostPlatform = lib.mkDefault "${system}";

  # NETWORKING
  networking = {
    hostName = hostname;

    #wireless.enable = true;
    networkmanager.enable = lib.mkForce false;
    enableIPv6 = false;
  };

  # OPENSSH
  services.openssh = {
    enable = true;

    settings = {
      PermitRootLogin = lib.mkForce "no";
      PasswordAuthentication = true;
      X11Forwarding = true;
    };
    
    openFirewall = true;
  };
}
