#!/bin/bash

# Start with clean terminal
clear

# SUBMENUS

# Select File System
file_system() {
    echo "-------------------------------------------------" >&2
    echo "                   FILE SYSTEM                   " >&2
    echo -e "-------------------------------------------------\n" >&2

    local PS3=$'\nSelect the file system you are using. [1-2]: '
    local options=(
        "Btrfs"
        "ext4"
    )

    COLUMNS=12
    local option
    select option in "${options[@]}"; do
        case $option in
        "Btrfs")
            echo $option
            break
            ;;
        "ext4")
            echo $option
            break
            ;;
        *)
            echo -e "\nInvalid option '$REPLY'" >&2
            ;;
        esac
    done
}

# Select CPU model
microcode() {
    echo "-------------------------------------------------" >&2
    echo "                    MICROCODE                    " >&2
    echo -e "-------------------------------------------------\n" >&2

    local PS3=$'\nSelect your CPU model. [1-2]: '
    local options=(
        "AMD"
        "Intel"
    )

    COLUMNS=12
    local option
    select option in "${options[@]}"; do
        case $option in
        "AMD")
            echo $option
            break
            ;;
        "Intel")
            echo $option
            break
            ;;
        *)
            echo -e "\nInvalid option '$REPLY'" >&2
            ;;
        esac
    done
}

# Select GPU model
gpu() {
    echo "-------------------------------------------------" >&2
    echo "                    GPU DRIVER                    " >&2
    echo -e "-------------------------------------------------\n" >&2

    local PS3=$'\nSelect your GPU model. [1-3]: '
    local options=(
        "AMD"
        "NVIDIA"
        "Intel Integrated Graphics"
    )

    COLUMNS=12
    local option
    select option in "${options[@]}"; do
        case $option in
        "AMD")
            echo $option
            break
            ;;
        "NVIDIA")
            echo $option
            break
            ;;
        "Intel Integrated Graphics")
            echo $option
            break
            ;;
        *)
            echo -e "\nInvalid option '$REPLY'" >&2
            ;;
        esac
    done
}

# PRE-INSTALLATION WARNING

confirm() {
    read -p "Are you sure you want to proceed? [y/n]: "
    echo
    if [[ $REPLY =~ ^[Nn]$ ]]; then
        clear
        main_menu
        exit 1
    elif [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e '>>> Invalid answer. Please type "y" or "n". <<<\n'
        confirm
    else
        clear
    fi
}

warning() {
    echo -e "Before continuing, make sure you've already done the following:\n"
    echo "1) Set the console keyboard layout"
    echo "2) Verified the boot mode"
    echo "3) Connected to the internet"
    echo "4) Updated the system clock"
    echo "5) Partitioned the disks"
    echo "6) Formatted the partitions"
    echo -e "7) Mounted the file systems\n"

    confirm
}

# CONFIRMATION PROMPT

review() {

    # Selected options review
    echo -e "\n-------------------------------------------------"
    echo "INSTALL TYPE:   $install_type"

    if [[ $install_type = "Arch Linux" ]]; then
        echo "FILE SYSTEM:    $fs"
        echo "CPU MODEL:      $cpu"
    elif [[ ! $install_type = "Packages" ]]; then
        echo "GPU MODEL:      $gpu"
    fi
    echo -e "-------------------------------------------------\n"

    confirm
}

# START INSTALL

install() {
    clear
    review
    echo -e "$install_type installation starting...\n"

    if [[ ! $install_type = "Arch Linux" ]]; then
        echo "Checking for updates..."
        pacman -Syu
        echo -e "\n...DONE\n"
    fi
}

# CONCLUSION

success() {
    echo -e "\nINSTALLATION SUCCESSFULLY FINISHED\n"
}

# MAIN MENU

main_menu() {
    PS3=$'\nWhat do you want to do? [1-5]: '

    options=(
        "Install Arch Linux Base System"
        "Install DE + Packages"
        "Install Desktop Environment"
        "Install Packages"
        "Quit"
    )

    echo -e "
_________________________________________________
   ___________________________________________

          >>>  ARCH INSTALL SCRIPT  <<<
   ___________________________________________
_________________________________________________\n"

    COLUMNS=12
    select option in "${options[@]}"; do
        case $option in
        "Install Arch Linux Base System")
            install_type="Arch Linux"
            clear
            warning
            clear
            fs=$(file_system)
            export fs
            clear
            cpu=$(microcode)
            export cpu
            install
            ./00-essential.sh
            success
            echo -e "'chroot' to new system, configure the bootloader, create an unprivileged user account and reboot\n"
            break
            ;;
        "Install DE + Packages")
            install_type="DE + Packages"
            clear
            gpu=$(gpu)
            export gpu
            install
            ./03-gpu.sh
            ./04-gui.sh
            ./05-packages.sh
            sudo -u alex ./06-aur.sh
            success
            break
            ;;
        "Install Desktop Environment")
            install_type="Desktop Environment"
            clear
            gpu=$(gpu)
            export gpu
            install
            ./03-gpu.sh
            ./04-gui.sh
            success
            break
            ;;
        "Install Packages")
            install_type="Packages"
            install
            ./05-packages.sh
            sudo -u alex ./06-aur.sh
            success
            break
            ;;
        "Quit")
            echo -e "\nBye =)\n"
            exit
            ;;
        *)
            echo -e "\nInvalid option '$REPLY'"
            ;;
        esac
    done
}

main_menu
