#!/bin/bash

step_upgrade_pacman picom
step_soft_link $ROOT_DIR/picom $HOME/.config/picom
step_done
