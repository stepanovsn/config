#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

printf "${cYellow}Lf${cNone}\n"

# Download if required
version=r27

if $(command -v lf &> /dev/null) && [ $(lf --version) == $version ]; then
    printf "\tRequired version ${version} is already installed.\n"
else
    url="https://github.com/gokcehan/lf/releases/download/${version}/lf-linux-amd64.tar.gz"
    archive_dir=/tmp/lf
    archive_path=$archive_dir/lf.tar.gz
    sudo rm -rf $archive_dir && mkdir $archive_dir
    printf "\tLoading ${version} version.. "
    if ! wget -O $archive_path $url > /dev/null 2>&1; then
        printf "\n\tUnable to download the required version from ${url}\n\t${cRed}Failed.${cNone}\n\n"
        exit 1
    fi
    printf "Done.\n"

    if ! tar xvzf $archive_path -C $archive_dir > /dev/null 2>&1; then
        printf "\tFailed to untar ${archive_path}\n\t${cRed}Failed.${cNone}\n\n"
        exit 1
    fi

    dest_dir="/usr/bin/"
    sudo mv $archive_dir/lf $dest_dir
    printf "\tThe executable is placed into ${dest_dir}\n"
fi

# Make links
force_link $ROOT_DIR/lf $HOME/.config/lf
printf "\tConfig link made.\n"

# Set rights
sudo chmod u+x $ROOT_DIR/lf/preview.sh
printf "\tpreview.sh rights set.\n"

printf "\t${cGreen}Done.${cNone}\n\n"
