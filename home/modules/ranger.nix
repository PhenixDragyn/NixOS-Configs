{ config, lib, pkgs, stable, unstable, buildSettings, ... }:

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
  #imports = [ ../../pkgs/ranger.nix ];

  home.packages = with pkgs; [
    (pkgs.writeScriptBin "cbx" myCbxScript)
  ];
  xdg.mimeApps.associations.added = {
    "inode/directory" = "ranger.desktop";
  };

  home.file = {
    ".config/ranger" = {
      source = ../${buildSettings.username}/config/ranger;
      recursive = true;
    };
    # Must copy home/ejvend/config/ranger-plugins manually for icons.
  };
}
