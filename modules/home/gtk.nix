{ lib, pkgs, ... }:

{
  gtk = {
    enable = true;

    # cursorTheme = {
    #   name = "Simp1e-Dark";
		# 	package = pkgs.simp1e-cursors;
		# };

    iconTheme = {
      name = "Papirus-Dark";
      #package = pkgs.papirus-icon-theme;
      #package = pkgs.papirus-icon-theme.override {color = "adwaita";};
      package = pkgs.catppuccin-papirus-folders.override {flavor = "mocha"; accent = "sapphire";};
		};

    # iconTheme = {
    #   #name = lib.mkForce "Pop";
    #   #package = lib.mkForce pkgs.pop-icon-theme;
    #   name = "Papirus-Dark";
    #   package = pkgs.papirus-icon-theme;
    #   #package = pkgs.papirus-icon-theme.override {color = "indigo";};
    # };

    theme = {
      #name = lib.mkForce "Pop-dark";
      #package = lib.mkForce pkgs.pop-gtk-theme;
      name = lib.mkForce "adw-gtk3-dark";
      package = lib.mkForce pkgs.adw-gtk3;
    };
  };

  dconf.settings = {
     "org/gnome/desktop/interface" = {
       color-scheme = lib.mkForce "prefer-dark";
       #gtk-theme = lib.mkForce "Pop-dark";
       gtk-theme = lib.mkForce "adw-gtk3-dark";
     };

    # "org/gnome/desktop/wm/preferences" = {
    #   button-layout = "appmenu:minimize,maximize,close";
    # };

    # "org/gnome/desktop/wm/keybindings" = {
    #  close = ["<Super>q"];
    # };

    # "org/gnome/settings-daemon/plugins/media-keys" = {
    #   custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
    # };
    
    # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    #   name = "alacritty";
    #   binding = "<Super>Return"; 
    #   command = "alacritty";
    # };

    # "org/gnome/desktop/input-sources" = {
    #   xkb-options = ["terminate:ctrl_alt_bksp" "caps:escape"];
    # };
    
    #"org/gnome/shell" = {
    #  disable-user-extensions = false;
    #   favorite-apps = [
    #     "firefox.desktop"
				# "org.gnome.Nautilus.desktop"
				# "org.gnome.Software.desktop"
				# "kitty.desktop"
				# "idea-ultimate.desktop"
				# "codium.desktop"
				# "freetube.desktop"
				# "bitwarden.desktop"
				# "org.gnome.Settings.desktop"
	   #    "org.gnome.tweaks.desktop"
    #   ];

    #  enable-extensions = [
				#"appindicatorsupport@rgcjonas.gmail.com"
				#"dash-to-dock@micxgx.gmail.com"
				#"gsconnect@andyholmes.github.io"
				#"user-theme@gnome-shell-extensions.gcampax.github.com"
				#"native-window-placement@gnome-shell-extensions.gcampax.github.com"
     # ];
    #};

    # "org/gnome/shell/extensions/dash-to-dock" = {
    #   "custom-theme-shrink" = true;
    #   "scroll-action" = "cycle-windows";
    #   "click-action" = "skip";
    #   "show-mounts" = false;
    #   "show-trash" = false;
    #   "show-show-apps-button" = false;
    #   "running-indicator-style" = "DOTS";
    #   "hot-keys" = false;
    # };

    "org/gnome/nautilus/preferences" = {
      "migrated-gtk-settings" = true;
      "default-folder-viewer" = "list-view";
      "show-delete-permanently" = true;
    };

    "org/gnome/nautilus/list-view" = {
      "default-zoom-level" = "small";
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      "sort-directories-first" = true;
    };

    "org/gnome/nm-applet" = {
      "disable-vpn-notifications" = true;
    };
  };

  # gtk = {
  #   enable = true;
  #     iconTheme = {
  #     name = "Pop";
  #     #package = pkgs.elementary-xfce-icon-theme;
  #   };
  #   theme = {
  #     name = lib.mkForce "Pop-dark";
  #     #package = pkgs.zuki-themes;
  #   };
  #   gtk3.extraConfig = {
  #     Settings = ''
  #       gtk-application-prefer-dark-theme=1
  #     '';
  #   };
  #   gtk4.extraConfig = {
  #     Settings = ''
  #       gtk-application-prefer-dark-theme=1
  #     '';
  #   };
  # };

    # Stop gtk4 from being rounded
    # gtk4.extraCss = ''
    #   window {
    #     border-top-left-radius:0;
    #     border-top-right-radius:0;
    #     border-bottom-left-radius:0;
    #     border-bottom-right-radius:0;
    #   }
    # '';

  stylix = {
    # Remove rounded corners in Gnome
     targets.gtk = {
       extraCss = ''
         window.background { border-radius: 0; }
       '';
     };
  };
}
