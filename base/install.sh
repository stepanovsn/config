#!/bin/bash

install_base() {
    local packages=(
        "bash-completion"
        "cmake"
        "csvkit"
        "curl"
        "dmidecode"
        "dnsutils"
        "docx2txt"
        "dosfstools"
        "fzf"
        "gcc"
        "hwinfo"
        "inotify-tools"
        "inxi"
        "lshw"
        "minicom"
        "moreutils"
        "mp3info"
        "mtools"
        "ncdu"
        "net-tools"
        "ntfs-3g"
        "openssl"
        "openvpn"
        "pdftk"
        "python3"
        "python-pip"
        "tar"
        "termshark"
        "trash-cli"
        "unrar"
        "unzip"
        "upower"
        "usbutils"
        "wget"
        "zip"
    )

    if distro_arch; then
        packages+=(
            "base-devel"
            "gtest"
            "libheif"
            "openssh"
            "pacman-contrib"
            "xz"
        )

        # In case of key problems:
        # - Remove /etc/pacman.d/gnupg directory
        # - Run 'sudo pacman-key --init'
        # - Run 'sudo pacman-key --populate'

        # In case of other package problems:
        # - Update /etc/pacman.d/mirrorlist according to https://www.archlinux.org/mirrorlist/

        # or:
        # - pacman -Syyu

        step_print_temp "Updating keyring.."
        #run_command sudo pacman -Sy --noconfirm archlinux-keyring
        #run_command sudo pacman -Su --noconfirm
        #step_print "Keyring updated"
        step_warn "Keyring updating skipped"

        step_print_temp "Getting system updates.."
        run_command sudo pacman -Syu --noconfirm
        step_print "System updated"

        step_upgrade_pacman ${packages[@]}

        step_upgrade_aur yay
        step_upgrade_aur snapd
        step_service_activate snapd

        step_upgrade_yay xkblayout-state
    else
        packages+=(
            "clang-tidy"
            "libgtest-dev"
            "openssh-server"
            "rar"
            "xz-utils"
        )

        step_print_temp "Updating apt indices.."
        run_command sudo apt update
        step_print "Apt indices updated"

        step_upgrade_apt ${packages[@]}
    fi

    step_done
}

install_base
