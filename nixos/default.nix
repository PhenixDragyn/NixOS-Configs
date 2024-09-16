{ inputs, outputs, lib,  pkgs, format, hostname, stateVersion, username, desktop, system, ... }: 

{
  imports = [ 
    # Services
    ./common/services/openssh.nix

    # Scripts
    ./common/modules/clean-hm.nix

    # Modules
    ./common/modules/nixvim.nix
    ./common/modules/ranger.nix
    ./common/modules/zsh.nix

    # Stylix (Set in hosts default.nix) 
    # ISO can't have both Hosts and Home defined.
    #inputs.stylix.nixosModules.stylix 
		#../stylix/stylix.nix

    # NixOS and Home
    ./hosts/${hostname}
    ./users/${username}
  ]
   ++ lib.optional (builtins.isString desktop) ./common/desktops/${desktop}
   ++ (if ( format != "iso")
       then [ 
         inputs.stylix.nixosModules.stylix
         ../stylix/stylix.nix
       ]
       else []);

  # ---------------------------------

  # NIX SETTINGS
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command"  "flakes" ];
    };

    optimise = {
      automatic = true;
      dates = [ "daily" ];
    };

    gc = {
      automatic = true;
      dates = "daily"; options = "--delete-older-than 7d";
    };
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      
      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
  };

  # ---------------------------------
  # NETWORKING
  networking = {
    hostName = hostname;

    #wireless.enable = true;
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  # Enable network manager applet
  #programs.nm-applet.enable = true;

  # Fixes an issue of the service failing and hanging.
  #systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.NetworkManager-wait-online = {
    serviceConfig = {
      ExecStart = [ "" "${pkgs.networkmanager}/bin/nm-online -q" ];
    };
  };

  # ---------------------------------

  # FIREWALL
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  # ---------------------------------

  # PRINTING SERVICES
  #services.printing = {
  #  enable = true;
  #  drivers = with pkgs; [ brlaser ];
  #};
  #environment.systemPackages = with pkgs; [ cups-filters ];
  services.printing.enable = false;

  # Use Avahi to setup Network/Printing Discovery
  services.avahi = {
    publish.enable = true;
    publish.userServices = true;
    nssmdns4 = true;
    enable = true;
    openFirewall = true;
  };

  # ---------------------------------

  # BLUETOOTH
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Enable blueman applet
  #services.blueman.enable = true;

  # ---------------------------------

  # SOUND SETTINGS
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  # ---------------------------------

  # VIDEO
  hardware.opengl = {
    enable = true;
    #driSupport = true;
    driSupport32Bit = true;

    extraPackages = with pkgs; [
      intel-media-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # ---------------------------------

  # TIMEZONE AND LOCALE
  time.timeZone = "America/Boise";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # ---------------------------------

  # DEVICE MANAGEMENT SETTINGS
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # ---------------------------------

  # LOCATE SETTINGS
  services.locate = {
    enable = true;
    localuser = null;
  };

  # ---------------------------------

  # SUDO SETTINGS
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # ---------------------------------

  # PATH CONFIGURATION
  environment.localBinInPath = true;

  # ---------------------------------

  # SYSTEM PACKAGES 
  environment.systemPackages = with pkgs; [
    # Cli
    bat
    bc
    btop
    fastfetch
    fzf
    lsd
    killall
		git
		neovim
    #neofetch
    procps
    psmisc

    # NIX tools
    nix-prefetch
    nix-prefetch-git
		nvd

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

  # ---------------------------------
  
  # AUTO UPGRADE
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--impure"

      "--commit-lock-file"
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    #dates = "05:00";
    #randomizedDelaySec = "30min";
  };

  # ---------------------------------

  #nixpkgs.hostPlatform = system;

  system.stateVersion = stateVersion;
}
