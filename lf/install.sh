#!/bin/bash

install_lf() {
    # Download required version
    local version=r31
    if $(command -v lf &> /dev/null) && [ $(lf --version) == $version ]; then
        step_print "Required version ${version} is already installed."
    else
        local url="https://github.com/gokcehan/lf/releases/download/${version}/lf-linux-amd64.tar.gz"
        local archive_dir=/tmp/lf
        local archive_path=$archive_dir/lf.tar.gz

        step_reset_dir $archive_dir
        step_wget $url $archive_path
        step_untar $archive_path $archive_dir

        local dest_dir="/usr/bin/"
        sudo mv $archive_dir/lf $dest_dir
        step_print "The executable is placed into ${dest_dir}"
    fi

    if distro_arch; then
        step_upgrade_pacman highlight source-highlight mediainfo w3m
    else
        step_upgrade_apt highlight source-highlight mediainfo w3m
    fi

    step_soft_link $ROOT_DIR/lf $HOME/.config/lf

    sudo chmod u+x $ROOT_DIR/lf/preview.sh
    step_print "preview.sh rights set"

    step_done
}

install_lf
