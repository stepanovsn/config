#!/bin/bash

install_ctags() {
    if distro_arch; then
        step_upgrade_pacman universal-ctags
    else
        step_install_snap universal-ctags
    fi

    local ctags_dir=$HOME/.ctags.d
    rm -rf $ctags_dir && mkdir $ctags_dir
    step_hard_link $ROOT_DIR/ctags/default.ctags $ctags_dir/default.ctags
    step_print "Config link made."
    step_done
}

install_ctags
