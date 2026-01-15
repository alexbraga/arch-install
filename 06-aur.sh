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
    # =========================================================================
    # DEVELOPMENT
    # =========================================================================
    jetbrains-toolbox
    postman-bin
    studio-3t
    # visual-studio-code-bin

    # =========================================================================
    # CLOUD & DATABASE TOOLS
    # =========================================================================
    google-cloud-cli
    turso-cli-bin

    # =========================================================================
    # INTERNET & COMMUNICATION
    # =========================================================================
    dropbox
    google-chrome
    zoom

    # =========================================================================
    # MEDIA
    # =========================================================================
    spotify
    spotx-git
    subtitleedit
    yacreader-bin

    # =========================================================================
    # DOCUMENTS & PUBLISHING
    # =========================================================================
    libpdfium-nojs
    pandoc-bin

    # =========================================================================
    # KNOWLEDGE & STUDY
    # =========================================================================
    logseq-desktop-bin
    # anki-bin
    # mendeleydesktop-bundled

    # =========================================================================
    # NETWORKING
    # =========================================================================
    # packettracer
    # windscribe-cli

    # =========================================================================
    # SYSTEM & BOOT
    # =========================================================================
    etcher-bin
    ventoy-bin

    # =========================================================================
    # SYSTEM MAINTENANCE
    # =========================================================================
    grub-hook
    informant
    paccache-hook

    # =========================================================================
    # EMULATION & GAMING
    # =========================================================================
    libretro-atari800-git
    libretro-prosystem-git

    # =========================================================================
    # UTILITIES
    # =========================================================================
    freedownloadmanager-bin
    rar
    # vorta

    # =========================================================================
    # FONTS
    # =========================================================================
    ttf-times-new-roman
)

# Upgrade the system and install AUR packages
yay -S ${PKGS[@]} --needed

# ============================================================================
# Enable user services
# ============================================================================

# VORTA
# echo -e "Enabling vorta.service..."
# systemctl --user enable --now vorta.service
# echo -e "...DONE\n"
