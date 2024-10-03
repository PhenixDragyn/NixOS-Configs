#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ config, lib, pkgs, username, ... }:

{
  imports = [
    # Modules
    #../../modules/home/dconf.nix

    ../../modules/home/bspwm.nix
    ../../modules/home/firefox.nix
    ../../modules/home/kitty.nix
    ##../../modules/home/picom.nix
    ../../modules/home/picom-pijulius.nix
    ../../modules/home/dunst.nix
    ../../modules/home/polybar.nix
    ../../modules/home/rofi.nix
    ../../modules/home/sxhkd.nix
    ../../modules/home/termite.nix

    ../../modules/home/fastfetch.nix
    ../../modules/home/feh.nix
    #../../modules/home/lf.nix
    #../../modules/home/ranger.nix
    ../../modules/home/nixvim.nix 
    ../../modules/home/yazi.nix

    ../../modules/home/gtk.nix
  ];

  # ---------------------------------

  # SYMLINKS
  home = {
    #file.".config/autostart".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/autostart";
    #file.".config/xfce".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/xfce";
  };
}
