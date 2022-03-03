#!/bin/bash

echo "Installing Xorg display server..."
sudo pacman -S xorg-server --noconfirm --needed
echo -e "\n...DONE\n"

# GPU DRIVERS

if [[ $gpu = "AMD" ]]; then
    echo "Installing AMD drivers..."
    sudo pacman -S xf86-video-amdgpu --noconfirm --needed
    echo -e "\n...DONE\n"
elif [[ $gpu = "NVIDIA" ]]; then
    echo "Installing NVIDIA drivers..."
    sudo pacman -S nvidia nvidia-utils --noconfirm --needed
    echo -e "\n...DONE\n"
else
    echo "Installing Intel Integrated Graphics..."
    sudo pacman -S xf86-video-intel --noconfirm --needed
    echo -e "\n...DONE\n"
fi
