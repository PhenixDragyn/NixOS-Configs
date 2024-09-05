{ pkgs, ... }:
let
  clean-hm    = pkgs.writeScriptBin "clean-hm"   "${builtins.readFile ./scripts/clean-hm.sh}";
in {
  environment.systemPackages = [ 
    clean-hm
  ];  
}

