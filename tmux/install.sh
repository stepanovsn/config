#!/bin/bash

if distro_arch; then
    step_upgrade_pacman tmux
else
    step_upgrade_apt tmux
fi

step_soft_link "$ROOT_DIR/tmux/color_schemes/.tmux.conf_${REG_CONSOLE_COLOR_SCHEME}" $HOME/.tmux.conf
step_done
