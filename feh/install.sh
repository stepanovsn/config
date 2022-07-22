#!/bin/bash

step_upgrade_apt feh
step_soft_link $ROOT_DIR/feh/.fehbg $HOME/.fehbg
step_print "Config link made."
step_done
