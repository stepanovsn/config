#!/bin/bash

step_upgrade_apt ripgrep
step_soft_link $ROOT_DIR/rg/.rgrc $HOME/.rgrc
step_print "Config link made."
step_done
