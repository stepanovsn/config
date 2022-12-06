#!/bin/bash

install_gdb() {
    if distro_arch; then
        step_upgrade_pacman gdb
    else
        step_upgrade_apt gdb
    fi

    local gdb_dir=$HOME/.gdbinit.d
    step_reset_dir $gdb_dir
    step_soft_link $ROOT_DIR/gdb/.gdbinit $HOME/.gdbinit
    step_soft_link $ROOT_DIR/gdb/init $gdb_dir/init

    step_done
}

install_gdb
