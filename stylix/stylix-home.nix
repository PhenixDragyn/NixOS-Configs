{ inputs, pkgs, config, theme, ... }:

{
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    image = ../files/wallpaper/NixOS-Nineish-Dark.png;
    base16Scheme = ./. + "/themes"+("/"+theme)+".yaml";

    opacity = {
      terminal = 0.8;
      popups = 0.8;
    };

    cursor = {
      package = pkgs.volantes-cursors;
      name = "volantes_cursors";
      size = 24;
    };

    fonts = {
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };
    };
  };
}
