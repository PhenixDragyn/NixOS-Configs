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

    # Disk configurations
    inputs.disko.nixosModules.disko
    ./disk-configuration.nix 

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # Services
    ../../common/services/samba.nix
    ../../common/services/syncthing.nix

    # Modules
    ../../common/modules/autorandr.nix

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
    # kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 0;
    kernelParams = ["quiet" "splash"];
    kernelModules = [ "bcm2835-v4l2" ];
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
