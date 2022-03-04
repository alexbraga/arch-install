#!/bin/bash

# SYSTEM CONFIGURATION

# SET TIME ZONE
echo "Setting system time zone..."
ln -sf /usr/share/zoneinfo/Brazil/East /etc/localtime
hwclock --systohc

# LOCALIZATION
# Select locale manually - uncomment needed locale(s), save file and exit
nano /etc/locale.gen
echo "Generating locales..."
locale-gen
echo "Creating locale.conf..."
echo LANG=en_US.UTF-8 > /etc/locale.conf

# NETWORK
echo "Creating hostname..."
echo arch-desktop > /etc/hostname
echo "Enabling NetworkManager.service..."
systemctl enable NetworkManager
echo

# ROOT PASSWORD
# Enter (new) password for root user
passwd

echo -e "\n...DONE\n"
