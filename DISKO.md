https://nixos.asia/en/nixos-install-disko


scp NixOS from other system

sudo nix \
  --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- \
  --mode disko /tmp/disko-configuration.nix

sudo nixos-generate-config --no-filesystems --root /mnt

edit disko-configuration.nix and configuration.nix

cp disko-configuration.nix and /mnt/etc/nixos/hardware-configuration.nix to NixOS host directory

sudo nix --experimental-features "nix-command flakes" flake lock

sudo nixos-install --root /mnt --flake '.#nixos-mvm'

