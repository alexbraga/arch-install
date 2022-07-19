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
    'filelight'
    'kate'
    'kcalc'
    'kdialog'
    'neofetch'
    'veracrypt'
    'wget'
)

for PKG in "${PKGS[@]}"; do
    echo -e "\nINSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --needed --noconfirm
    echo -e "\n...DONE"
done

# Enable firewall
echo -e "\nEnabling ufw.service..."
sudo systemctl enable ufw

# Enable Cron
echo -e "\nEnabling cronie.service..."
sudo systemctl enable cronie.service

echo -e "\n...DONE\n"
