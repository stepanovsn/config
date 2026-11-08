#!/bin/bash

if distro_arch; then
    step_upgrade_pacman htop
else
    step_upgrade_apt htop
fi

step_soft_link $RECIPE_DIR $HOME/.config/htop
step_done
