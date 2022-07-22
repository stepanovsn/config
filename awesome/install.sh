#!/bin/bash

step_upgrade_apt awesome
step_soft_link $ROOT_DIR/awesome $HOME/.config/awesome
step_print "Config link made."
step_done
