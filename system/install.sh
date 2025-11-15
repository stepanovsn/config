#!/bin/bash

install_system() {
    local packages=(
        "alsa-utils"
        "chromium"
        "bluez-utils"
        "firefox"
        "evince"
        "gedit"
        "libreoffice-still"
        "obs-studio"
        "pulseaudio"
        "pulseaudio-alsa"
        "pulseaudio-bluetooth"
        "pulseaudio-jack"
        "scrot"
        "slock"
        "telegram-desktop"
        "terminus-font"
        "thunar"
        "tlp"
        "tumbler"
        "vlc"
        "xclip"
    )

    step_upgrade_pacman ${packages[@]}
    step_service_activate bluetooth
    step_service_activate tlp
    step_install_snap stellarium-daily

    local bashrc=$HOME/.bashrc

    local config_text="export REG_CONFIG_DIR"
    insert_text_info_file "${bashrc}" "${config_text}=${ROOT_DIR}" "${config_text}" "${REG_NON_COMMENT_LINE}"

    local storage_text="export REG_STORAGE_DIR"
    if ! grep -q "${storage_text}" $bashrc; then
        local default_storage=${HOME}/storage
        read -p "Provide storage location [${default_storage}]: " STORAGE_LOCATION
        if [ -z ${STORAGE_LOCATION} ]; then
            STORAGE_LOCATION=${default_storage}
        fi

        insert_text_info_file "${bashrc}" "${storage_text}=${STORAGE_LOCATION}" "${storage_text}" "${REG_NON_COMMENT_LINE}"
    fi

    step_print "$bashrc updated"

    local vconsole_conf="/etc/vconsole.conf"
    if ! [ -f $vconsole_conf ]; then
        step_failed "$vconsole_conf not found"
    else
        local font="FONT=ter-v20n"
        if ! grep -q "${font}" $vconsole_conf; then
            step_failed "Vt font is not set or incorrect"
        fi
        step_print "Vt font is correct"
    fi

    local screenshots_dir=$HOME/screenshots
    mkdir -p "$screenshots_dir"
    step_print "$screenshots_dir created"

    # Chromium bookmarks
    local bookmark_file=
    if [ -n "${REG_STORAGE_DIR}" ]; then
        bookmark_file="${REG_STORAGE_DIR}/data/chromium/bookmarks"
    elif [ -n "${STORAGE_LOCATION}" ]; then
        bookmark_file="${STORAGE_LOCATION}/data/chromium/bookmarks"
    fi

    local chromium_dir="${HOME}/.config/chromium/Default"
    if [ ! -f "${bookmark_file}" ]; then
        step_warn "Chromium bookmark file doesn't exists (${bookmark_file})"
    elif [ ! -d "${chromium_dir}" ]; then
        step_warn "Chromium directory doesn't exists (${chromium_dir})"
    else
        step_soft_link ${bookmark_file} ${chromium_dir}/Bookmarks
    fi

    # Login
    step_replace_file_sudo /etc/systemd/logind.conf.d/logind.conf $ROOT_DIR/system/systemd_configs/logind.conf

    step_done
}

install_system
