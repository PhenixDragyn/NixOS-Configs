#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ config, lib, pkgs, username, ... }:

{
  imports = [
	  # Desktop
    ../../modules/desktop/hyprland/hyprland.nix
		../../modules/desktop/hyprland/hyprlock.nix
    ../../modules/desktop/hyprland/waybar.nix
    ../../modules/desktop/hyprland/wlogout.nix
    ../../modules/desktop/hyprland/kanshi.nix
    ../../modules/desktop/hyprland/dunst.nix
    ../../modules/desktop/hyprland/rofi-wayland.nix


    # Modules
    ../../modules/home/fastfetch.nix

    #../../modules/home/lf.nix
    ../../modules/home/ranger.nix
    #../../modules/home/yazi.nix

    ../../modules/home/nixvim.nix 
		../../modules/home/spicetify.nix

    ../../modules/home/firefox.nix
    ../../modules/home/kitty.nix
    ../../modules/home/nautilus.nix

    ../../modules/home/gtk.nix
    ../../modules/home/qt.nix

		../../modules/home/imv.nix
  ];

  # ---------------------------------

  # SYMLINKS
  home = {
    file.".config/syncthingtray.ini".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/users/${username}/config/syncthing/syncthingtray.ini";
  };
}
