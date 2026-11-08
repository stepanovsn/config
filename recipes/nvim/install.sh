#!/bin/bash

install_nvim() {
    if distro_arch; then
        step_upgrade_pacman neovim python-pynvim
    else
        step_install_snap "nvim --classic"
    fi

    step_soft_link $RECIPE_DIR $HOME/.config/nvim
    step_done
}

install_nvim
