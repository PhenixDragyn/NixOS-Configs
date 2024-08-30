{ config, pkgs, ... }:

{
  programs.termite = {
    enable = true;
    allowBold = true;
    audibleBell = false;
    clickableUrl = true;
    dynamicTitle = true;
    mouseAutohide = true;
    scrollOnKeystroke = false;
    font = "Fira Code 12";
  };
}
