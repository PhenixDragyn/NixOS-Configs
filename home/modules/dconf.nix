{ lib, ... }:

{
  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
        "gtk-theme" = lib.mkForce "pop-gtk";
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
