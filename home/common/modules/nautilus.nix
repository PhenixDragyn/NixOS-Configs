{ pkgs, username, desktop, ... }:

{
  home.file = { 
    ".local/share/nautilus/scripts" = {
      source = ./nautilus/scripts;
      recursive = true;
    };
}
