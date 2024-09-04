{
  # run sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko disk-config.nix
  device ? throw "Set this to your disk device, e.g. /dev/sda",
  ...
}: {
  disko.devices = {
    disk.main = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "NIXBOOT";
            size = "500M";
            type = "EF00";
            content = {
              type = "filessystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };

          swap = {
            size = "16G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };

          root = {
            name = "NIXROOT";
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };

        };
      };
    };
  };
}

