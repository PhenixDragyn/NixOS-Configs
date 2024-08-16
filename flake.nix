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
    
    stateVersion = "24.05";
    #helper = import ./lib/helpers.nix { inherit inputs outputs stateVersion mkHome mkNixos forAllSystems; };
    helper = import ./lib { inherit inputs outputs stateVersion; };

    #options.variables = {
    #  username = nixpkgs.lib.mkOption {
    #    type = nixpkgs.lib.types.str;
    #    default = "";
    #    example = "johndoe";
    #    description = ''
    #      Keeps track of the name of your user, useful for looking up the username for other settings in the flake.
    #    '';
    #  };
    #};

    # ----- SYSTEM SETTINGS ----- #
    # systemSettings = {
    #   system = "x86_64-linux";
    #   hostname = "nixos-lt";
    #   build = "lxqt_bspwm";
    #
    #   #system = "aarch64-linux";
    #   #hostname = "nixos-mvm";
    #   #build = "lxqt_bspwm";
    #   
    #   #system = "aarch64-linux";
    #   #hostname = "nixos-test";
    #   #build = "xfce_bspwm"; 
    # };
    #
    # ----- USER SETTINGS ----- #
    # userSettings = {
    #   username = "ejvend";
    #   name = "Ejvend";
    #   email = "ejvend.nielsen@gmail.com";
    #   theme = "ia-dark";
    #   #theme = "helios";
    #   #theme = "shadesmear-dark";
    #   #theme = "tomorrow-night";
    #   #theme = "twilight";
    #   #theme = "vesper";
    #   # To view sample themes..  https://tinted-themeing.github.io/base16-gallery
    # }; 

    # Supported systems for your flake packages, shell, etc.
    # systems = [
    #   "aarch64-linux" 
    #   "i686-linux"
    #   "x86_64-linux"
    #   "aarch64-darwin"
    #   "x86_64-darwin"
    # ];
    # forAllSystem = nixpkgs.lib.genAttrs systems;
    #
    # system = systemSettings.system;
    #
    # pkgs = nixpkgs.legacyPackages.${systemSettings.system};
    # stable = nixpkgs.legacyPackages.${systemSettings.system};
    # unstable = nixpkgs.legacyPackages.${systemSettings.system};
  in 
  {
    # Home-Manager Configurations
    # home-manager switch -b backup --flake .
    # nix-run nixpkgs#home-manager -- switch -b backup --flake .
    homeConfigurations = {
      "ejvend@nixos-lt" = helper.mkHome {
         username = "ejvend";
         hostname = "nixos-lt";
      };
      "ejvend@nixos-mvm" = helper.mkHome {
         username = "ejvend";
         hostname = "nixos-mvm";
      };
    };

    # NixOS Configurations
    # - sudo nixos-rebuild boot --flake .
    # - sudo nixos-rebuild switch --flake .
    # - nix-build .#nixosConfigurations.{hostname}.config.system.build.toplevel
    nixosConfigurations = {
      nixos-lt = helper.mkNixos {
        hostname = "nixos-lt";
        platform = "x86_64-linux";
        build = "lxqt_bspwm";
        theme ="ia-dark";
      };
      nixos-mvm = helper.mkNixos {
        hostname = "nixos-mvm";
        platform = "aarch64-linux";
        build = "lxqt_bspwm";
        theme = "ia-dark";
      };
    };

    # Function for NixOS system configuration
    # nixosConfigurations = {
    #   ${systemSettings.hostname} = nixpkgs.lib.nixosSystem {
    #     specialArgs = {
    #       inherit inputs outputs systemSettings userSettings;
    #       #pkgs-unstable = nixpkgs-unstable.legacyPackages.${systemSettings.system};
    #     };
    #     modules = [
    #       ./hosts/${systemSettings.hostname}/configuration.nix
    #     ];
    #   };
    # };

    # Function for Home-Manager configuration
    # homeConfigurations = {
    #   ${userSettings.username} = home-manager.lib.homeManagerConfiguration {
    #     inherit pkgs;
    #     extraSpecialArgs = {
    #       inherit inputs outputs systemSettings userSettings;
    #       #pkgs-unstable = nixpkgs-unstable.legacyPackages.${systemSettings.system};
    #     };
    #     modules = [
    #       ./home/${userSettings.username}/home.nix
    #       #./home/${userSettings.username}/${systemSettings.hostname}.nix
    #     ];
    #   };
    # };

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
