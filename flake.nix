{
  description = "NixOS Configurations";
  
  inputs = { # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Home manager
    home-manager.url = "github:nix-community/home-manager";

    home-manager-stable.url = "github:nix-community/home-manager/release-24.05";
    home-manager-unstable.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # NixVIM
    nixvim.url = "github:nix-community/nixvim";

    nixvim-stable.url = "github:nix-community/nixvim/nixos-24.05";
    nixvim-unstable.url = "github:nix-community/nixvim";
    #nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # Spicetify
    #spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    #spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Stylix 
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixpkgs-unstable, home-manager, home-manager-unstable, nixvim, stylix, ... } @ inputs: 
  let
    inherit (self) outputs;

    # ----- SYSTEM SETTINGS ----- #
    systemSettings = {
      system = "x86_64-linux";
      hostname = "nixos-lt";
      build = "lxqt_bspwm";

      #system = "aarch64-linux";
      #hostname = "nixos-mvm";
      #build = "lxqt_bspwm";
      
      #system = "aarch64-linux";
      #hostname = "nixos-test";
      #build = "xfce_bspwm"; 
    };

    # ----- USER SETTINGS ----- #
    userSettings = rec {
      username = "ejvend";
      name = "Ejvend";
      email = "ejvend.nielsen@gmail.com";
      theme = "ia-dark";
      #theme = "helios";
      #theme = "shadesmear-dark";
      #theme = "tomorrow-night";
      #theme = "twilight";
      #theme = "vesper";
      # To view sample themes..  https://tinted-themeing.github.io/base16-gallery
    }; 

    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux" 
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;

    pkgs = nixpkgs.legacyPackages.${systemSettings.system};
    system = systemSettings.system;

    pkgs = import nixpkgs {
      inherit system;
    };
    stable = import nixpkgs {
      inherit system;
    };
    unstable = import nixpkgs {
      inherit system;
    };
  in 
  {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    # Function for NixOS system configuration
    nixosConfigurations = {
      ${systemSettings.hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs systemSettings userSettings;
          #pkgs-unstable = nixpkgs-unstable.legacyPackages.${systemSettings.system};
        };
        modules = [
          ./hosts/${systemSettings.hostname}/configuration.nix
        ];
      };
    };

    # Function for Home-Manager configuration
    homeConfigurations = {
      ${userSettings.username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs systemSettings userSettings;
          #pkgs-unstable = nixpkgs-unstable.legacyPackages.${systemSettings.system};
        };
        modules = [
          ./home/${userSettings.username}/home.nix
          #./home/${userSettings.username}/${systemSettings.hostname}.nix
        ];
      };
    };

    #nixosConfigurations = {
    #  ${systemSettings.hostname} = nixpkgs.lib.nixosSystem {
    #    specialArgs = {inherit inputs outputs systemSettings userSettings;};
    #    modules = [
    #  	   ./hosts/${systemSettings.hostname}/configuration.nix
    #      home-manager.nixosModules.home-manager {
    #        home-manager.useGlobalPkgs=true;
    #        home-manager.useUserPackages = true;
    #        home-manager.users.${userSettings.username} = import ./home/${userSettings.username}/${systemSettings.hostname}.nix;
    #        home-manager.extraSpecialArgs = {inherit inputs outputs systemSettings userSettings;};
    #      }
    #    ];
    #  };
    #};
  };
}
