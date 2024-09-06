{ lib ? lib, self, inputs, outputs, stateVersion, hmStateVersion , ... }: 

{
  # Helper function for generating host configs
  mkNixOS = { 
    hostname, 
    username  ? "ejvend",
    desktop   ? null, 
    system    ? "x86_64-linux", 
    theme     ? "default",
    type      ? "default",
    repo      ? "nixpkgs",
    #deployment_type ? "hosts",
    unfree    ? false
  }: inputs.${repo}.lib.nixosSystem { 
    specialArgs = { 
      inherit inputs outputs desktop hostname username hmStateVersion stateVersion system theme self;
      #inherit inputs outputs desktop hostname username hmStateVersion stateVersion system theme self deployment_type;
      # Choose whether to pull from stable or unstable 
      pkgs          = let packages = (import ./packages.nix { inherit inputs repo system unfree; }); in packages.pkgs;
      pkgs-unstable = let packages = (import ./packages.nix { inherit inputs repo system unfree; }); in packages.pkgs-unstable;
    };

    modules = [
      # Types are 'default', 'small', and 'minimal'
      ../nixos/${type}.nix
      #inputs.sops-nix.nixosModules.sops
      #inputs.lanzaboote.nixosModules.lanzaboote
    ];
  };

  # Helper function for generating home-manager configs
  mkHome = { 
    hostname, 
    username ? "ejvend",
    desktop  ? null, 
    system   ? "x86_64-linux", 
    theme    ? "default",
    type     ? "default",
  }: inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    extraSpecialArgs = { inherit inputs outputs desktop hostname system username hmStateVersion theme; };
    modules = [ ../home/${type}.nix ];
  };

  # Combines mkHost and mkHome for image building
  mkImage = {
    hostname  , 
    username  ? "ejvend",
    desktop   ? null, 
    system    ? "x86_64-linux",
    theme     ? "default",
    type      ? "default",
    repo      ? "nixpkgs",
    unfree    ? false,
    format
  }: inputs.nixos-generators.nixosGenerate {
  #}: inputs.${repo}.lib.nixosSystem {
    specialArgs = { 
      #inherit inputs outputs desktop hostname username stateVersion hmStateVersion system theme; 
      inherit inputs outputs desktop hostname username stateVersion hmStateVersion system theme format; 
      # Choose whether to pull from stable or unstable 
      pkgs          = let packages = (import ./packages.nix { inherit inputs repo system unfree; }); in packages.pkgs;
      pkgs-unstable = let packages = (import ./packages.nix { inherit inputs repo system unfree; }); in packages.pkgs-unstable;
    };
    system = system;
    format = format;

    modules = [
      ../nixos
      ../nixos/common/modules/installer.nix
      "${inputs.nixpkgs}/nixos/modules/profiles/all-hardware.nix"
      #"${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"

      #inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs  = { inherit inputs outputs desktop hostname username hmStateVersion stateVersion system theme; };
        home-manager.users."${username}" = import ../home;
      }
    ];
  };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "x86_64-linux"
  ];
}
