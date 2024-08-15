{
  description = "NixOS Configurations";
  
  inputs = { 
    # Nixpkgs
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
    userSettings = {
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
    forAllSystem = nixpkgs.lib.genAttrs systems;

    system = systemSettings.system;

    pkgs = nixpkgs.legacyPackages.${systemSettings.system};
    stable = nixpkgs.legacyPackages.${systemSettings.system};
    unstable = nixpkgs.legacyPackages.${systemSettings.system};
  in 
  {
    # Function for NixOS system configuration
    #nixosConfigurations = 
    #  let
    #    mkNixosConfiguration = name: system: theme: nixpkgs.lib.nixosSystem {
    #      specialArgs = {
    #        inherit inputs outputs systemSettings userSettings;
    #        #pkgs-unstable = nixpkgs-unstable.legacyPackages.${systemSettings.system};
    #      };
    #      modules = [
    #        ./host + "/${name}" + /configuration.nix
    #      ];
    #    };
    #  in 
    #  {
    #    nixos-lt = mkNixosConfiguration "nixos-lt" "x86_64-linux" "lxqt_bspwm";
    #    nixos-mvm = mkNixosConfiguration "nixos-mvm" "aarch64-linux" "lxqt_bspwm";
    #    nixos-test = mkNixosConfiguration "nixos-test" "aarch64-linux" "xfce_bspwm";
    #  };

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
