#!/bin/bash

step_upgrade_pacman picom
step_soft_link $RECIPE_DIR $HOME/.config/picom
step_done
