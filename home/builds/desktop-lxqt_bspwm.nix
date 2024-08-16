{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:

{
  imports = [
    # Modules
    ../modules/kitty.nix
    ##../modules/picom.nix
    ../modules/picom-pijulius.nix
    ../modules/dunst.nix
    ../modules/polybar-lxqt.nix
    ../modules/rofi.nix

    ../modules/ranger.nix
    ../modules/nixvim.nix 
  ];

  # ---------------------------------

  # SYMLINKS
  home = {
    file.".fehbg-stylix".text = ''
      #!/bin/sh
      feh --no-fehbg --bg-fill ''+config.stylix.image+'';
    '';
    file.".fehbg-stylix".executable = true;


    file.".config/bspwm".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${username}/config/bspwm";
    file.".config/sxhkd/sxhkdrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${username}/config/sxhkd/sxhkdrc-lxqt_bspwm";

    file.".config/autostart".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${username}/config/autostart";
    file.".config/featherpad".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${username}/config/featherpad";
    file.".config/keepassxc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${username}/config/keepassxc";
    file.".config/lxqt".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${username}/config/lxqt";
    file.".config/qimgv".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${username}/config/qimgv";
    file.".config/qt5ct".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${username}/config/qt5ct";
    file.".config/qt6ct".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${username}/config/qt6ct";

    file.".config/syncthingtray.ini".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${username}/config/syncthing/syncthingtray.ini";
  };
}
