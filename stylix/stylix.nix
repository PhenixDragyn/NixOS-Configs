{ inputs, pkgs, theme, ... }:

{
  # imports = [
  #   inputs.stylix.nixosModules.stylix
  # ];
  
  # STYLIX
  stylix = {
    enable = true;
    autoEnable = true;

    #base16Scheme = ./. + "./themes"+("/"+theme)+".yaml";
    base16Scheme = ./. + "/themes"+("/"+theme)+".yaml";
    #polarity = buildSettings.polarity;
    image = ../files/wallpaper/NixOS-Nineish-Dark.png;

    # Remove rounded corners in Gnome
    # targets.gtk = {
    #   extraCss = ''
    #     window.background { border-radius: 0; }
    #   '';
    # };
  };
}
