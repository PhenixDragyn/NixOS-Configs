#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ config, lib, pkgs, username, ... }:

{
  imports = [
	  # Desktop
	  ../../modules/desktops/hyprland

    # Modules
    ../../modules/home/gtk.nix
    ../../modules/home/qt.nix

		#../../modules/home/spicetify.nix
    #../../modules/home/firefox.nix
    ../../modules/home/kitty.nix
  ];

  # ---------------------------------

  # SYMLINKS
  home = {
    file.".config/syncthingtray.ini".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/users/${username}/config/syncthing/syncthingtray.ini";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ 
		  pkgs.xdg-desktop-portal
			pkgs.xdg-desktop-portal-wlr
		  pkgs.xdg-desktop-portal-gtk 
		  pkgs.xdg-desktop-portal-hyprland
		];

    xdgOpenUsePortal = true;
    config.common.default = [ "gtk" "hyprland" ];
		config.common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
		config.common."org.freedesktop.portal.FileChooser" = [ "gtk" ];
		config.common."org.freedesktop.portal.OpenURI" = [ "gtk" ];

		# config = {
		#   common = {
		# 		default = [ "gtk" ];
		# 		"org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
		# 	};
		# 	hyprland = {
 	#   		default = [ "hyprland" "gtk" ];
		# 		"org.freedesktop.portal.FileChooser" = [ "gtk" ];
		#     "org.freedesktop.portal.OpenURI" = [ "gtk" ];
	 #  	};
		# };
  };
}
