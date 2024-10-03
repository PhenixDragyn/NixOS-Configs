{ inputs, config, lib, pkgs, modulesPath, system, desktop, username, hostname, ... }: 

{
  # HOST NIX PLATFORM
  #nix build .#imageConfigurations.nixos-iso
  nixpkgs.hostPlatform = lib.mkDefault "${system}";

  # ---------------------------------

  # HOST NETWORK SETTINGS
  networking = lib.mkIf (desktop == null) {
    wireless = {
      enable = true;
      # networks."mySSID".psk = "myPSK";
      # extraConfig = "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=wheel"; 
    };

    #wireless.enable = true;
    # wireless.networks = {
    #   "mySSID" = {
    #     psk = "myPSK";
    #     priority = 2;
    #   };
    # };

    networkmanager.enable = lib.mkForce false;
  };

  # ---------------------------------

  # HOST SPECIFIC PACKAGES
  environment.systemPackages = with pkgs; [
    inputs.disko.packages.${system}.default

    wpa_supplicant
    networkmanager
  ];

  # ---------------------------------
  
  # ISO AUTOLOGIN 
  services.getty.autologinUser = "${username}";
}
