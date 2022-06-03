#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

step_title "Lf"

# Download required version
version=r27
if $(command -v lf &> /dev/null) && [ $(lf --version) == $version ]; then
    step_print "Required version ${version} is already installed."
else
    url="https://github.com/gokcehan/lf/releases/download/${version}/lf-linux-amd64.tar.gz"
    archive_dir=/tmp/lf
    archive_path=$archive_dir/lf.tar.gz
    sudo rm -rf $archive_dir && mkdir $archive_dir
    step_print "Loading ${version} version.."
    if ! wget -O $archive_path $url > /dev/null 2>&1; then
        step_failed "Unable to download the required version from ${url}"
    fi

    if ! tar xvzf $archive_path -C $archive_dir > /dev/null 2>&1; then
        step_failed "Failed to untar ${archive_path}"
    fi

    dest_dir="/usr/bin/"
    sudo mv $archive_dir/lf $dest_dir
    step_print "The executable is placed into ${dest_dir}"
fi

step_upgrade_apt highlight source-highlight mediainfo w3m
step_force_link $ROOT_DIR/lf $HOME/.config/lf
step_print "Config link made."

sudo chmod u+x $ROOT_DIR/lf/preview.sh
step_print "preview.sh rights set."

step_done
