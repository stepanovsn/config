#!/bin/bash

if distro_arch; then
    step_upgrade_pacman awesome
else
    step_upgrade_apt awesome
fi

step_soft_link $ROOT_DIR/awesome $HOME/.config/awesome
step_print "Config link made"
step_done
