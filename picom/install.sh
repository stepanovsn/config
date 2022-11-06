#!/bin/bash

install_picom() {
    step_upgrade_pacman picom

    step_soft_link $ROOT_DIR/picom $HOME/.config/picom
    step_print "Config link made."

    step_done
}

install_picom
