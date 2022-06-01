#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

printf "${cYellow}Tmux${cNone}\n"

# Upgrade apt packages
upgrade_packages "tmux"

# Make links
force_link $ROOT_DIR/tmux/.tmux.conf $HOME/.tmux.conf
printf "\tConfig link made.\n"

printf "\t${cGreen}Done.${cNone}\n\n"
