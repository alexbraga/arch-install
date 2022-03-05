#!/bin/bash

echo "Installing configuration files..."

# KEYBOARD

# Set up KDE keyboard layouts
cp config-files/kxkbrc $HOME/.config/

# Configure "US-International" keyboard layout to generate a cedilla c (ç) instead of an accented c (ć) for ´+c keystroke
wget -q https://raw.githubusercontent.com/marcopaganini/gnome-cedilla-fix/master/fix-cedilla -O fix-cedilla
chmod 755 fix-cedilla
./fix-cedilla

# Fix Java font rendering
echo -e "\nexport _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'" >> $HOME/.bash_profile

# Copy bashrc and gitconfig to current user
cp config-files/bashrc $HOME/.bashrc
cp config-files/gitconfig $HOME/.gitconfig

# Copy bashrc to root user
su
cp /arch-install/config-files/root/bashrc $HOME/.bashrc
exit

echo -e "\n...DONE\n"
