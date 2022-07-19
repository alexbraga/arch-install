#!/bin/bash

# BASIC GUI PACKAGES

PKGS=(
    'dolphin'
    'kdegraphics-thumbnailers'
    'konsole'
    'noto-fonts-emoji'
    'packagekit-qt5'
    'plasma'
    'xdg-desktop-portal'
)

for PKG in "${PKGS[@]}"; do
    echo -e "\nINSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --needed
done

echo -e "\n...DONE\n"

# Enable SDDM display manager
echo "Enabling sddm.service..."
sudo systemctl enable sddm

echo -e "\n...DONE\n"
