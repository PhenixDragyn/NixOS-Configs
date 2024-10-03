{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mangohud
  ];

  # https://nixos.wiki/wiki/Steam
  programs = {
    steam = {
      enable = true;

      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
  };
}
