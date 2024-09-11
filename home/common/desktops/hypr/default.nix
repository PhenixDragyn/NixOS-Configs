#{ inputs, outputs, lib, config, pkgs, stable, unstable, username, hostname, platform, build, theme, isWorkstation, stateVersion, ... }:
{ ... }:

{
  imports = [
    # Modules
    ../../modules/ranger.nix
    ../../modules/nixvim.nix 

    ../../modules/firefox.nix
    ../../modules/kitty.nix

    ../../modules/gtk.nix

    ../../modules/hyprland.nix
    ../../modules/mako.nix
    ../../modules/rofi-wayland.nix
		../../modules/swaylock.nix
		#../../modules/swayosd.nix
    ../../modules/waybar.nix
    ../../modules/wlogout.nix

		../../modules/hyprpaper.nix
  ];

  # ---------------------------------

  # SYMLINKS
  home = {
    #file.".config/autostart".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/autostart";
    #file.".config/fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/users/${username}/config/fastfetch";
    #file.".config/xfce".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/${buildSettings.username}/config/xfce";

    #file.".config/syncthingtray.ini".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/home/users/${username}/config/syncthing/syncthingtray.ini";
  };
}
