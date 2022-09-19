#!/bin/bash

install_other_system() {
    local packages=(
        "firefox"
        "pulseaudio"
        "pulseaudio-alsa"
        "pulseaudio-jack"
        "telegram-desktop")

    if distro_arch; then
        step_upgrade_pacman ${packages[@]}
    else
        step_upgrade_apt ${packages[@]}
    fi

    step_done
}

install_other_system
