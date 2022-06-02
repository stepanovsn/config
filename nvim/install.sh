#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

printf "${cYellow}Nvim${cNone}\n"

# Install snaps
step_install_snaps "nvim --classic" universal-ctags

# Install nvim plugins
if ! nvim --headless +PlugUpgrade +PlugUpdate +qa &> /dev/null; then
    printf "\tFailed to update nvim plugins.\n\t${cRed}Failed.${cNone}\n\n"
fi
printf "\tNvim plugins updated.\n"

# Make config link
step_force_link $ROOT_DIR/nvim $HOME/.config/nvim

printf "\t${cGreen}Done.${cNone}\n\n"
