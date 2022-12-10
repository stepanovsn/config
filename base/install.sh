#!/bin/bash

install_base() {
    local packages=(
        "bash-completion"
        "cmake"
        "dmidecode"
        "dosfstools"
        "fzf"
        "gcc"
        "hwinfo"
        "lshw"
        "minicom"
        "moreutils"
        "mtools"
        "ncdu"
        "net-tools"
        "openssh"
        "openssl"
        "python3"
        "python-pip"
        "tar"
        "termshark"
        "unrar"
        "unzip"
        "upower"
        "wget"
        "zip"
    )

    if distro_arch; then
        packages+=(
            "base-devel"
        )

        step_print_temp "Getting system updates.."
        sudo pacman -Syu --noconfirm &> /dev/null
        step_print "System updated"

        step_upgrade_pacman ${packages[@]}

        step_upgrade_aur snapd
        step_service_activate snapd
    else
        packages+=(
            "clang-tidy"
            "rar"
        )

        step_print_temp "Updating apt indices.."
        sudo apt update &> /dev/null
        step_print "Apt indices updated"

        step_upgrade_apt ${packages[@]}
    fi

    step_done
}

install_base