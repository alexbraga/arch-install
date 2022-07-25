#!/bin/bash

PKGS=(
    # DEVELOPMENT
    'dbeaver'
    'gradle'
    'intellij-idea-community-edition'
    'jdk17-openjdk'
    'mariadb'
    'maven'
    'nodejs-lts-gallium'  # Replace LTS release name if outdated
    'npm'
    # 'nvm'
    'postgresql'

    # GRAPHICS
    'gwenview'
    'okular'
    'spectacle'

    # INTERNET
    'discord'
    'firefox'
    'qbittorrent'
    'telegram-desktop'

    # MEDIA
    'alsa-plugins'
    'alsa-utils'
    # 'audacious'
    # 'elisa'
    'mpv'
    # 'ncmpcpp'
    'pavucontrol'
    'pulseaudio-alsa'
    # 'smplayer-skins'
    # 'smplayer-themes'
    # 'smplayer'
    'yt-dlp'

    # MISCELLANEOUS
    'calibre'

    # NETWORK
    # 'apache'
    'ufw'   # Replace with 'gufw' for GUI tool

    # SYSTEM
    'gnome-keyring'
    'gparted'
    'kcron'
    'ksystemlog'

    # UTILITIES
    'ark'
    'bash-completion'
    # 'borg'
    'docker'
    'filelight'
    'kate'
    'kcalc'
    'kdialog'
    'neofetch'
    'veracrypt'
)

for PKG in "${PKGS[@]}"; do
    echo -e "\nINSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --needed --noconfirm
    echo -e "\n...DONE"
done

# Enable firewall
echo -e "\nEnabling ufw.service..."
sudo systemctl enable ufw.service
echo -e "\n...DONE\n"

# Enable Cron
echo -e "\nEnabling cronie.service..."
sudo systemctl enable cronie.service
echo -e "\n...DONE\n"

# Enable Docker
echo -e "\nEnabling docker.service..."
sudo systemctl enable docker.service
echo -e "\n...DONE\n"

# Install Portainer
echo -e "\nInstalling Portainer: Container Management..."
echo -e "\nCreating Docker volume..."
sudo docker volume create portainer_data
echo -e "\nDownloading and installing the Portainer Server container..."
sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
echo -e "\n...DONE\n"
