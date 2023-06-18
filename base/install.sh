#!/bin/bash

install_base() {
    local packages=(
        "bash-completion"
        "cmake"
        "dmidecode"
        "dnsutils"
        "dosfstools"
        "fzf"
        "gcc"
        "hwinfo"
        "libheif"
        "lshw"
        "minicom"
        "moreutils"
        "mtools"
        "ncdu"
        "net-tools"
        "ntfs-3g"
        "openssh"
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
        "wget"
        "zip"
    )

    if distro_arch; then
        packages+=(
            "base-devel"
            "gtest"
            "xz"
        )

        step_print_temp "Updating keyring.."
        sudo pacman -Sy --noconfirm archlinux-keyring &> /dev/null
        sudo pacman -Su --noconfirm &> /dev/null
        step_print "Keyring updated"

        step_print_temp "Getting system updates.."
        sudo pacman -Syu --noconfirm &> /dev/null
        step_print "System updated"

        step_upgrade_pacman ${packages[@]}

        step_upgrade_aur yay
        step_upgrade_aur snapd
        step_service_activate snapd
    else
        packages+=(
            "clang-tidy"
            "libgtest-dev"
            "rar"
            "xz-utils"
        )

        step_print_temp "Updating apt indices.."
        sudo apt update &> /dev/null
        step_print "Apt indices updated"

        step_upgrade_apt ${packages[@]}
    fi

    step_done
}

install_base
