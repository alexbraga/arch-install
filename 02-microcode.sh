#!/bin/bash

# CPU MICROCODE PACKAGES

if [[ $cpu = "AMD" ]]; then
    echo "Installing AMD microcode..."
    pacman -S amd-ucode --noconfirm
    echo -e "\n...DONE\n"
else
    echo "Installing Intel microcode..."
    pacman -S intel-ucode --noconfirm
    echo -e "\n...DONE\n"
fi
