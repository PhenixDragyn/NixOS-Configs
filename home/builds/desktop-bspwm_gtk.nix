{ inputs, outputs, lib, config, pkgs, stable, unstable, userSettings, systemSettings, ...}: 

{
  imports = [
    # Modules
    ../modules/dconf.nix

    ../modules/kitty.nix
    ##../modules/picom.nix
    ../modules/picom-pijulius.nix
    ../modules/dunst.nix
    ../modules/polybar-gtk.nix
    ../modules/rofi.nix

    ../modules/ranger.nix
    ../modules/nixvim.nix 
  ];

  # SYMLINKS
  home = {
    #file.".fehbg-stylix".text = ''
      #!/bin/sh
    #  feh --no-fehbg --bg-fill ''+config.stylix.image+'';
    #'';
    #file.".fehbg-stylix".executable = true;

    file.".config/bspwm".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${userSettings.username}/config/bspwm";
    file.".config/sxhkd/sxhkdrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${userSettings.username}/config/sxhkd/sxhkdrc-bspwm_gtk";
    file.".config/rofi/powermenu".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${userSettings.username}/config/rofi/powermenu";

    #file.".config/rofi/powermenu" = {
      #recursive = true;
      #source = ../ejvend/config/rofi/powermenu;
    #};

    #file.".config/rofi/themes" = {
    #	recursive = true;
    #	source = ../ejvend/config/rofi/themes;
    #};

    #file.".config/autostart".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${userSettings.username}/config/autostart";
    #file.".config/featherpad".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${userSettings.username}/config/featherpad";
    #file.".config/keepassxc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${userSettings.username}/config/keepassxc";
    #file.".config/lxqt".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${userSettings.username}/config/lxqt";
    #file.".config/qimgv".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${userSettings.username}/config/qimgv";
    #file.".config/qt5ct".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${userSettings.username}/config/qt5ct";
    #file.".config/qt6ct".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${userSettings.username}/config/qt6ct";
  };
}
