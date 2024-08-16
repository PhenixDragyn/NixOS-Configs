{ inputs, outputs, stateVersion, ... }:

{
  # Helper function for generating home-manager configs
  mkHome =
    {
      hostname,
      username ? "ejvend",
      platform ? "x86_64-linux",
      build ? null,
      theme ? "io", 
    }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${platform};
      extraSpecialArgs = {
        inherit
          inputs
          outputs
          username
          hostname
          platform
          build
          theme
          stateVersion
          ;
      };
      modules = [ ../home/${username}/home.nix ];
    };

  # Helper function for generating NixOS configs
  mkNixos =
    {
      hostname,
      username ? "ejvend",
      platform ? "x86_64-linux",
      build ? null,
      theme ? "io", 
    }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          inputs
          outputs
          username
          hostname
          platform
          build
          theme
          stateVersion
          ;
      };

      modules = [ ../hosts/${hostname}/configuration.nix ];
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "x86_64-linux"
    "aarch64-linux"
  ];
}
