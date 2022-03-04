#!/bin/bash

# SYSTEM CONFIGURATION

# FSTAB
echo "Generating the fstab file..."
genfstab -U /mnt >> /mnt/etc/fstab

# CHROOT
echo "Changing root into the new system..."
arch-chroot /mnt

chrt='arch-chroot /mnt /bin/bash'

# SET TIME ZONE
chrt echo "Setting system time zone..."
chrt ln -sf /usr/share/zoneinfo/Brazil/East /etc/localtime
chrt hwclock --systohc

# LOCALIZATION
# Select locale manually - uncomment needed locale(s), save file and exit
chrt nano /etc/locale.gen
chrt echo "Generating locales..."
chrt locale-gen
chrt echo "Creating locale.conf..."
chrt echo LANG=en_US.UTF-8 > /etc/locale.conf

# NETWORK
chrt echo "Creating hostname..."
chrt echo arch-desktop > /etc/hostname
chrt echo "Enabling NetworkManager.service..."
chrt systemctl enable NetworkManager
chrt echo

# ROOT PASSWORD
# Enter (new) password for root user
chrt passwd

chrt echo -e "\n...DONE\n"