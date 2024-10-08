#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ config, lib, pkgs, username, ... }:

{
  imports = [
	  # Desktop
	  ../../modules/desktops/hyprland
    # ../../modules/desktops/hyprland/hyprland.nix
		# ../../modules/desktops/hyprland/hyprlock.nix
    ../../modules/desktops/hyprland/waybar.nix
		# ../../modules/desktops/hyprland/wlogout.nix
		# ../../modules/desktops/hyprland/kanshi.nix
		# ../../modules/desktops/hyprland/dunst.nix
		# ../../modules/desktops/hyprland/rofi-wayland.nix
    # ../../modules/desktops/hyprland/imv.nix
    # ../../modules/desktops/hyprland/nautilus.nix


    # Modules
    ../../modules/home/gtk.nix
    ../../modules/home/qt.nix

    ../../modules/home/fastfetch.nix
    #../../modules/home/lf.nix
    ../../modules/home/ranger.nix
    #../../modules/home/yazi.nix
    ../../modules/home/nixvim.nix 
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
