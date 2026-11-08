#!/bin/bash

if distro_arch; then
    step_upgrade_pacman ripgrep
else
    step_upgrade_apt ripgrep
fi

step_soft_link $RECIPE_DIR/.rgrc $HOME/.rgrc
step_done
