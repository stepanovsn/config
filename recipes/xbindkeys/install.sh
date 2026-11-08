#!/bin/bash

step_upgrade_pacman xbindkeys
step_soft_link $RECIPE_DIR/.xbindkeysrc $HOME/.xbindkeysrc
step_done
