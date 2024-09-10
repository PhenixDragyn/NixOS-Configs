#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ ... }:

{
  imports = [
    # Modules
    ../../modules/ranger.nix
    ../../modules/nixvim.nix 

    ../../modules/gtk.nix
  ];

  # ---------------------------------

  # SYMLINKS
  home = {
    #file.".config/autostart".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/autostart";
    #file.".config/fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/users/${username}/config/fastfetch";
    #file.".config/xfce".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/xfce";
  };
}
