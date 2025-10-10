#!/bin/bash

install_nvim() {
    if distro_arch; then
        step_upgrade_pacman neovim python-pynvim
    else
        step_install_snap "nvim --classic"
    fi

    # Install vimplug
    local vimplug_file="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
    local vimplug_install="curl -fLo ${vimplug_file} --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    if [ -f ${vimplug_file} ]; then
        rm ${vimplug_file}
    fi

    step_print_temp "Installing Vimplug.."
    if ! run_command ${vimplug_install}; then
        step_failed "Failed to download vimplug"
    fi
    step_print "Vimplug installed"

    # Install nvim plugins
    step_print_temp "Installing nvim plugins.."
    if ! run_command nvim --headless +PlugUpgrade +PlugUpdate +qa; then
        step_failed "Failed to update nvim plugins"
    fi
    step_print "Nvim plugins updated"

    step_soft_link $ROOT_DIR/nvim $HOME/.config/nvim
    step_done
}

install_nvim
