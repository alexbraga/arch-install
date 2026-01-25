#!/bin/bash

PKGS=(
    # =========================================================================
    # DEVELOPMENT
    # =========================================================================
    bash-language-server
    dbeaver
    docker
    docker-compose
    git-filter-repo
    github-cli
    gradle
    jdk-openjdk
    maven
    npm
    nvm
    python-pipx
    python-pystray
    yaml-language-server

    # =========================================================================
    # DESKTOP & PLASMA (Core, Session & Input)
    # =========================================================================
    ibus
    kactivitymanagerd
    kglobalaccel
    kscreen
    kwin
    plasma-desktop
    plasma-nm
    plasma-pa
    powerdevil
    polkit-kde-agent
    systemsettings

    # =========================================================================
    # DISPLAY & GRAPHICS STACK
    # =========================================================================
    egl-wayland
    lib32-mesa
    lib32-vulkan-icd-loader
    lib32-vulkan-radeon
    libdecor
    mesa
    vulkan-icd-loader
    vulkan-radeon
    xdg-desktop-portal-kde
    xorg-xwayland

    # =========================================================================
    # DISPLAY MANAGER
    # =========================================================================
    sddm
    sddm-kcm

    # =========================================================================
    # FONTS
    # =========================================================================
    noto-fonts-cjk
    noto-fonts-emoji
    otf-monaspace
    ttf-jetbrains-mono
    ttf-mona-sans
    ttf-monaspace-variable

    # =========================================================================
    # GRAPHICS, DOCUMENTS & PUBLISHING
    # =========================================================================
    aegisub
    calibre
    displaycal
    gwenview
    inkscape
    okular
    spectacle

    # =========================================================================
    # HARDWARE, BLUETOOTH & RGB
    # =========================================================================
    bluedevil
    bluez-deprecated-tools
    bluez-utils
    openrgb

    # =========================================================================
    # INTERNET & COMMUNICATION
    # =========================================================================
    discord
    filezilla
    firefox
    telegram-desktop
    tor
    torbrowser-launcher

    # =========================================================================
    # MEDIA & AUDIO
    # =========================================================================
    alsa-utils
    audacious
    ffmpeg
    jellyfin-mpv-shim
    kdenlive
    mpv
    obs-studio
    picard
    pipewire-audio
    pipewire-jack
    yt-dlp

    # =========================================================================
    # GAMING & EMULATION
    # =========================================================================
    gamemode
    libretro
    mangohud
    retroarch
    retroarch-assets-ozone
    retroarch-assets-xmb
    steam

    # =========================================================================
    # VIRTUALIZATION & COMPATIBILITY
    # =========================================================================
    virtualbox
    wine
    wine-gecko
    wine-mono

    # =========================================================================
    # NETWORKING & SECURITY
    # =========================================================================
    gnome-keyring
    inetutils
    networkmanager-openvpn
    nmap
    openssh
    proton-vpn-gtk-app
    ufw
    veracrypt

    # =========================================================================
    # KDE UTILITIES & FILE MANAGEMENT
    # =========================================================================
    ark
    dolphin
    dolphin-plugins
    filelight
    kate
    kcalc
    kcron
    kdialog
    kinfocenter
    konsole
    ksystemlog
    kio-admin

    # =========================================================================
    # CLI UTILITIES, FILESYSTEMS & BACKUP
    # =========================================================================
    7zip
    bash-completion
    btrfs-progs
    e2fsprogs
    exfatprogs
    fastfetch
    grub-btrfs
    lsof
    ncdu
    ntfs-3g
    perl-rename
    pkgfile
    ranger
    rclone
    rsync
    tree
    unzip
    usbutils
    zip

    # =========================================================================
    # DOCUMENT PREPARATION — TeX / LaTeX
    # =========================================================================
    texlive-fontsextra
    texlive-fontsrecommended
    texlive-latex
    texlive-latexextra
    texlive-latexrecommended
    texlive-pictures
    texlive-xetex

    # =========================================================================
    # SYSTEM
    # =========================================================================
    cronie
    gparted
    htop
    inotify-tools
    power-profiles-daemon
    time
    testdisk
    wl-clipboard
)

dir="${HOME}/tmp"

set -e

# Download pacman.conf and replace original file
sudo curl --create-dirs --output-dir $dir -O https://gist.githubusercontent.com/alexbraga/f1ddde773f86ac643b5a5149c18c7e5a/raw/29e97a5cc59ee342c717697bf075b11358e41cf9/pacman.conf
sudo mv /etc/pacman.conf /etc/pacman.conf.bak
sudo cp ${dir}/pacman.conf /etc/pacman.conf

# Upgrade the system and install packages
sudo pacman -Syu ${PKGS[@]} --needed

# ============================================================================
# Enable system services
# ============================================================================

# BLUETOOTH
echo -e "Enabling bluetooth.service..."
sudo systemctl enable --now bluetooth.service
echo -e "...DONE\n"

# CRON
echo -e "Enabling cronie.service..."
sudo systemctl enable --now cronie.service
echo -e "...DONE\n"

# DOCKER
echo -e "Enabling docker.service..."
sudo systemctl enable --now docker.service
echo -e "...DONE\n"

# PKGFILE DB UPDATES
echo -e "Enabling pkgfile-update.timer..."
sudo systemctl enable --now pkgfile-update.timer
echo -e "...DONE\n"

# POWER PROFILES DAEMON
echo -e "Enabling power-profiles-daemon.service..."
sudo systemctl enable --now power-profiles-daemon.service
echo -e "...DONE\n"

# SDDM
echo -e "Enabling sddm.service..."
sudo systemctl enable sddm.service
echo -e "...DONE\n"

# UFW
echo -e "\nEnabling ufw.service..."
sudo systemctl enable --now ufw.service
echo -e "...DONE\n"

# Remove tmp folder
sudo rm -r $dir

echo -e "\nFinished successfully!"
