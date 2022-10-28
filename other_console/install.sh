#!/bin/bash

install_other_console() {
    local packages=(
        "alsa-utils"
        "bash-completion"
        "clang-tidy"
        "cmake"
        "dmidecode"
        "dosfstools"
        "fzf"
        "git"
        "hwinfo"
        "lshw"
        "minicom"
        "mmv"
        "moreutils"
        "mtools"
        "ncal"
        "ncdu"
        "net-tools"
        "openssh"
        "python3"
        "python-pip"
        "rar"
        "tar"
        "termshark"
        "unrar"
        "unzip"
        "upower"
        "wget"
        "zip")

    if distro_arch; then
        sudo pacman -Syu --noconfirm &> /dev/null
        step_print "Pacman databases updated."

        step_upgrade_pacman ${packages[@]}

    else
        sudo apt update &> /dev/null
        step_print "Apt indices updated."

        step_upgrade_apt ${packages[@]}
    fi

    local git_config_updated=0
    if ! git config --global user.name &> /dev/null; then
        read -p "Enter git user.name [Sergey Stepanov]: " GIT_USERNAME
        if [ -z ${GIT_USERNAME} ]; then
            GIT_USERNAME="Sergey Stepanov"
        fi
        git config --global user.name "${GIT_USERNAME}"
        local git_config_updated=1
    fi

    if ! git config --global user.email &> /dev/null; then
        read -p "Enter git user.email [inndie.md@gmail.com]: " GIT_EMAIL
        if [ -z ${GIT_EMAIL} ]; then
            GIT_EMAIL="inndie.md@gmail.com"
        fi
        git config --global user.email "${GIT_EMAIL}"
        local git_config_updated=1
    fi

    if [ ${git_config_updated} -eq 1 ]; then
        step_print "Git config updated"
    fi

    step_done
}

install_other_console
