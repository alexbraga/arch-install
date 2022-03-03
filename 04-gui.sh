#!/bin/bash

# BASIC GUI PACKAGES

PKGS=(
    'dolphin'
    'konsole'
    'noto-fonts-emoji'
    'packagekit-qt5'
    'plasma'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"

    if [[ $PKG = 'plasma' ]]; then
    # Confirm multiple choices manually for Plasma
        sudo pacman -S "$PKG" --needed
    else
        sudo pacman -S "$PKG" --noconfirm --needed
    fi
done

echo -e "\n...DONE\n"

# Enable SDDM display manager
echo "Enabling sddm.service..."
sudo systemctl enable sddm

echo -e "\n...DONE\n"
