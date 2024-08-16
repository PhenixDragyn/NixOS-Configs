{ pkgs, stable, unstable, buildSettings, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    
    viAlias = true;
    vimAlias = true;
  };
}
