{
  description = "NixOS System Config";

  inputs = {
    # Stable Packages
    nixpkgs.url = "nixpkgs/nixos-24.05";

    # Unstable Packages
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    # home-manager - Dotfile mnagement - add /master at the end to pull from master 
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # disko - Declarative Disk Partitioning
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # nixos-hardware - Hardware Configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # sops-nix - Secret Management with SOPS using GPG Keys
    #sops-nix.url = "github:Mic92/sops-nix";

    # nixvim - neovim configuration management in nix
    nixvim.url = "github:nix-community/nixvim/nixos-24.05";

		# Yazi plugins
		# nix-yazi-plugins.url = "github:lordkekz/nix-yazi-plugins?ref=yazi-v0.2.5";
		# nix-yazi-plugins.inputs.nixpkgs.follows = "nixpkgs";
		
    # Nix colorizer / themer 
    stylix.url = "github:danth/stylix/release-24.05";
    #stylix.url = "github:danth/stylix";

    # nixos-generators - Automated Image / ISO Creation
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, sops-nix, ... } @inputs:
  let
    inherit (self) outputs;

    stateVersion = "24.05";
    hmStateVersion = "24.05";

    libx = import ./lib/default.nix { inherit self inputs outputs stateVersion hmStateVersion; };
  in 
  {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = libx.forAllSystems ( system: import ./packages nixpkgs.legacyPackages.${system} );

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays { inherit inputs; };

    # Function for NixOS system configuration
    nixosConfigurations = {
      nixos-dt = libx.mkNixOS { hostname = "nixos-dt"; username = "ejvend"; system = "x86_64-linux"; desktop = "hypr"; type = "default"; theme = "ia-dark"; unfree = true; };
      nixos-lt = libx.mkNixOS { hostname = "nixos-lt"; username = "ejvend"; system = "x86_64-linux"; desktop = "hypr"; type = "default"; theme = "classic-dark"; unfree = true; };
      nixos-mvm = libx.mkNixOS { hostname = "nixos-mvm"; username = "ejvend"; system = "aarch64-linux"; desktop = "xfce_bspwm"; type = "default"; theme = "ia-dark"; };
    };

    # Function for Home-Manager configuration
    homeConfigurations = {
      "ejvend@nixos-dt" = libx.mkHome { hostname = "nixos-lt"; username = "ejvend"; system = "x86_64-linux"; desktop = "hypr"; type = "default"; theme = "ia-dark"; };
      "ejvend@nixos-lt" = libx.mkHome { hostname = "nixos-lt"; username = "ejvend"; system = "x86_64-linux"; desktop = "hypr"; type = "default"; theme = "classic-dark"; };
      "ejvend@nixos-mvm" = libx.mkHome { hostname = "nixos-mvm"; username = "ejvend"; system = "aarch64-linux"; desktop = "xfce_bspwm"; type = "default"; theme = "ia-dark"; };
    };

    # Funtion for System configuration
		systemConfigurations = {
      nixos-lt = libx.mkSystem { hostname = "nixos-lt"; username = "ejvend"; system = "x86_64-linux"; desktop = "hypr"; type = "default"; theme = "classic-dark"; unfree = true; };
		};

    # Function for Image configuration
    # nix build .#imageConfigurations.nixos-iso
    imageConfigurations = {
      nixos-iso = libx.mkImage { hostname = "nixos-iso"; username = "nixos"; system = "x86_64-linux"; theme = "ia-dark"; format = "iso"; };
      nixos-iso2 = libx.mkImage { hostname = "nixos-iso"; username = "nixos"; system = "x86_64-linux"; theme = "ia-dark"; desktop = "hypr"; format = "iso"; unfree = true; };
    };

    # Devshell for bootstrapping; acessible via 'nix develop'
    devShells = libx.forAllSystems (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in import ./shell.nix { inherit pkgs system; }
      #in import ./shell.nix { inherit pkgs sops-nix deploy-rs system; }
    );
  };
}
