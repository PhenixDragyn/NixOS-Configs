#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ ... }:

{
  imports = [
    # Modules
    ../../modules/dconf.nix

    ../../modules/bspwm.nix
    ../../modules/firefox.nix
    ../../modules/kitty.nix
    ##../../modules/picom.nix
    ../../modules/picom-pijulius.nix
    ../../modules/dunst.nix
    ../../modules/polybar.nix
    ../../modules/rofi.nix
    ../../modules/sxhkd.nix
    ../../modules/termite.nix

    ../../modules/ranger.nix
    ../../modules/nixvim.nix 

    ../../modules/gtk.nix
  ];

  # ---------------------------------

  # SYMLINKS
  home = {
    #file.".config/autostart".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/autostart";
    #file.".config/xfce".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/xfce";
  };
}