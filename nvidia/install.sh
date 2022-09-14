#!/bin/bash

install_nvidia() {
    step_upgrade_pacman nvidia xorg-xrandr

    # Copy config
    sudo cp "${ROOT_DIR}/nvidia/10-nvidia-drm-outputclass.conf" "/etc/X11/xorg.conf.d/"
    sudo cp "${ROOT_DIR}/nvidia/10-nvidia-drm-outputclass.conf" "/usr/share/X11/xorg.conf.d/"
    step_print "Config files copied."

    step_done
}

install_nvidia