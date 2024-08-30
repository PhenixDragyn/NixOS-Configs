{ config, pkgs, ... }:

with config.lib.stylix.colors.withHashtag;
{
  programs.termite = {
    enable = true;
    allowBold = true;
    audibleBell = false;
    clickableUrl = true;
    dynamicTitle = true;
    mouseAutohide = true;
    scrollOnKeystroke = false;
    font = "Fira Code Nerd Font 12";

    #backgroundColor = "#002b36";
    #foregroundColor = "#839496";
    backgroundColor = base00;
    foregroundColor = base05;

    colorsExtra = ''
      color0 = ${base00}
      color1 = ${base08}
      color2 = ${base0B}
      color3 = ${base0A}
      color4 = ${base0D}
      color5 = ${base05}
      color6 = ${base0C}
      color7 = ${base07}
      color8 = ${base03}
      color9 = ${base08}
      color10 = ${base0A}
      color11 = ${base0B}
      color12 = ${base05}
      color13 = ${base0E}
      color14 = ${base0D}
      color15 = ${base0F}

      color16 = ${base08}
      color17 = ${base09}
      color18 = ${base02}
      color19 = ${base03}
      color20 = ${base04}
      color21 = ${base05}
    '';
  };
}
