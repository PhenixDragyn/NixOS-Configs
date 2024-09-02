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

    # Hardware
    #hardware.url = "github:nixos/nixos-hardware";

    # Stylix 
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixpkgs-unstable, home-manager, home-manager-unstable, nixvim, stylix, ... } @ inputs: 
  let
    inherit (self) outputs;
    
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.05";

    #system = "$(uname -m)-$(uname -s)";
    #system = builtins.currentSystem;
    #host = "$(hostname -f)";
    #user = "$(echo $USER)";
    #test = nixpkgs.runCommand "example-name" {} "echo Test > $out";

    # host = osConfig.networking.hostname;

    # ----- BUILD SYSTEM/USER SETTINGS ----- #
    buildSettings = {
      username = "ejvend";
      hostname = "nixos-lt";
      platform = "x86_64-linux";
      build = "lxqt_bspwm";
      theme = "ia-dark";
    };

    #buildSettings = {
    #  username = "ejvend";
    #  hostname = "nixos-mvm";
    #  platform = "aarch64-linux";
    #  build = "lxqt_bspwm";
    #  theme = "ia-dark";
    #};

    #buildSettings = {
    #  username = "ejvend";
    #  hostname = "nixos-test";
    #  platform = "aarch64-linux";
    #  build = "xfce_bspwm";
    #  theme = "ia-dark";
    #};
    
    #buildSettings = {
    #  username = "ejvend";
    #  hostname = "nixos-vm";
    #  platform = "x86_64-linux";
    #  build = "xfce_bspwm";
    #  theme = "ia-dark";
    #};

    # ----- OTHER SETTINGS ----- #
    # Supported systems for your flake packages, shell, etc.
     systems = [
       "aarch64-linux" 
       "i686-linux"
       "x86_64-linux"
       "aarch64-darwin"
       "x86_64-darwin"
     ];
     # This is a function that generates an attribute by calling a function you
     # pass to it, with each system as an arguement
     forAllSystems = nixpkgs.lib.genAttrs systems;

     pkgs = nixpkgs.legacyPackages.${buildSettings.platform};
     stable = nixpkgs.legacyPackages.${buildSettings.platform};
     #unstable = nixpkgs.legacyPackages.${buildSettings.platform};
  in 
  {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./packages { inherit pkgs; });
    #packages = import ./packages { inherit pkgs; };

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    #formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  
    # Function for NixOS system configuration
     nixosConfigurations = {
       ${buildSettings.hostname} = nixpkgs.lib.nixosSystem {
         specialArgs = {
           inherit inputs outputs stable buildSettings stateVersion; 
           #pkgs-unstable = nixpkgs-unstable.legacyPackages.${buildSettings.system};
         };
         modules = [
           ./hosts/${buildSettings.hostname}/configuration.nix
         ];
       };
     };

    # Function for Home-Manager configuration
     homeConfigurations = {
       ${buildSettings.username} = home-manager.lib.homeManagerConfiguration {
         inherit pkgs;
         extraSpecialArgs = {
           inherit inputs outputs stable buildSettings stateVersion;
           #pkgs-unstable = nixpkgs-unstable.legacyPackages.${buildSettings.system};
         };
         modules = [
           ./home/${buildSettings.username}/home.nix
           #./home/${buildSettings.username}/${buildSettings.hostname}.nix
         ];
       };
     };

    # Function for NixOS VM system configuration
     nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
     #nixosConfigurations.vm = {
     #  ${buildSettings.hostname} = nixpkgs.lib.nixosSystem {
         specialArgs = {
           inherit inputs outputs buildSettings stateVersion; 
         };
         modules = [
           ./hosts/${buildSettings.hostname}/configuration.nix
           home-manager.nixosModules.home-manager {
             home-manager.useGlobalPkgs=true;
             home-manager.useUserPackages = true;
             home-manager.users.${buildSettings.username} = import ./home/${buildSettings.username}/home.nix;
             home-manager.extraSpecialArgs = {inherit inputs outputs buildSettings;};
           }
         ];
      # };
     };

    #nixosConfigurations = {
    #  ${systemSettings.hostname} = nixpkgs.lib.nixosSystem {
    #    specialArgs = {inherit inputs outputs buildSettings;};
    #    modules = [
    #  	   ./hosts/${buildSettings.hostname}/configuration.nix
    #      home-manager.nixosModules.home-manager {
    #        home-manager.useGlobalPkgs=true;
    #        home-manager.useUserPackages = true;
    #        home-manager.users.${buildSettings.username} = import ./home/${buildSettings.username}/${buildSettings.hostname}.nix;
    #        home-manager.extraSpecialArgs = {inherit inputs outputs buildSettings;};
    #      }
    #    ];
    #  };
    #};
  };
}
