{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    
    viAlias = true;
    vimAlias = true;
  };
}
