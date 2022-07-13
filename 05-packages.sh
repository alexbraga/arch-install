#!/bin/bash

PKGS=(
    # DEVELOPMENT
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

    # MISCELLANEOUS
    'calibre'

    # NETWORK
    # 'apache'
    'ufw'   # Replace with 'gufw' for GUI tool

    # SYSTEM
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

echo -e "\n...DONE\n"
