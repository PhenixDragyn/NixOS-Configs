#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ config, lib, pkgs, username, ... }:

{
  imports = [
	  # Desktop
	  ../../modules/desktops/hyprland

    # Modules
    ../../modules/home/gtk.nix
    ../../modules/home/qt.nix

		../../modules/home/spicetify.nix
    ../../modules/home/firefox.nix
    ../../modules/home/kitty.nix
  ];

  # ---------------------------------

  # SYMLINKS
  home = {
    file.".config/syncthingtray.ini".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/users/${username}/config/syncthing/syncthingtray.ini";
  };
}
