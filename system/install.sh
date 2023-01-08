#!/bin/bash

install_system() {
    local packages=(
        "alsa-utils"
        "chromium"
        "bluez-utils"
        "firefox"
        "gedit"
        "libreoffice-still"
        "pulseaudio"
        "pulseaudio-alsa"
        "pulseaudio-bluetooth"
        "pulseaudio-jack"
        "slock"
        "telegram-desktop"
        "thunar"
        "tumbler"
        "vlc"
    )

    step_upgrade_pacman ${packages[@]}
    step_service_activate bluetooth
    step_install_snap stellarium-daily
    step_upgrade_aur zoom

    local bashrc_updated=0
    local bashrc=$HOME/.bashrc
    local config_text="export REG_CONFIG=${ROOT_DIR}"
    local storage_text="export REG_STORAGE="

    if ! grep -xq "${config_text}" $bashrc; then
        printf "\n# Add config location:\n${config_text}\n" >> $bashrc
        local bashrc_updated=1
    fi

    if ! grep -q "${storage_text}" $bashrc; then
        local default_storage=${HOME}/storage
        read -p "Provide storage location [${default_storage}]: " STORAGE_LOCATION
        if [ -z ${STORAGE_LOCATION} ]; then
            STORAGE_LOCATION=${default_storage}
        fi

        printf "\n# Add storage location:\n${storage_text}${STORAGE_LOCATION}\n" >> $bashrc
        local bashrc_updated=1
    fi

    if [ "${bashrc_updated}" -eq 0 ]; then
        step_print "$bashrc is already updated"
    else
        step_print "$bashrc updated"
    fi

    step_done
}

install_system
