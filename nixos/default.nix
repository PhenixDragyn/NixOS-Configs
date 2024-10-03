{ inputs, outputs, lib,  pkgs, format, hostname, stateVersion, username, desktop, system, ... }: 

{
  imports = [ 
    # Services
    ../modules/nixos/openssh.nix

    # Scripts
    ../modules/nixos/clean-hm.nix

    # Modules
    ../modules/nixos/nixvim.nix
    #./common/modules/ranger.nix
    ../modules/nixos/yazi.nix
    ../modules/nixos/zsh.nix

    # Stylix (Set in hosts default.nix) 
    # ISO can't have both Hosts and Home defined.
    #inputs.stylix.nixosModules.stylix 
		#../stylix/stylix-nixos.nix

    # Hosts Configurations
    ../hosts/${hostname}

		# User Setup
    ../users/${username}/nixos.nix
  ]
   ++ lib.optional (builtins.isString desktop) ../desktops/${desktop}/nixos.nix
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
      dates = "daily"; 
			options = "--delete-older-than 7d"; 
		}; 
	}; 

  nixpkgs = { # You can add overlays here
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
  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;
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
    viu # Terminal image viewer with native support for iTerm and Kitty

		# yazi
  #   ffmpegthumbnailer
  #   poppler
		# ripgrep
		
    # NIX tools
    nix-prefetch
    nix-prefetch-git
		nvd

    # Network
    curl
    rsync
    wget
    
    # Sound
    alsa-utils

    # networking tools
    mtr # A network diagnostic tool
    dnsutils  # `dig` + `nslookup`
    inetutils
    ldns # replacement of `dig`, it provide the command `drill`
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses
 
    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb   playerctl
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

  system.stateVersion = stateVersion;
}
