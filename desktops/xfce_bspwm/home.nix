#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ config, lib, pkgs, username, ... }:

{
  imports = [
    # Desktop
    ../../modules/desktops/xfce_bspwm/bspwm.nix
    ##../../modules/desktops/xfce_bspwm/picom.nix
    ../../modules/desktops/xfce_bspwm/picom-pijulius.nix
    ../../modules/desktops/xfce_bspwm/dunst.nix
    ../../modules/desktops/xfce_bspwm/polybar.nix
    ../../modules/desktops/xfce_bspwm/rofi.nix
    ../../modules/desktops/xfce_bspwm/sxhkd.nix

    # Modules
    #../../modules/home/dconf.nix

    ../../modules/home/firefox.nix
    ../../modules/home/kitty.nix
    ../../modules/home/termite.nix

    ../../modules/home/fastfetch.nix
    ../../modules/home/feh.nix
    #../../modules/home/lf.nix
    ../../modules/home/ranger.nix
    #../../modules/home/yazi.nix

    ../../modules/home/nixvim.nix 

    ../../modules/home/gtk.nix
  ];

  # ---------------------------------

  # SYMLINKS
  home = {
    #file.".config/autostart".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/autostart";
    #file.".config/xfce".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/xfce";
  };
}
