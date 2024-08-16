{ config, lib, pkgs, stable, unstable, buildSettings, ... }:

{
  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
        "gtk-theme" = lib.mkForce "zukitre-dark";
        "gtk-color-scheme" = "prefer-dark";
      };

      "org/gnome/nautilus/preferences" = {
        "migrated-gtk-settings" = true;
      };  

      "org/gnome/nm-applet" = {
        "disable-vpn-notifications" = true;
      };
    };
  };
}
