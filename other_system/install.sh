#!/bin/bash

install_other_system() {
    local packages=(
        "firefox"
        "pulseaudio"
        "pulseaudio-alsa"
        "pulseaudio-jack"
        "slock"
        "telegram-desktop")

    step_upgrade_pacman ${packages[@]}
    step_install_snap stellarium-daily
    step_done
}

install_other_system
