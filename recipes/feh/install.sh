#!/bin/bash

step_upgrade_pacman feh
step_soft_link $RECIPE_DIR/.fehbg $HOME/.fehbg
step_done
