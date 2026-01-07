#!/bin/bash

PKGS=(
    # =========================================================================
    # DEVELOPMENT — Toolchains & Runtimes
    # =========================================================================
    bash-language-server
    git-filter-repo
    github-cli
    jdk-openjdk
    npm
    nvm
    yaml-language-server
    docker
    python-pipx
    python-pystray

    # =========================================================================
    # DEVELOPMENT — Build Tools
    # =========================================================================
    gradle
    maven

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
    # GRAPHICS & DOCUMENTS
    # =========================================================================
    gwenview
    inkscape
    okular
    spectacle
    displaycal
    calibre
    aegisub

    # =========================================================================
    # INTERNET & COMMUNICATION
    # =========================================================================
    discord
    firefox
    telegram-desktop
    tor
    torbrowser-launcher
    filezilla

    # =========================================================================
    # MEDIA — Applications
    # =========================================================================
    audacious
    ffmpeg
    jellyfin-mpv-shim
    kdenlive
    mpv
    obs-studio
    picard
    yt-dlp

    # =========================================================================
    # MEDIA — Audio Stack
    # =========================================================================
    alsa-utils
    pipewire-audio
    pipewire-jack

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
    inetutils
    networkmanager-openvpn
    nmap
    openssh
    ufw
    gnome-keyring
    veracrypt

    # =========================================================================
    # SYSTEM — Plasma Desktop (Minimal but Complete)
    # =========================================================================
    plasma-desktop
    plasma-pa
    plasma-nm
    powerdevil
    polkit-kde-agent
    systemsettings
    kglobalaccel
    kactivitymanagerd
    kscreen
    kwin

    # =========================================================================
    # SYSTEM — Display Manager
    # =========================================================================
    sddm
    sddm-kcm

    # =========================================================================
    # SYSTEM — Hardware, Graphics & Drivers
    # =========================================================================
    bluedevil
    bluez-utils
    bluez-deprecated-tools
    lib32-mesa
    lib32-vulkan-icd-loader
    lib32-vulkan-radeon
    mesa
    vulkan-icd-loader
    vulkan-radeon
    openrgb

    # =========================================================================
    # SYSTEM — Wayland & Desktop Integration
    # =========================================================================
    egl-wayland
    libdecor
    xdg-desktop-portal-kde
    xorg-xwayland

    # =========================================================================
    # UTILITIES — KDE Applications
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

    # =========================================================================
    # UTILITIES — CLI, Filesystems & Backup
    # =========================================================================
    7zip
    bash-completion
    btrfs-progs
    e2fsprogs
    exfatprogs
    fastfetch
    ntfs-3g
    lsof
    ncdu
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
    texlive-latex
    texlive-latexextra
    texlive-latexrecommended
    texlive-fontsextra
    texlive-fontsrecommended
    texlive-pictures
    texlive-xetex

    # =========================================================================
    # UTILITIES — System & Admin
    # =========================================================================
    cronie
    gparted
    htop
    inotify-tools
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
