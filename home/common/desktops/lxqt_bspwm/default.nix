#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ config, lib, pkgs, username, ... }:

{
  imports = [
    # Modules
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

    ../../modules/fastfetch.nix
    ../../modules/feh.nix
    ../../modules/lf.nix
    #../../modules/ranger.nix
    ../../modules/nixvim.nix 
    #../../modules/yazi.nix
  ];

  # ---------------------------------

  # SYMLINKS
  home = {
    file.".config/autostart".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/users/${username}/config/autostart";
    file.".config/featherpad".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/users/${username}/config/featherpad";
    file.".config/keepassxc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/users/${username}/config/keepassxc";
    file.".config/lxqt".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/users/${username}/config/lxqt";
    file.".config/qimgv".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/users/${username}/config/qimgv";
    file.".config/qt5ct".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/users/${username}/config/qt5ct";
    file.".config/qt6ct".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/users/${username}/config/qt6ct";

    file.".config/syncthingtray.ini".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/users/${username}/config/syncthing/syncthingtray.ini";
  };
}
