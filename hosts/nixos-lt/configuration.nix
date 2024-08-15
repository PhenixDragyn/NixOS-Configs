# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs, outputs, lib, config, pkgs, stable, unstable, userSettings, systemSettings, ... }:

{
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd
    inputs.nixvim.nixosModules.nixvim
    inputs.stylix.nixosModules.stylix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # Import my host modules
    ../builds/common.nix

  ] ++ (if (systemSettings.build == "xfce_bspwm")
	        then [ ../builds/desktop-xfce_bspwm.nix ]
				else 
			  (if (systemSettings.build == "lxqt_bspwm" )
			    then [ ../builds/desktop-lxqt_bspwm.nix ] 
				else 
			  (if (systemSettings.build == "bspwm_gtk" )
			    then [ ../builds/desktop-bspwm_gtk.nix ] 
				else [])));

  #networking.hostName = "nixos-lt";
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older than 30d";
  };

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "05:00";
    randomizedDelaySec = "30min";
  };

  # List of installed packages...
  enivronment.etc."current-system-packages".text =
    let
      packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
      sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
      formatted = builtins.concatStringsSep "\n" sortedUnique;
    in
      formatted


  system.stateVersion = "24.05";
}
