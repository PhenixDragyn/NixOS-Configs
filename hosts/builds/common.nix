{ inputs, outputs, lib, config, pkgs, stable, unstable, userSettings, systemSettings, ... }: 

{
  # You can import other NixOS modules here
  imports = [
    # Import my host modules
    ../modules/ranger.nix
    ../modules/samba.nix
    ../modules/syncthing.nix
  ];
  
  # NIX SETTINGS
  # Nixpkgs configuration
  nixpkgs.config.allowUnfree = true;

  # Register flake inputs for nix commands
  nix.registry = lib.mapAttrs (_: flake: {inherit flake;}) (lib.filterAttrs (_: lib.isType "flake") inputs);

  # Add inputs to legacy channels
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs' (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  # Nix settings
  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  # BOOT SETTINGS
  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 0;
    kernelParams = ["quiet" "splash"];
    extraModprobeConfig = ''
      options snd-hda-intel power_save=0 power_save_controller=N
    '';

    initrd.verbose = false;
    
    loader = {
      efi.canTouchEfiVariables = true;
      #systemd-boot.enable = true;
      #timeout = 0;

      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        #configurationLimit = 10;
      };
    };
  };

  # NETWORKING
  networking = {
    hostName = systemSettings.hostname;

    #wireless.enable = true;
    networkmanager.enable = true;
    enableIPv6 = false;
  };
  networking.firewall.enable = false;
  networking.firewall.allowPing = true;
 
  # Enable network manager applet
  #programs.nm-applet.enable = true;

  # Enable Avahi for Network/Printing discovery
  #services.avahi.enable = true;
  #services.avahi.nssmdns4 = true;
  services.avahi = {
    publish.enable = true;
    publish.userServices = true;
    nssmdns4 = true;
    enable = true;
    openFirewall = true;
  };

  # BLUETOOTH
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

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

  # DEVICE MANAGEMENT SETTINGS
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # PRINTING SERVICES
  #services.printing = {
  #  enable = true;
  #  drivers = with pkgs; [ brlaser ];
  #};
  #environment.systemPackages = with pkgs; [ cups-filters ];
  services.printing.enable = false;
  
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

  # SSH SERVER
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      X11Forwarding = true;
    };
    openFirewall = true;
  };    

  programs.ssh.startAgent = true;
  programs.ssh.extraConfig = ''
      AddKeysToAgent yes
      Compression yes
      ServerAliveInterval 5
      ServerAliveCountMax 3
      SetEnv TERM=xterm-256color
    '';

  # X2GO SERVER AND XRDP
  #services.x2goserver.enable = true;
  #services.xrdp.enable = true;
  #services.xrdp.defaultWindowManager = "startlxqt";
  #services.xrdp.openFirewall = true;

  # SUDO SETTINGS
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # USER ACCOUNT
  users.users = {
    ${userSettings.username} = {
      description = userSettings.name;
      isNormalUser = true;
      initialPassword = "NixOS!";
      #hashedPassword = "";
      extraGroups = ["wheel" "networkmanager" "power" "audio" "video" "storage"];

      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
    };

    root = {
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
    };
  };
  users.defaultUserShell = pkgs.zsh;

  # USER SYMLINKS
  #system.userActivationScripts.linktosharedfolder.text = ''
  #  if [[ ! -h "${config.home.homeDirectory}/Sync/test.txt" ]]; then
  #    ln -s "${config.home.homeDirectory}/Sync/test.txt" "${config.home.homeDirectory}/.config/"
  #  fi
  #'';

  # PATH CONFIGURATION
  environment.localBinInPath = true;

  # SYSTEM PACKAGES 
  environment.systemPackages = with pkgs; [
    alsa-utils
    arandr
    #autorandr
    bc
    blueman
    curl
    home-manager
    inetutils
    killall
    nix-zsh-completions
    #pipewire
    playerctl
    procps
    ranger
    #pulseaudio
    wget
    zsh-completions
    zsh-history-substring-search
    zsh-syntax-highlighting
    

    #(python3Full.withPackages(ps: with ps; [ requests ]))
  ] ++ (if (systemSettings.system == "x86_64-linux")
	        then []
				else 
			  (if (systemSettings.system == "aarch64-linux" )
			    then [] 
				else []));

  # LOCATE SETTINGS
  services.locate = {
    enable = true;
    localuser = null;
  };

  # ZSH SETTINGS
  environment.shells = with pkgs; [ zsh ];
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    zsh-autoenv.enable = true;
    syntaxHighlighting.enable = true;
    
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      #theme = "robbyrussell";
      plugins = [ "git" "python" "sudo" "history" ];
    }; 

    shellAliases = {
    };

    interactiveShellInit = ''
      #source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
  };

  # EDITOR
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    
    viAlias = true;
    vimAlias = true;
  };
  
  # STYLIX
  stylix = {
    enable = true;
    autoEnable = true;

    base16Scheme = ./. + "/../../themes"+("/"+userSettings.theme)+".yaml";
    image = ../../files/wallpaper/NixOS-Nineish-Dark.png;
  };

  #environment.etc."current-system-packages".text =
  #  let
  #    packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
  #    sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
  #    formatted = builtins.concatStringsSep "\n" sortedUnique;
  #  in
  #    formatted;

  #system.stateVersion = "24.05";
}
