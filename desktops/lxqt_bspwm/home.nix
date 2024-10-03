#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ config, lib, pkgs, username, ... }:

{
  imports = [
    # Modules
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
  ];

  # ---------------------------------

  # SYMLINKS
  home = {
    file.".config/autostart".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/users/${username}/config/autostart";
    file.".config/featherpad".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/users/${username}/config/featherpad";
    file.".config/keepassxc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/users/${username}/config/keepassxc";
    file.".config/lxqt".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/users/${username}/config/lxqt";
    file.".config/qimgv".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/users/${username}/config/qimgv";
    file.".config/qt5ct".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/users/${username}/config/qt5ct";
    file.".config/qt6ct".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/users/${username}/config/qt6ct";

    file.".config/syncthingtray.ini".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/users/${username}/config/syncthing/syncthingtray.ini";
  };
}
