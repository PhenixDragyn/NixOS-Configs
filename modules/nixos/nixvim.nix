{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nixvim.nixosModules.nixvim
  ];

  environment.systemPackages = with pkgs; [
    #ripgrep
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    
    viAlias = true;
    vimAlias = true;
  };
}
