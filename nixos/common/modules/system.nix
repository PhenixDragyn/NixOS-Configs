{ inputs, pkgs, system, stateVersion, ... }: 

{ 
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

  # https://github.com/NixOS/nixpkgs/issues/180175#issuecomment-1658731959
  # systemd.services.NetworkManager-wait-online = {
  #   serviceConfig = {
  #     ExecStart = [ "" "${pkgs.networkmanager}/bin/nm-online -q" ];
  #   };
  # };

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