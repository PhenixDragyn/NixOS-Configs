#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ config, lib, pkgs, username, ... }:

{
  imports = [
    # Modules
    ../../modules/fastfetch.nix
    ../../modules/ranger.nix
    ../../modules/nixvim.nix 

    ../../modules/firefox.nix
    ../../modules/kitty.nix
    ../../modules/nautilus.nix

    ../../modules/gtk.nix
    ../../modules/qt.nix

    ../../modules/dunst.nix
    ../../modules/hyprland.nix
    ../../modules/rofi-wayland.nix
		#../../modules/swaylock.nix
		#../../modules/swayosd.nix
    ../../modules/waybar.nix
    ../../modules/wlogout.nix

		../../modules/imv.nix

		../../modules/hyprlock.nix
		#../../modules/hyprpaper.nix
  ];

  # ---------------------------------

  # SYMLINKS
  home = {
    file.".config/autostart".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/users/${username}/config/autostart";
    #file.".config/xfce".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${username}/config/xfce";

    file.".config/syncthingtray.ini".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/users/${username}/config/syncthing/syncthingtray.ini";
  };

  # ---------------------------------

	# SET DESKTOP AUTOSTART
	xdg.autostart.enable = true;
}
