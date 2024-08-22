#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ config, lib, pkgs, stable, unstable, buildSettings, ... }:

{
  imports = [
    # Modules
    ../modules/dconf.nix

    ../modules/kitty.nix
    ##../modules/picom.nix
    ../modules/picom-pijulius.nix
    ../modules/dunst.nix
    ../modules/polybar-xfce.nix
    ../modules/rofi.nix

    ../modules/ranger.nix
    ../modules/nixvim.nix 

    ../modules/gtk.nix
  ];

  # ---------------------------------

  # SYMLINKS
  home = {
    file.".fehbg-stylix".text = ''
      #!/bin/sh
      feh --no-fehbg --bg-fill ''+config.stylix.image+'';
    '';
    file.".fehbg-stylix".executable = true;

    file.".config/bspwm".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/bspwm";
    file.".config/sxhkd/sxhkdrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/sxhkd/sxhkdrc-xfce_bspwm";

    ##file.".config/autorandr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/autorandr";
    #file.".config/autostart".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/autostart";
    #file.".config/featherpad".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/featherpad";
    #file.".config/keepassxc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/keepassxc";
    #file.".config/lxqt".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/lxqt";
    #file.".config/qimgv".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/qimgv";
    #file.".config/qt5ct".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/qt5ct";
    #file.".config/qt6ct".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/qt6ct";

    #file.".config/syncthingtray.ini".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/syncthing/syncthingtray.ini";
  };
}
