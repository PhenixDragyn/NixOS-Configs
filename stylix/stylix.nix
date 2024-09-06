{ inputs, pkgs, theme, ... }:

{
  # imports = [
  #   inputs.stylix.nixosModules.stylix
  # ];
  
  # STYLIX
  stylix = {
    enable = true;
    autoEnable = true;

    base16Scheme = ./. + "/themes"+("/"+theme)+".yaml";
    image = ../files/wallpaper/NixOS-Nineish-Dark.png;
    #polarity = dark;

    # Remove rounded corners in Gnome
    # targets.gtk = {
    #   extraCss = ''
    #     window.background { border-radius: 0; }
    #   '';
    # };
  };

  # Themes https://github.com/tinted-theming/base16-schemes
}
