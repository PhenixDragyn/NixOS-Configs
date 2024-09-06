{ config, lib, pkgs, modulesPath, desktop, username, ... }: {

  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "nixos-iso-console";

  #networking.firewall.allowedTCPPorts = [ 22 ];

  # Allow passworded ssh
  # services.openssh = {
  #   enable = true;
  #   openFirewall = false;
  #   settings = {
  #     PermitRootLogin = "no";
  #     PasswordAuthentication = lib.mkForce true;
  #   };
  # };
}
