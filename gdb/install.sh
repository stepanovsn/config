#!/bin/bash

function install_gdb() {
    local gdb_dir=$HOME/.gdbinit.d
    rm -rf $gdb_dir && mkdir $gdb_dir
    step_soft_link $ROOT_DIR/gdb/.gdbinit $HOME/.gdbinit
    step_soft_link $ROOT_DIR/gdb/init $gdb_dir/init
    step_print "Config links made."

    step_done
}

install_gdb
