#!/bin/bash

step_install_snap "nvim --classic"

# Install nvim plugins
if ! nvim --headless +PlugUpgrade +PlugUpdate +qa &> /dev/null; then
    step_failed "Failed to update nvim plugins."
fi
step_print "Nvim plugins updated."

step_soft_link $ROOT_DIR/nvim $HOME/.config/nvim
step_print "Config link made."
step_done
