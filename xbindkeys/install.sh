#!/bin/bash

step_upgrade_pacman xbindkeys
step_soft_link $ROOT_DIR/xbindkeys/.xbindkeysrc $HOME/.xbindkeysrc
step_print "Config link made"
step_done
