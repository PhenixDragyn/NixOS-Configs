{ config, pkgs, ... }:

let myCbxScript = ''
  #!/bin/sh

  # this lets my copy and paste images and/or plaintext of files directly out of ranger
  if [ "$#" -le "2" ]; then
    if [ "$1" = "copy" -o "$1" = "cut" ]; then
      if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
        wl-copy < $2;
      else
        # xclip -selection clipboard -t $(file -b --mime-type $2) -i $2;
        xclip -selection clipboard -t image/png -i $2;
      fi
    fi
  fi
  '';
in
{
  # Must copy home/ejvend/config/ranger-plugins manually for icons.
  
  #imports = [ ../../pkgs/ranger.nix ];

	programs.ranger = {
    enable = true;
		settings = {
      preview_images = true;
      #preview_images_method = "sixel";
      dirname_in_tabs = true;
      cd_tab_fuzzy = true;
      autosave_bookmarks = false;
      show_hidden = false;
      wrap_scroll = true;
      column_ratios = "2,2,4";
      hidden_filter = ''^\.|\.(?:pyc|pyo|bak|swp)$|^lost\+found$|^__(py)?cache__$'';
		};
	};

  home.file = {
    ".config/ranger" = {
      source = ./ranger;
      #source = ../${buildSettings.username}/config/ranger;
      recursive = true;
    };

    ".config/ranger/plugins".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/NixOS/modules/home/ranger-plugins";
  };

  home.packages = with pkgs; [
    (pkgs.writeScriptBin "cbx" myCbxScript)
  ];

  xdg.mimeApps.associations.added = {
    "inode/directory" = "ranger.desktop";
  };
}
