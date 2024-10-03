# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs, lib, pkgs, username, settings, ... }:

{
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos): outputs.nixosModules.example
    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd
		inputs.nixos-hardware.nixosModules.dell-latitude-7430

    # Disk configurations
    inputs.disko.nixosModules.disko
    ./disk-configuration.nix 

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # Services
    ../../modules/nixos/samba.nix
    ../../modules/nixos/syncthing.nix

    # Stylix
    #inputs.stylix.nixosModules.stylix
    #../../../stylix/stylix.nix
  ];

  # ---------------------------------
  
  # CONSOLE
  console = {
    font = "ter-132n";
    packages = [pkgs.terminus_font];
    useXkbConfig = true;
    earlySetup = false;
  };

  # BOOT SETTINGS
  boot = {
    #kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 0;
    kernelParams = ["quiet" "splash"];
 
    # Ignored by tlp
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
        configurationLimit = 10;
      };
    };
  };

  # ---------------------------------

  # SYSTEM PACKAGES 
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_6_6.ipu6-drivers
   	linuxKernel.packages.linux_6_6.ivsc-driver
   	ipu6-camera-hal
		ipu6-camera-bins
		v4l-utils
  ];
	
  # HARDWARE - WEBCAM
  hardware.ipu6 = {
    enable = true;
   	platform = "ipu6ep";
  	#platform = "ipu6epmtl";
 };

	# TLP SETTINGS
  services.tlp.settings = {
    SOUND_POWER_SAVE_ON_AC=0;
		SOUND_POWER_SAVE_ON_BAT=0;
		SOUND_POWER_SAVE_CONTROLLER="N";
	};

  # Load also non-free firmwares in the kernel
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  hardware.firmware = with pkgs; [
    ivsc-firmware
  ];

  # These rules must be understood like a script executed sequentially for
  # all devices. Instead of creating conditions, they use the old fashion
  # goto mechanism to skip some rules tu apply using goto and label
  # The first parts of each line is like a conditiong and the second part
  # describes what to run in that case.
  # To see the properties of a device, just run something like
  # udevadm info -q all -a /dev/video9
  services.udev.extraRules = ''
    SUBSYSTEM!="video4linux", GOTO="hide_cam_end"
    #ATTR{name}=="Intel MIPI Camera", GOTO="hide_cam_end"
    ATTR{name}!="Dummy video device (0x0000)", GOTO="hide_cam_end"
    ACTION=="add", RUN+="${pkgs.coreutils}/bin/mkdir -p /dev/not-for-user"
    ACTION=="add", RUN+="${pkgs.coreutils}/bin/mv -f $env{DEVNAME} /dev/not-for-user/"
    # Since we skip these rules for the mipi, we do not need to link it back to /dev
    # ACTION=="add", ATTR{name}!="Intel MIPI Camera", RUN+="${pkgs.coreutils}/bin/ln -fs $name /dev/not-for-user/$env{ID_SERIAL}"

    ACTION=="remove", RUN+="${pkgs.coreutils}/bin/rm -f /dev/not-for-user/$name"
    ACTION=="remove", RUN+="${pkgs.coreutils}/bin/rm -f /dev/not-for-user/$env{ID_SERIAL}"

    LABEL="hide_cam_end"
  '';

  # Tailscale "aardwolf-alnilam.ts.net"
  # https://login.tailscale.com/admin/
  # Connect machine to Tailscale network.. 
  # > sudo tailscale up
  # > tailscale ip -4
  # services.tailscale.enable = true;
  # #services.tailscale.useRoutingFeatures = "both";
  # networking.nameservers = [ "100.100.100.100" "8.8.8.8" "1.1.1.1" ];
  # networking.search = [ "aardwolf-alnilam.ts.net" ];
  # networking.firewall.trustedInterfaces = [ "tailscale0" ];
  # };
}
