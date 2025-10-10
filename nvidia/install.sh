#!/bin/bash

install_nvidia() {
    step_upgrade_pacman nvidia nvidia-utils nvidia-settings opencl-nvidia

    # Copy config
    sudo cp "${ROOT_DIR}/nvidia/10-nvidia-drm-outputclass.conf" "/etc/X11/xorg.conf.d/"
    sudo cp "${ROOT_DIR}/nvidia/10-nvidia-drm-outputclass.conf" "/usr/share/X11/xorg.conf.d/"
    sudo cp "${ROOT_DIR}/nvidia/nvidia-drm-nomodeset.conf" "/etc/modprobe.d/nvidia-drm-nomodeset.conf"
    step_print "Config files copied."

    step_print_temp "Updating initramfs.."
    run_command sudo mkinitcpio -P
    step_print "Initramfs reconstructed."

    step_done
}

install_nvidia
