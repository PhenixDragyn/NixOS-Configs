#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ config, lib, pkgs, username, ... }:

{
  imports = [
    # Desktop
		../../modules/desktops/lxqt_bspwm
    # ../../modules/desktops/lxqt_bspwm/bspwm.nix
    # ##../../modules/desktops/lxqt_bspwm/picom.nix
    # ../../modules/desktops/lxqt_bspwm/picom-pijulius.nix
    # ../../modules/desktops/lxqt_bspwm/dunst.nix
    # ../../modules/desktops/lxqt_bspwm/polybar.nix
    # ../../modules/desktops/lxqt_bspwm/rofi.nix
    # ../../modules/desktops/lxqt_bspwm/sxhkd.nix
    # ../../modules/desktops/lxqt_bspwm/feh.nix
    
    # Modules
    ../../modules/home/firefox.nix
    ../../modules/home/kitty.nix
    ../../modules/home/termite.nix

    ../../modules/home/fastfetch.nix
    ../../modules/home/feh.nix
    #../../modules/home/lf.nix
    ../../modules/home/ranger.nix
    #../../modules/home/yazi.nix

    ../../modules/home/nixvim.nix 
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
