#!/bin/bash

install_gdb() {
    if distro_arch; then
        step_upgrade_pacman gdb
    else
        step_upgrade_apt gdb
    fi

    step_soft_link $RECIPE_DIR/.gdbinit $HOME/.gdbinit
    step_done
}

install_gdb
