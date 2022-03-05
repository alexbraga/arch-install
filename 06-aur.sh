#!/bin/bash

# Check if Yay is already installed. If not, install and config it for first run
echo -n "Checking if Yay is already installed..."

if which yay &>/dev/null; then
    echo -e "\nOK"
else
    echo "Yay NOT FOUND!"
    echo "INSTALLING: Yay"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    echo -e "\n...DONE\n"

    # Configure for first run
    echo "Configuring Yay for first run..."
    yay -Y --gendb
    yay -Syu --devel
    yay -Y --devel --save
    echo -e "\n...DONE"
fi

echo -e "\nPreparing to install AUR packages...\n"

PKGS=(
    # DEVELOPMENT
    'heroku-cli-bin'
    # 'mongodb-bin'
    'mongodb44-bin' # Use this if Mongo 5.x doesn't work on your system
    'postman-bin'
    'robo3t-bin'
    'visual-studio-code-bin'

    # INTERNET
    'google-chrome'
    'dropbox'

    # MISCELLANEOUS
    # 'mendeleydesktop-bundled'

    # MEDIA
    # 'spotify'
    'ums'

    # NETWORK
    'protonvpn'
    # 'windscribe-cli'

    # UTILITIES
    # 'vorta'
)

for PKG in "${PKGS[@]}"; do
    echo -e "\nINSTALLING: ${PKG}"
    yay -S "$PKG" --needed
done

# Install FreeFileSync
echo -e "\nINSTALLING: freefilesync-bin"
git clone https://aur.archlinux.org/freefilesync-bin.git
cd freefilesync-bin
makepkg -sic

echo -e "\n...DONE\n"

# Enabling services
echo "Enabling mongodb.service..."
sudo systemctl enable mongodb

echo -e "\n...DONE\n"
