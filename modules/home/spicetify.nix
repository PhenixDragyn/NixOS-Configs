{ inputs, lib, pkgs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  # allow spotify to be installed if you don't have unfree enabled already
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
  ];

  # import the flake's module for your system
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  # configure spicetify :)
  programs.spicetify =
    {
      enable = true;
      #theme = spicePkgs.themes.catppuccin;
      #colorScheme = "mocha";
      theme = lib.mkForce spicePkgs.themes.dribbblish;
      colorScheme = lib.mkForce "lunar";

      enabledExtensions = with spicePkgs.extensions; [
			  adblock
				hidePodcasts
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
      ];
    };
}

