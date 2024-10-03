{ pkgs, ... }:
let
  clean-hm = pkgs.writeScriptBin "clean-hm"   "${builtins.readFile ../../../files/scripts/clean-hm.sh}";
in {
  environment.systemPackages = [ 
    clean-hm
  ];  
}

