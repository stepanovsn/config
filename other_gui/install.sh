#!/bin/bash

install_other_gui() {
    if distr_arch; then
        step_upgrade_pacman autorandr picom
    else
        step_upgrade_apt autorandr picom
    fi

    local font_dir="/usr/share/fonts/googlefonts"
    sudo rm -rf ${font_dir} && sudo mkdir ${font_dir}
    sudo cp -r $ROOT_DIR/other_gui/roboto_mono/* ${font_dir}
    sudo chmod -R ugo+rwx ${font_dir}
    if ! sudo fc-cache -fv > /dev/null; then
        step_failed "Failed to update fonts"
    fi
    step_print "Roboto Mono font installed."

    step_soft_link $ROOT_DIR/other_gui/.xinitrc $HOME/.xinitrc
    step_print ".xinitrc link made."

    step_soft_link $ROOT_DIR/other_gui/.xprofile $HOME/.xprofile
    step_print ".xprofile link made."

    step_done
}

install_other_gui
