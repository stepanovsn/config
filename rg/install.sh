#!/bin/bash

if distro_arch; then
    step_upgrade_pacman ripgrep
else
    step_upgrade_apt ripgrep
fi

step_soft_link $ROOT_DIR/rg/.rgrc $HOME/.rgrc
step_done
