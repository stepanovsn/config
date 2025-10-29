#!/bin/bash

install_nvim() {
    if distro_arch; then
        step_upgrade_pacman neovim python-pynvim
    else
        step_install_snap "nvim --classic"
    fi

    step_soft_link $ROOT_DIR/nvim $HOME/.config/nvim
    step_done
}

install_nvim
