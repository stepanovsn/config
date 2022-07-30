#!/bin/bash

if distr_arch; then
    step_upgrade_pacman htop
else
    step_upgrade_apt htop
fi

step_soft_link $ROOT_DIR/htop $HOME/.config/htop
step_print "Config link made."
step_done
