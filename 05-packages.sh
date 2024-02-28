#!/bin/bash

PKGS=(
    # DEVELOPMENT
    'dbeaver'
    'gradle'
    'jdk11-openjdk'
    'jdk17-openjdk'
    'mariadb'
    'maven'
    'nodejs-lts-gallium'  # Replace LTS release name if outdated
    'npm'
    # 'nvm'
    'postgresql'

    # GRAPHICS
    'gwenview'
    'inkscape'
    'kimageformats'   # Image format plugins for Qt5
    'okular'
    'qt5-imageformats'    # Plugins for additional image formats: TIFF, MNG, TGA, WBMP
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
    # 'kdenlive'
    # 'kodi'
    # 'mpd'
    'mpv'
    # 'ncmpcpp'
    # 'obs-studio'
    'pavucontrol'
    'pipewire-pulse'
    'pulseaudio-alsa'
    # 'smplayer'
    # 'smplayer-skins'
    # 'smplayer-themes'
    'yt-dlp'

    # MISCELLANEOUS
    'calibre'
    'libreoffice-still'
    'virtualbox'
    'wine'  # Enable multilib first
    'wine-mono'

    # NETWORK
    # 'apache'
    'freerdp'
    'nmap'
    'openvpn'
    'ufw'   # Replace with 'gufw' for GUI tool

    # SYSTEM
    'gnome-keyring'
    'gparted'
    'kcron'
    'ksystemlog'

    # UTILITIES
    # 'android-tools'
    'ark'
    'aspell'
    'aspell-en'
    'aspell-pt'
    'bash-completion'
    'bash-language-server'
    # 'borg'
    'docker'
    'dolphin-plugins'
    'filelight'
    'filezilla'
    'ibus'
    'inotify-tools'
    'kate'
    'kcalc'
    'kdialog'
    'neofetch'
    'p7zip'
    'perl-rename'
    'rclone'
    'testdisk'    # Checks and undeletes partitions + PhotoRec, signature based recovery tool
    'unrar'
    'unzip'
    'usbutils'
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
echo -e "\nStarting docker.service..."
sudo systemctl start docker.service
echo -e "\n...DONE\n"

# Install Portainer
echo -e "\nInstalling Portainer: Container Management..."
echo -e "\nCreating Docker volume..."
sudo docker volume create portainer_data
echo -e "\nDownloading and installing the Portainer Server container..."
sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
echo -e "\n...DONE\n"
