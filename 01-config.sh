#!/bin/bash

# SYSTEM CONFIGURATION

# SET TIME ZONE
echo "Setting system time zone..."
ln -sf /usr/share/zoneinfo/Brazil/East /etc/localtime
hwclock --systohc

# LOCALIZATION

# Select locale automatically: find needed locale(s), uncomment, save and exit
locale01="en_US.UTF-8 UTF-8"
locale02="pt_BR.UTF-8 UTF-8"
echo "Editing configuration file for locale-gen..."
sed -i "s/#$locale01/$locale01/g" /etc/locale.gen
sed -i "s/#$locale02/$locale02/g" /etc/locale.gen

# Generate locales
locale-gen
echo "Creating locale.conf..."
echo LANG=en_US.UTF-8 > /etc/locale.conf

# NETWORK
echo "Creating hostname..."
echo arch-desktop > /etc/hostname

# Enable NetworkManager
echo "Enabling NetworkManager.service..."
systemctl enable NetworkManager
echo

# Enable dhcpcd
# echo "Enabling dhcpcd.service..."
# systemctl enable dhcpcd.service
# echo

# ROOT PASSWORD
# Enter (new) password for root user
passwd

echo -e "\n...DONE\n"

/arch-install/02-microcode.sh