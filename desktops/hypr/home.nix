#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ config, lib, pkgs, username, ... }:

{
  imports = [
    # Modules
    ../../modules/home/fastfetch.nix
    #../../modules/home/lf.nix
    ../../modules/home/ranger.nix
    ../../modules/home/nixvim.nix 
		../../modules/home/spicetify.nix
    #../../modules/home/yazi.nix

    ../../modules/home/firefox.nix
    ../../modules/home/kitty.nix
    ../../modules/home/nautilus.nix

    ../../modules/home/gtk.nix
    ../../modules/home/qt.nix

    ../../modules/home/dunst.nix
    ../../modules/home/hyprland.nix
    ../../modules/home/kanshi.nix
    ../../modules/home/rofi-wayland.nix
		#../../modules/home/swaylock.nix
		#../../modules/home/swayosd.nix
    ../../modules/home/waybar.nix
    ../../modules/home/wlogout.nix

		../../modules/home/imv.nix

		../../modules/home/hyprlock.nix
  ];

  # ---------------------------------

  # SYMLINKS
  home = {
    file.".config/syncthingtray.ini".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/users/${username}/config/syncthing/syncthingtray.ini";
  };
}
