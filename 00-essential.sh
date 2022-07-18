#!/bin/bash

# ARCH LINUX BASE SYSTEM

PKGS=(
    # ESSENTIAL PACKAGES
    'base'
    'base-devel'
    'linux'
    'linux-firmware'

    # EXTRAS
    'dialog'
    # 'efibootmgr'    # needed for UEFI systems only
    'git'
    'grub'
    'man-db'
    'man-pages'
    'nano'
    'net-tools'
    'networkmanager'
    'ntfs-3g'
    'os-prober'       # needed for dual boot only
    'pacman-contrib'
    'vim'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    pacstrap /mnt "$PKG"
done

if [[ $fs = "Btrfs" ]]; then
    echo "INSTALLING: btrfs-progs"
    pacstrap /mnt btrfs-progs
else
    echo "INSTALLING: e2fsprogs"
    pacstrap /mnt e2fsprogs
fi

echo -e "\n...DONE\n"

# Generate fstab
echo "Generating the fstab file..."
genfstab -U /mnt >> /mnt/etc/fstab

# Copy git repo to new system
cp -r /root/arch-install/ /mnt/

# Change permissions
chmod -R 777 /mnt/arch-install/

# Change root and run configuration script
echo "Changing root into the new system..."
arch-chroot /mnt /bin/bash /arch-install/01-config.sh
exit
