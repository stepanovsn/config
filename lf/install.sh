#!/bin/bash

install_lf() {
    # Download required version
    local version=r27
    if $(command -v lf &> /dev/null) && [ $(lf --version) == $version ]; then
        step_print "Required version ${version} is already installed."
    else
        local url="https://github.com/gokcehan/lf/releases/download/${version}/lf-linux-amd64.tar.gz"
        local archive_dir=/tmp/lf
        local archive_path=$archive_dir/lf.tar.gz
        sudo rm -rf $archive_dir && mkdir $archive_dir
        step_print "Loading ${version} version.."
        if ! wget -O $archive_path $url > /dev/null 2>&1; then
            step_failed "Unable to download the required version from ${url}"
        fi

        if ! tar xvzf $archive_path -C $archive_dir > /dev/null 2>&1; then
            step_failed "Failed to untar ${archive_path}"
        fi

        local dest_dir="/usr/bin/"
        sudo mv $archive_dir/lf $dest_dir
        step_print "The executable is placed into ${dest_dir}"
    fi

    if distr_arch; then
        step_upgrade_pacman highlight source-highlight mediainfo w3m
    else
        step_upgrade_apt highlight source-highlight mediainfo w3m
    fi

    step_soft_link $ROOT_DIR/lf $HOME/.config/lf
    step_print "Config link made."

    sudo chmod u+x $ROOT_DIR/lf/preview.sh
    step_print "preview.sh rights set."

    step_done
}

install_lf
