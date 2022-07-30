#!/bin/bash

if distr_arch; then
    step_upgrade_pacman autorandr picom
else
    step_upgrade_apt autorandr picom
fi

step_soft_link $ROOT_DIR/other_gui/.xprofile $HOME/.xprofile
step_print "Config link made."
step_done
