#!/bin/bash

install_other_system() {
    local packages=(
        "autorandr"
        "picom"
        "pulseaudio"
        "pulseaudio-alsa"
        "pulseaudio-jack"
        "xorg-xrandr"
        "xterm")

    if distr_arch; then
        step_upgrade_pacman ${packages[@]}
    else
        step_upgrade_apt ${packages[@]}
    fi

    local font_dir="/usr/share/fonts/googlefonts"
    sudo rm -rf ${font_dir} && sudo mkdir ${font_dir}
    sudo cp -r $ROOT_DIR/other_system/roboto_mono/* ${font_dir}
    sudo chmod -R ugo+rwx ${font_dir}
    if ! sudo fc-cache -fv > /dev/null; then
        step_failed "Failed to update fonts"
    fi
    step_print "Roboto Mono font installed."

    step_soft_link $ROOT_DIR/other_system/.xinitrc $HOME/.xinitrc
    step_soft_link $ROOT_DIR/other_system/.xprofile $HOME/.xprofile
    step_soft_link $ROOT_DIR/other_system/.Xresources $HOME/.Xresources
    step_print "Config links made."

    if ! xrdb -merge ~/.Xresources > /dev/null; then
        step_failed "Failed to merge Xresources"
    fi
    step_print "Xresources merged."

    if ! sudo localectl --no-convert set-x11-keymap us,ru pc104 qwerty grp:alt_shift_toggle > /dev/null; then
        step_failed "Failed to set keyboard layout"
    fi
    step_print "Keyboard layout set."

    step_done
}

install_other_system
