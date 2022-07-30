#!/bin/bash

install_xterm() {
    if distr_arch; then
        step_upgrade_pacman xterm
    else
        step_upgrade_apt xterm
    fi

    step_soft_link $ROOT_DIR/xterm/.Xresources $HOME/.Xresources
    step_print "Config link made."

    xrdb -merge ~/.Xresources
    step_print "Xresources merged."

    step_done
}

install_xterm
