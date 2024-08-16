# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs, outputs, lib, config, pkgs, stable, unstable, buildSettings, stateVersion, ... }:

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

  ] ++ (if (buildSettings.build == "xfce_bspwm")
	        then [ ../builds/desktop-xfce_bspwm.nix ]
				else 
			  (if (buildSettings.build == "lxqt_bspwm" )
			    then [ ../builds/desktop-lxqt_bspwm.nix ] 
				else 
			  (if (buildSettings.build == "bspwm_gtk" )
			    then [ ../builds/desktop-bspwm_gtk.nix ] 
				else [])));

  #networking.hostName = "nixos-mvm";

  system.stateVersion = stateVersion;
}
