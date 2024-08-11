{ config, pkgs, stable, unstable, userSettings, ... }:

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
  #home.file.".config/ranger/rc.conf".source = "${config.home.homeDirectory}/NixOS/files/config/ranger/rc.conf";
  #home.file.".config/ranger/rifle.conf".source = "${config.home.homeDirectory}/NixOS/files/config/ranger/rifle.conf";
  #home.file.".config/ranger/scope.sh" = {
  #  source = "${config.home.homeDirectory}/NixOS/files/config/ranger/scope.sh";
  #  executable = true;
  #};
  #home.file.".config/ranger/commands.py" = {
  #  source = "${config.home.homeDirectory}/NixOS/files/config/ranger/commands.py";
  #  executable = true;
  #};
  #home.file.".config/ranger/commands_full.py" = {
  #  source = "${config.home.homeDirectory}/NixOS/files/config/ranger/commands_full.py";
  #  executable = true;
  #};
  #home.file.".config/ranger/colorschemes/hail.py" = {
  #  source = "${config.home.homeDirectory}/NixOS/files/config/ranger/colorschemes/hail.py";
  #  executable = true;
  #};

  home.file = {
    ".config/ranger" = {
      source = ../${userSettings.username}/config/ranger;
      recursive = true;
    };
    # Must copy home/ejvend/config/ranger-plugins manually for icons.
  };
}
