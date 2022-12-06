#!/bin/bash

if distro_arch; then
    step_upgrade_pacman tmux
else
    step_upgrade_apt tmux
fi

step_soft_link $ROOT_DIR/tmux/.tmux.conf $HOME/.tmux.conf
step_print "Config link made"
step_done
