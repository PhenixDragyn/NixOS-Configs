{ inputs, pkgs, config, theme, ... }:

{
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
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };      
      monospace = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans Mono";
      };

      sizes = {
        terminal = 14;
      };

			# serif = config.stylix.fonts.monospace;
      # sansSerif = config.stylix.fonts.monospace;
      # monospace = {
      #   package = pkgs.intel-one-mono;
      #   name = "Intel One Mono";
      #};

			# serif = config.stylix.fonts.monospace;
      # sansSerif = config.stylix.fonts.monospace;
      # monospace = {
      #   package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
      #   name = "JetBrainsMono Nerd Font";
      #};
    };
  };

  # Themes https://github.com/tinted-theming/base16-schemes
}
