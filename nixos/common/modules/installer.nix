{ config, desktop, lib, pkgs, username, ... }:
let
  install-system = pkgs.writeScriptBin "install-system" "${builtins.readFile ../../../files/scripts/install.sh}";
in
{
  config.environment.systemPackages = [ install-system ];
}
