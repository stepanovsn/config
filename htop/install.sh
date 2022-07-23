#!/bin/bash

step_upgrade_apt htop
step_soft_link $ROOT_DIR/htop $HOME/.config/htop
step_print "Config link made."
step_done
