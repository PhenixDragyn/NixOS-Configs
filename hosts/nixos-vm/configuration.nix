# Build this VM with nix build  ./#nixosConfigurations.vm.config.system.build.vm
# Then run is with: ./result/bin/run-nixos-vm
# To be able to connect with ssh enable port forwarding with:
# QEMU_NET_OPTS="hostfwd=tcp::2222-:22" ./result/bin/run-nixos-vm
# Then connect with ssh -p 2222 guest@localhost

# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs, outputs, lib, config, pkgs, stable, unstable, buildSettings, stateVersion, ... }:

{
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos): outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd
    inputs.nixvim.nixosModules.nixvim
    inputs.stylix.nixosModules.stylix

    # Import my host modules
    ../modules/nixvim.nix
    ../modules/openssh.nix
    #../modules/ranger.nix
    #../modules/samba.nix
    #../modules/syncthing.nix
    ../modules/zsh.nix

  ] ++ (if (buildSettings.build == "xfce_bspwm")
	        then [ ../builds/desktop-xfce_bspwm.nix ]
				else 
			  (if (buildSettings.build == "lxqt_bspwm" )
			    then [ ../builds/desktop-lxqt_bspwm.nix ] 
				else 
			  (if (buildSettings.build == "bspwm_gtk" )
			    then [ ../builds/desktop-bspwm_gtk.nix ] 
				else [])));

  # ---------------------------------
  
  # NIX SETTINGS
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Nixpkgs configuration
  nixpkgs.config.allowUnfree = true;

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

  nix = {
    # Register flake inputs for nix commands
    registry = lib.mapAttrs (_: flake: {inherit flake;}) (lib.filterAttrs (_: lib.isType "flake") inputs);

    # Add inputs to legacy channels 
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    #nixPath = ["/etc/nix/path"];
   
    # Nix settings
    settings = {
      trusted-users = [ "root" buildSettings.username ];
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      # warn-dirty = false;
    };
  };

  #environment.etc =
  #  lib.mapAttrs' (name: value: {
  #    name = "nix/path/${name}";
  #    value.source = value.flake;
  #  })
  #  config.nix.registry;

  # ---------------------------------

  # VIRTUALIZATION

  virtualisation.vmVariant = {
    virtualisation.resolution = {
      x = 1280;
      y = 1024;
    };
    virtualisation.qemu.options = [
      # Better Display Option
      "-vga virtio"
      "-display gtk,zoom-to-fit=false"
      # Enable Copy/Paste
      "-chardev qemu-vdagent,id=ch1,name=vdagent,clipboard=on"
      "-device virtio-serial-pci"
      "-device virtserialport,chardev=ch1,id=ch1,name=com.redhat.spice.0"
    ];

  };

  # BOOT SETTINGS
  # boot = {
  #   # kernelPackages = pkgs.linuxPackages_latest;
  #   consoleLogLevel = 0;
  #   kernelParams = ["quiet" "splash"];
  #   extraModprobeConfig = ''
  #     options snd-hda-intel power_save=0 power_save_controller=N
  #   '';
  #
  #   initrd.verbose = false;
  #   
  #   loader = {
  #     efi.canTouchEfiVariables = true;
  #     #systemd-boot.enable = true;
  #     #timeout = 0;
  #
  #     grub = {
  #       enable = true;
  #       devices = [ "nodev" ];
  #       efiSupport = true;
  #       useOSProber = true;
  #       #configurationLimit = 10;
  #     };
  #   };
  # };
  
  # ---------------------------------

  # NETWORKING
  # networking = {
  #   hostName = buildSettings.hostname;
  #
  #   #wireless.enable = true;
  #   networkmanager.enable = true;
  #   enableIPv6 = false;
  # };

  # Fixes an issue of the service failing and hanging.
  #systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  # systemd.services.NetworkManager-wait-online = {
  #   serviceConfig = {
  #     ExecStart = [ "" "${pkgs.networkmanager}/bin/nm-online -q" ];
  #   };
  # };

  # Tailscale "aardwolf-alnilam.ts.net"
  # https://login.tailscale.com/admin/
  # Connect machine to Tailscale network.. 
  # > sudo tailscale up
  # > tailscale ip -4
  #services.tailscale.enable = true;
  ##services.tailscale.useRoutingFeatures = "both";
  #networking.nameservers = [ "100.100.100.100" "8.8.8.8" "1.1.1.1" ];
  #networking.search = [ "aardwolf-alnilam.ts.net" ];
  #networking.firewall.trustedInterfaces = [ "tailscale0" ];

  # Firewall 
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
 
  # Enable network manager applet
  #programs.nm-applet.enable = true;

  # Enable Avahi for Network/Printing discovery
  # services.avahi = {
  #   publish.enable = true;
  #   publish.userServices = true;
  #   nssmdns4 = true;
  #   enable = true;
  #   openFirewall = true;
  # };

  # ---------------------------------

  # BLUETOOTH
   hardware.bluetooth = {
     enable = true;
     powerOnBoot = true;
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

  # INPUT SETTINGS
 # services.libinput = {
 #   enable = true;
 #   touchpad = {
 #     naturalScrolling = true; # default = false
 #     disableWhileTyping = false; # default = false
 #   };
 #   mouse = {
 #     naturalScrolling = true;
 #   };
 # };

  # ---------------------------------

  # DEVICE MANAGEMENT SETTINGS
  # services.devmon.enable = true;
  # services.gvfs.enable = true;
  # services.udisks2.enable = true;
  
  # ---------------------------------

  # PRINTING SERVICES
  #services.printing = {
  #  enable = true;
  #  drivers = with pkgs; [ brlaser ];
  #};
  #environment.systemPackages = with pkgs; [ cups-filters ];
  services.printing.enable = false;
  
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

  # USER ACCOUNT
  users.users = {
    ${buildSettings.username} = {
      description = buildSettings.username;
      isNormalUser = true;
      initialPassword = "NixOS!";
      #hashedPassword = "$y$j9T$qvaFY9a2zKb.neYDRVK1T0$OGDq0giayeMd6Q3L1Jwz8gPaQ.Ssj4i8za.moPT19DC";
      extraGroups = ["wheel" "networkmanager" "power" "audio" "video" "storage"];

      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
    };

    # root = {
    #   hashedPassword = "$y$j9T$qRgWUxVlS/c8UdYtFqQhu/$lANxdQmqxvVe7YTniG07mld5g/mCPypXueRWH/fC7E2";
    #   openssh.authorizedKeys.keys = [
    #     # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
    #   ];
    # };
  };
  users.defaultUserShell = pkgs.zsh;

  # ---------------------------------

  # USER SYMLINKS
  #system.userActivationScripts.linktosharedfolder.text = ''
  #  if [[ ! -h "${config.home.homeDirectory}/Sync/test.txt" ]]; then
  #    ln -s "${config.home.homeDirectory}/Sync/test.txt" "${config.home.homeDirectory}/.config/"
  #  fi
  #'';

  # ---------------------------------

  # SERVICES 
  services.spice-vdagentd.enable = true;

  #services.xserver.displayManager.autologin.user = "ejvend";
  services.xserver.videoDrivers = [ "qxl" ];

  # ---------------------------------

  # PATH CONFIGURATION
  environment.localBinInPath = true;

  # ---------------------------------

  # SYSTEM PACKAGES 
  environment.systemPackages = with pkgs; [
  
    # Home-manager
    home-manager
  
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

    # Development
    (python3Full.withPackages(ps: with ps; [ requests ]))

  ] ++ (if (buildSettings.platform == "x86_64-linux")
	        then []
				else 
			  (if (buildSettings.platform == "aarch64-linux" )
			    then [] 
				else []));

  # ---------------------------------

  # STYLIX
  stylix = {
    enable = true;
    autoEnable = true;

    base16Scheme = ./. + "/../../themes"+("/"+buildSettings.theme)+".yaml";
    image = ../../files/wallpaper/NixOS-Nineish-Dark.png;
  };

  #networking.hostName = "nixos-lt";
  # nix.gc = {
  #   automatic = true;
  #   dates = "weekly";
  #   options = "--delete-older-than 7d";
  # };
  #
  # system.autoUpgrade = {
  #   enable = true;
  #   flake = inputs.self.outPath;
  #   flags = [
  #     "--impure"
  #
  #     "--commit-lock-file"
  #     "--update-input"
  #     "nixpkgs"
  #     "-L" # print build logs
  #   ];
  #   #dates = "05:00";
  #   #randomizedDelaySec = "30min";
  # };

  system.stateVersion = stateVersion;
}