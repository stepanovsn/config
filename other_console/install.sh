#!/bin/bash

install_other_console() {
    local packages=(
        "alsa-utils"
        "clang-tidy"
        "cmake"
        "dosfstools"
        "fzf"
        "git"
        "hwinfo"
        "minicom"
        "mmv"
        "moreutils"
        "mtools"
        "ncal"
        "ncdu"
        "net-tools"
        "python3"
        "rar"
        "tar"
        "termshark"
        "unrar"
        "unzip"
        "wget"
        "zip")

    if distr_arch; then
        sudo pacman -Syy &> /dev/null
        step_print "Pacman databases updated."

        step_upgrade_pacman ${packages[@]}

    else
        sudo apt update &> /dev/null
        step_print "Apt indices updated."

        step_upgrade_apt ${packages[@]}
    fi

    local git_config_updated=0
    if ! git config --global user.name &> /dev/null; then
        git config --global user.name "Sergey Stepanov"
        local git_config_updated=1
    fi

    if ! git config --global user.email &> /dev/null; then
        git config --global user.email "inndie.md@gmail.com"
        local git_config_updated=1
    fi

    if [ ${git_config_updated} -eq 1 ]; then
        step_print "Git config updated"
    fi

    step_done
}

install_other_console
