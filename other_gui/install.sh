#!/bin/bash

step_upgrade_apt autorandr picom
step_soft_link $ROOT_DIR/other_gui/.xprofile $HOME/.xprofile
step_print "Config link made."
step_done
