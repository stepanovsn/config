#!/bin/bash

if distr_arch; then
    step_upgrade_pacman feh
else
    step_upgrade_apt feh
fi

step_soft_link $ROOT_DIR/feh/.fehbg $HOME/.fehbg
step_print "Config link made."
step_done
