#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ config, lib, pkgs, username, ... }:

{
  imports = [
    # Desktop
	  ../../modules/desktops/xfce_bspwm

    # Modules
    ../../modules/home/gtk.nix

    ../../modules/home/firefox.nix
    ../../modules/home/kitty.nix
    ../../modules/home/termite.nix
  ];

  # ---------------------------------

  # SYMLINKS
  home = {
    #file.".config/autostart".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/autostart";
    #file.".config/xfce".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/xfce";
  };
}
