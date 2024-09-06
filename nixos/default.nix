{ inputs, lib,  pkgs, hostname, stateVersion, username, desktop, system, ... }: {
  imports = [ 
    # Services
    ./common/services/openssh.nix

    # Software
    #../../packages/clean-hm/clean-hm.nix
    ./common/software/cli/clean-hm.nix

    # Modules
    ./common/modules/networking.nix        # Initial Networking/Bluetooth configs
    ./common/modules/system.nix            # System and NixOS related items

    ./common/modules/nixvim.nix
    ./common/modules/ranger.nix
    ./common/modules/zsh.nix

    # Stylix
    #inputs.stylix.nixosModules.stylix
    #../stylix/stylix.nix

    # NixOS and Home
    ./hosts/${hostname}
    ./users/${username}
  ] ++ lib.optional (builtins.isString desktop) ./common/desktops/${desktop};

  programs.zsh.enable = true;

  # ---------------------------------

  # PATH CONFIGURATION
  environment.localBinInPath = true;

  # ---------------------------------

  # SYSTEM PACKAGES 
  environment.systemPackages = with pkgs; [
    # Home-manager
    #home-manager
  
    # Cli
    bat
    bc
    btop
    fzf
    lsd
    killall
    neofetch
    procps
    psmisc

    # NIX tools
    nix-prefetch
    nix-prefetch-git

    # Network
    curl
    inetutils
    rsync
    wget
    
    # Sound
    alsa-utils
    playerctl
  ] ++ (if ( system == "x86_64-linux")
	        then []
				else 
			  (if ( system == "aarch64-linux" )
			    then [] 
				else []));

}
