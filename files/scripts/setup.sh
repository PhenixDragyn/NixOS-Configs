#!/usr/bin/env bash
pushd /etc/nixos/git

# Home-Manager Setup
echo ">>> Setting up Home Manager..... "
sudo mkdir /nix/var/nix/profiles/per-user/albert

# For some reason the syncthing folder takes this over and makes it owned by root
sudo mkdir /home/albert/.config 
sudo chown albert:albert /home/albert/.config
sudo chown -R albert:root /nix/var/nix/profiles/per-user/albert
home-manager switch -b backup --flake /etc/nixos/git

# Setup SOPS
echo "Setting up SOPS keys..... "
echo ">>> !!!!!"
echo ">>> !!!!!"
echo ">>> !!!!!"
echo ">>> !!!!! Copy this signature to .sops.yaml:  "

# Currently only RSA keys are allowed
sudo ssh-to-pgp \
    -comment "Generated `date +%Y.%m.%d`" \
    -email "root@`hostname`" \
    -i /etc/ssh/ssh_host_rsa_key \
    -o /etc/nixos/git/keys/hosts/$(hostname).asc

echo ">>> !!!!!"
echo ">>> !!!!!"
echo ">>> !!!!!"

# Set up ssh keys
echo ">>> Setting up SSH Keys..... "
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519  -N ""
echo "" >> ./keys/ssh/keys.txt
echo "# ($(date)) $(whoami)@$(hostname)" >> ./keys/ssh/keys.txt
cat /home/albert/.ssh/id_ed25519.pub >> ./keys/ssh/keys.txt

# Add all changes to git and and push
echo ">>> Pushing to git..... "
git add keys/hosts/`hostname`.asc
git -c commit.gpgsign=false commit -am "Setup: `hostname`"
git push

echo
echo
echo ">>> Complete.  Once '.sops.yaml' is updated, "
echo ">>> run 'update-secrets' and reboot."
echo 
echo
echo ">>> Reminder:  Upload these changes to git"

popd || exit
