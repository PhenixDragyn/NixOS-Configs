# Installation
https://nixos.wiki/wiki/NixOS_Installation_Guide

nixos-install --impure --flake /mnt/etc/flake#somehost

------

# Update flake.lock
nix flake update

# Or replace only the specific input, such as home-manager:
nix flake update home-manager

# Apply the updates
sudo nixos-rebuild switch --flake .

# Or to update flake.lock & apply with one command (i.e. same as running "nix flake update" before)
sudo nixos-rebuild switch --recreate-lock-file --flake .

Occasionally, you may encounter a "sha256 mismatch" error when running
nixos-rebuild switch. This error can be resolved by updating flake.lock using nix flake update.

------

# Basic Commands
> sudo nixos-rebuild switch --flake '.'
> home-manager switch --flake '.'

> nix-channel --update      # ?? Needed with flakes?

> sudo nixos-rebuild switch --upgrade

> nix flake update
> nixos-rebuild switch --upgrade --verbose

------

# Garbage collection with flakes

> sduo nix-collect-garbage
> sudo nix-collect-garbage -d
  OR
> sudo nix-collect-garbage --delete-older-than #d 

> nix-env --list-generations

> sudo nix-env --delete-generations old (##)
  OR
> sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations ##

> sudo nixos-rebuild switch --flake '.'

> sudo nix-env --switch-generation 12345 -p /nix/var/nix/profiles/system
> sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
------

# to rollback to a working build
> /run/current-system/bin/switch-to-configuration boot

# To use a one-off utility
> nix-shell nixpkgs#ffmpeg

# Create a VM
> nixos-rebuild build-vm

# Check flakes
> nix flake check

----

# To update to unstable (Update the neccessary available channel)
> sudo nix-channel --list
> sudo nix-channel --add https://nixos.org/channels/nixos-unstable
> sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable

> Had to comment out nixvim follows line and run (a few times)
> nix flake update
> nix falke lock


# To list installed packages...
> nix-store --query --requisites /run/current-system | cut -d- -f2 | sort | uniq


# To find what installed a package.. (for example - Chromium)
> nix eval .#nixosConfigurations.nixos-test.options.programs.chromium.enable.definitionsWithLocations
[ { file = "/nix/store/dh5p58x9ax2g9d5wrp29nkfsh34a5y3y-modules/chromium/nixos.nix"; value = true; } ]

> bat -p /nix/store/dh5p58x9ax2g9d5wrp29nkfsh34a5y3y-modules/chromium/nixos.nix
{ config, lib, ... }:

{
  options.stylix.targets.chromium.enable =
    config.lib.stylix.mkEnableTarget "Chromium, Google Chrome and Brave" true;

  config.programs.chromium = lib.mkIf (config.stylix.enable && config.stylix.targets.chromium.enable) {
    # This enables policies without installing the browser. Policies take up a
    # negligible amount of space, so it's reasonable to have this always on.
    enable = true;

    extraOpts.BrowserThemeColor = config.lib.stylix.colors.withHashtag.base00;
  };
}


# Git Commands
> git clone git@github.com:PhenixDragyn/NixOS-Configs.git
> git pull origin master
> git add .
> git status
> git commit -m "Some comment"
> git push -u origin master

# Get has information
> nix-prefetch samba4Full.src 


# GIT with SSH 
Make sure the .git/config file has the url set to 
git@github.com:PhenixDragyn/NixOS-Configs.git

--

nix-clean () {
  nix-env --delete-generations old
  nix-store --gc
  nix-channel --update
  nix-env -u --always
  for link in /nix/var/nix/gcroots/auto/*
  do
    rm $(readlink "$link")
  done
  nix-collect-garbage -d
}
 
remove old /boot/kernels/

# VM Machine
> nix build ./#nixosConfigurations.vm.config.system.build.vm
> ./result/bin/run-nixos-vm

# ISO Command
nix build .#imageConfigurations.nixos-iso-console.config.system.build.isoImage
nix-shell -p qemu
#> qemu-system-x86_64 -enable-kvm -m 256 -cdrom result/iso/nixos-*.iso
qemu-system-x86_64 -enable-kvm -m 4096 -cpu host -device virtio-vga-gl -device intel-hda -device hda-duplex -display gtk,gl=on -cdrom result/iso/nixos.iso


# HYPERLAND CLIPBOARD
Skimmed thru writing and saw screenshot part.
Here is another solution stolen from somewhere on github, unfortunately don't remember from where and who.
Freezes screen for you to select region means pop-ups should be captured as well.
Also works in games.
Output folder can be set (instead of -o -put -o your_path) altho I prefer to not save and have it just copied to clipboard.
 
#----
#!/bin/bash

hyprpicker -r -z &
hyprpicker_pid=$!
sleep 0.1
hyprshot -m region --clipboard-only | grim -t png -c -o -
hyprshot_pid=$!
wait $hyprshot_pid
sleep 0.1
kill $hyprpicker_pid
kill $hyprshot_pid
#----

# Repair fonts 
fc-cache -fr


# Rollback home-manager
> home-manager generations
Select the generation path you want to reactivate.. ie
> /nix/store/ilhmvvvialiljr2ybmasffid982s921c-home-manager-generation/activate

# Papirus folder color changing 
> papirus-folders -l --theme Papirus-Dark   #Show current color
> papirus-folders -C brown --theme Papirus-Dark    # Change Color
> papirus-folders -D --theme Papirus-Dark    # Rever to default color

