#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ config, lib, pkgs, stable, unstable, buildSettings, ... }:

{
  imports = [
    # Modules
    ../modules/dconf.nix

    ../modules/bspwm.nix
    ../modules/firefox.nix
    ../modules/kitty.nix
    ##../modules/picom.nix
    ../modules/picom-pijulius.nix
    ../modules/dunst.nix
    ../modules/polybar.nix
    ../modules/rofi.nix
    ../modules/sxhkd.nix

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
  };
}
