#!/bin/bash

install_system() {
    local packages=(
        "alsa-utils"
        "bluez-utils"
        "firefox"
        "pulseaudio"
        "pulseaudio-alsa"
        "pulseaudio-bluetooth"
        "pulseaudio-jack"
        "slock"
        "telegram-desktop")

    step_upgrade_pacman ${packages[@]}
    step_service_activate bluetooth
    step_install_snap stellarium-daily
    step_done
}

install_system
