#!/bin/bash

install_other_console() {
    if distr_arch; then
        sudo pacman -Syy &> /dev/null
        step_print "Pacman databases updated."

        step_upgrade_pacman tar zip unzip rar unrar \
            moreutils ncdu net-tools hwinfo minicom \
            git cmake clang-tidy \
            mmv termshark fzf ncal alsa-utils \
            dosfstools mtools wget python3

    else
        sudo apt update &> /dev/null
        step_print "Apt indices updated."

        step_upgrade_apt tar zip unzip rar unrar \
            moreutils ncdu net-tools hwinfo minicom \
            git cmake clang-tidy \
            mmv termshark fzf ncal alsa-utils \
            dosfstools mtools wget python3
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
