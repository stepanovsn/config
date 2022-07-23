#!/bin/bash

step_upgrade_apt tmux
step_soft_link $ROOT_DIR/tmux/.tmux.conf $HOME/.tmux.conf
step_print "Config link made."
step_done
