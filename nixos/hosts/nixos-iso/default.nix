{ inputs, config, lib, pkgs, modulesPath, system, desktop, username, hostname, ... }: 

{
  #nix build .#imageConfigurations.nixos-iso
  nixpkgs.hostPlatform = lib.mkDefault "${system}";

  # BOOT SETTINGS
	#boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

  # NETWORKING
  networking = {
    #enable = true;
    hostName = hostname;
 
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
    enableIPv6 = false;
  };

  environment.systemPackages = with pkgs; [
    inputs.disko.packages.${system}.default

    wpa_supplicant
    networkmanager
  ];

  services.getty.autologinUser = "${username}";
}
