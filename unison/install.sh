#!/bin/bash

if distro_arch; then
    step_upgrade_pacman unison
else
    step_upgrade_apt unison
fi

mkdir -p $HOME/.unison
step_soft_link "$ROOT_DIR/unison/storage.prf" $HOME/.unison/storage.prf
step_done
