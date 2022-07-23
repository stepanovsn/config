#!/bin/bash

# Update apt indices
sudo apt update &> /dev/null
step_print "Apt indices updated."

step_upgrade_apt tar zip unzip rar unrar \
    moreutils ncdu net-tools hwinfo minicom \
    git cmake clang-tidy \
    mmv termshark fzf ncal alsa-utils \
    dosfstools mtools
step_done
