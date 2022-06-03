#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

step_title "Nvim"
step_install_snaps "nvim --classic" universal-ctags

# Install nvim plugins
if ! nvim --headless +PlugUpgrade +PlugUpdate +qa &> /dev/null; then
    step_failed "Failed to update nvim plugins."
fi
step_print "Nvim plugins updated."

step_force_link $ROOT_DIR/nvim $HOME/.config/nvim
step_print "Config link made."
step_done
