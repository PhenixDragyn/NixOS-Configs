{ lib ? lib, self, inputs, outputs, stateVersion, hmStateVersion , ... }: 

{
  deploy = {
    hostname, 
    system    ? "x86_64-linux", 
    username  ? "ejvend"
  }: {
    user = "root";
    sshUser = "${username}";
    hostname = "${hostname}";
    sshOpts = [ "-A" "-q"];

    profiles = {
      system.path = inputs.deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.${hostname};
      home-manager.path = inputs.deploy-rs.lib.${system}.activate.home-manager self.homeConfigurations."${username}@${hostname}";
      home-manager.user = "${username}";
    };
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


  # Helper function for generating host configs
  mkNixOS = { 
    hostname, 
    username  ? "ejvend",
    desktop   ? null, 
    system    ? "x86_64-linux", 
    theme     ? "default",
    type      ? "default",
    repo      ? "nixpkgs",
    deployment_type ? "hosts",
    unfree    ? false
  }: inputs.${repo}.lib.nixosSystem { 
    specialArgs = { 
      inherit inputs outputs desktop hostname username hmStateVersion stateVersion system theme self deployment_type;
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

  # Combines mkHost and mkHome for image building
  mkImage = {
    hostname  , 
    username  ? "ejvend",
    desktop   ? null, 
    system    ? "x86_64-linux",
    theme     ? "default",
    repo      ? "nixpkgs",
    unfree    ? false,
    format
  }: inputs.nixos-generators.nixosGenerate {
    specialArgs = { 
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
      #inputs.sops-nix.nixosModules.sops
      # inputs.lanzaboote.nixosModules.lanzaboote
      inputs.home-manager.nixosModules.home-manager {
        home-manager.extraSpecialArgs  = { inherit inputs outputs desktop hostname username hmStateVersion stateVersion system theme format; };
        home-manager.users."${username}" = import ../home;
      }
    ];
  };

  # Small version
  mkMinImage = {
    hostname  , 
    username  ? "ejvend",
    desktop   ? null, 
    system    ? "x86_64-linux",
    theme     ? "default",
    format
  }: inputs.nixos-generators.nixosGenerate {
    specialArgs = { inherit inputs outputs desktop hostname username stateVersion hmStateVersion system theme format; };
    system = system;
    format = format;

    modules = [
      ../nixos/default.nix
      ../nixos/common/modules/installer.nix
      #inputs.sops-nix.nixosModules.sops
    ];
  };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "x86_64-linux"
  ];
}
