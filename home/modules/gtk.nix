{ config, pkgs, lib, ... }:

{
  gtk = {
    enable = true;
      iconTheme = {
      name = "elementary-Xfce-dark";
      package = pkgs.elementary-xfce-icon-theme;
    };
    theme = {
      name = lib.mkForce "zukitre-dark";
      #package = pkgs.zuki-themes;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}