#!/bin/bash

install_git() {
    if distro_arch; then
        step_upgrade_pacman git
    else
        step_upgrade_apt git
    fi

    local updated=0
    if ! git config --global user.name &> /dev/null; then
        read -p "Enter git user.name [Sergey Stepanov]: " GIT_USERNAME
        if [ -z ${GIT_USERNAME} ]; then
            GIT_USERNAME="Sergey Stepanov"
        fi
        git config --global user.name "${GIT_USERNAME}"
        local updated=1
    fi

    if ! git config --global user.email &> /dev/null; then
        read -p "Enter git user.email [inndie.md@gmail.com]: " GIT_EMAIL
        if [ -z ${GIT_EMAIL} ]; then
            GIT_EMAIL="inndie.md@gmail.com"
        fi
        git config --global user.email "${GIT_EMAIL}"
        local updated=1
    fi

    if [ ${updated} -eq 1 ]; then
        step_print "Git config updated"
    else
        step_print "Git config is already updated"
    fi

    step_done
}

install_git
