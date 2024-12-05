#!/bin/bash

curl -L https://nixos.org/nix/install | sh

. /home/administrador/.nix-profile/etc/profile.d/nix.fish

echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

#nix profile install github:nix-community/home-manager
#nix profile remove home-manager

nix profile install github:nix-community/home-manager --priority 4

home-manager switch
