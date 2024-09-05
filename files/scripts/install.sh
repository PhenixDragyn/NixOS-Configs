#!/usr/bin/env bash

#set -euo pipefail

TARGET_HOST="${1:-}"
TARGET_USER="${2:-ejvend}"

if [ "$(id -u)" -eq 0 ]; then
  echo "ERROR! $(basename "$0") should be run as a regular user"
  exit 1
fi

#read -p "Include wallpapers? [y/N]" -n 1 -r
#echo ""

#if [[ $REPLY =~ ^[Yy]$ ]]; then
#  if [ ! -d "/tmp/nixos/git/.git" ]; then
#    git clone --recursive https://github.com/PhenixDragyn/NixOS "/tmp/nixos/git"
#  else
#    git -C "/tmp/nixos/git" pull
#  fi
#else 
#  if [ ! -d "/tmp/nixos/git/.git" ]; then
#    git clone https://github.com/PhenixDragyn/NixOS "/tmp/nixos/git"
#  else
#    git -C "/tmp/nixos/git" pull
#  fi
#fi

#pushd /tmp/nixos/git

if [[ -z "$TARGET_HOST" ]]; then
  echo "ERROR! $(basename "$0") requires a hostname as the first argument"
  echo "       The following hosts are available"
  ls -1 nixos/hosts/*/default.nix | cut -d'/' -f3 | grep -v -E "iso|rpi"
  exit 1
fi

if [[ -z "$TARGET_USER" ]]; then
  echo "ERROR! $(basename "$0") requires a username as the second argument"
  echo "       The following users are available"
  ls -1 nixos/users/ | grep -v -E "nixos|root"
  exit 1
fi

if [ ! -e "nixos/hosts/$TARGET_HOST/disk-configuration.nix" ]; then
  echo "ERROR! $(basename "$0") could not find the required nixos/$TARGET_HOST/disk-configuration.nix"
  exit 1
fi

# Create a key for encrypted swap, if needed
sudo mkdir -p /mnt-root/etc/
sudo chmod 777 -R /mnt-root
echo "$(head -c32 /dev/random | base64)" > /mnt-root/etc/swap.key

echo "WARNING! The disks in $TARGET_HOST are about to get wiped"
echo "         NixOS will be re-installed"
echo "         This is a destructive operation"
echo
read -p "Are you sure? [y/N]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo true

  sudo nix run github:nix-community/disko \
    --extra-experimental-features "nix-command flakes" \
    --no-write-lock-file \
    -- \
    --mode disko \
    "nixos/hosts/$TARGET_HOST/disk-configuration.nix"

  echo ""
  echo " ---- "
  echo " ---- Disk formatting complete "
  echo " ---- "
  echo ""
  echo "Sleeping 5s before proceeding..."
  sleep 5

  sudo nixos-install --no-root-password --flake ".#$TARGET_HOST"

  # Rsync nix-config to the target install.
  sudo mkdir -p "/mnt/etc/nixos"
  #sudo rsync -a --delete "/tmp/nixos/git/" "/mnt/etc/nixos/git/"
  #pushd "/mnt/etc/nixos/git/"
  #popd

  # If there is a keyfile for a data disk, put copy it to the root partition and
  # ensure the permissions are set appropriately.
  if [[ -f "/mnt-root/etc/swap.key" ]]; then
    sudo cp /mnt-root/etc/swap.key /mnt/etc/swap.key
    sudo chmod 0400 /mnt/etc/swap.key
  fi
fi