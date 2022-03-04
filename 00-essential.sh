#!/bin/bash

# ARCH LINUX ESSENTIAL PACKAGES + EXTRAS

PKGS=(
    'base-devel'
    'base'
    'dialog'
    # 'efibootmgr'    # needed for UEFI systems only
    'git'
    'grub'
    'linux-firmware'
    'linux'
    'man-db'
    'man-pages'
    'nano'
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

# Copy git repo to new system, change root and run configuration script
cp -rp /root/arch-install/ /mnt/
echo "Changing root into the new system..."
arch-chroot /mnt /bin/bash /arch-install/01-config.sh
exit
