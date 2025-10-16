INSTALLATION

# BIOS Settings
    Turn off RAID storage
    Turn off Secure Boot

# Connect to wifi

    wpa_passphrase ESSID | sudo tee /etc/wpa_supplicant.conf
    sudo wpa_supplicant -i<network device> -c/etc/wpa_supplicant.conf
    sudo fdisk /dev/diskX

# UEFI

    g (gpt disk label)
    n
    1 (partition number [1/128])
    2048 first sector
    +500M last sector (boot sector size)
    t
    1 (EFI System)
    n
    2
    default (fill up partition)
    +<max gig - memory gigs>G
    n
    3
    default (fill up partition)
    default (fill up partition)
    w (write)


# Label partitions

# This is useful for having multiple setups and makes partitions easier to handle.

    lsblk
    sudo mkfs.fat -F 32 /dev/sdX1
    sudo fatlabel /dev/sdX1 NIXBOOT
    sudo mkfs.ext4 /dev/sdX2 -L NIXROOT
    sudo mount /dev/disk/by-label/NIXROOT /mnt
    sudo mkdir -p /mnt/boot
    sudo mount /dev/disk/by-label/NIXBOOT /mnt/boot
    sudo mkswap /dev/nvme0n1p3 -L NIXSWAP
    sudo swapon /dev/disk/by-label/NIXSWAP


# NixOS config

    sudo nixos-generate-config --root /mnt
    cd /mnt/etc/nixos/
    sudo vim configuration.nix

# Most essential changes:

    keyboard layout, ie services.xserver.layout
    users.users.user with adding entry initialPassword = "pw123";
    networking (wifi), see below for fix if it breaks
    boot.loader.grub.device = "/dev/sda"; #or "nodev" for efi only
    install editor to edit the configuration
    change hardware config to use labels


# NixOS installation

    cd /mnt
    sudo nixos-install

# after installation: Run passwd to change user password.

# if internet broke/breaks, try one of the following:

    nixos-rebuild switch --option substitute false # no downloads
    nixos-rebuild switch --option binary-caches "" # no downloads
    wpa_supplicant flags to connect to wifi
    or rund nmtui for network settings
    sudo nmcli dev wifi con “OAG” password “#SawtoothRange19”

-------------------------------------------------------

INSTALLATION WITH NIX FLAKES

# Connect to wifi

    wpa_passphrase ESSID | sudo tee /etc/wpa_supplicant.conf
    sudo wpa_supplicant -i<network device> -c/etc/wpa_supplicant.conf

# Git or copy flakes

# cd NixOS and run install.sh script

    ./files/scripts/install.sh nixos-lt

# copy NixOS to /mnt/home/ejvend directory

# chroot and change to user and run home-manager:

    sudo nixos-enter
    sudo nix-daemon --daemon &
    su - ejvend
    home-manager switch --flake '.#ejvend@nixos-lt'

-------------------------------------------------------

POST INSTALLATION

# Bluetooth
* Sync wireless mouse.

# SSH Keys
* Copy keys to ~/.ssh. 

# Syncthing
* Connect and add password to shared systems.

# Keepass
* Link ~/Sync/keepass to ~/.keepass
* Connect keepass to database in ~/.keepass

# Ranger 
* Copy ~/NixOS/home/ejvend/config/ranger-plugins to ~/.config/ranger/plugins

# Firefox
* Sign in to firefox.
* Copy sidebery - styles editor code from ~/NixOS/home/ejvend/config/firefox/README.md.

# Thunderbird
* Sign in to thunderbird and setup mail and calendars


