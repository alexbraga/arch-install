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
    'mongodb-bin' # Use this if your system supports Mongo's latest version
    # 'mongodb44-bin' # Use this if Mongo >5.x doesn't work on your system
    'mssql-server'
    'msodbcsql'
    'mssql-tools'
    'postman-bin'
    'robo3t-bin'
    'visual-studio-code-bin'

    # INTERNET
    'dropbox'
    'flaresolverr'
    'google-chrome'
    # 'jackett-bin'
    'prowlarr'
    'sonarr'

    # MISCELLANEOUS
    'anki-bin'
    'logseq-desktop-bin'
    # 'mendeleydesktop-bundled'

    # MEDIA
    # 'spotify'
    'ums'

    # NETWORK
    'protonvpn'
    'tor-browser'
    # 'windscribe-cli'

    # UTILITIES
    'etcher-bin'
    # 'vorta'
)

for PKG in "${PKGS[@]}"; do
    echo -e "\nINSTALLING: ${PKG}"
    yay -S "$PKG" --needed
    echo -e "\n...DONE"
done

# Install FreeFileSync
echo -e "\nINSTALLING: freefilesync-bin"
git clone https://aur.archlinux.org/freefilesync-bin.git
cd freefilesync-bin
makepkg -sic
echo -e "\n...DONE"

# Enable MongoDB
echo -e "\nEnabling mongodb.service..."
sudo systemctl enable mongodb.service
echo -e "\n...DONE\n"

# Enable Prowlarr
echo -e "\nEnabling prowlarr.service..."
sudo systemctl enable prowlarr.service
echo -e "\n...DONE\n"

# Enable Sonarr
echo -e "\nEnabling sonarr.service..."
sudo systemctl enable sonarr.service
echo -e "\n...DONE\n"
