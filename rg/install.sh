#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

printf "${cYellow}Rg${cNone}\n"

# Upgrade apt packages
step_upgrade_apt_packages ripgrep

# Make links
step_force_link $ROOT_DIR/rg/.rgrc $HOME/.rgrc
printf "\tConfig link made.\n"

printf "\t${cGreen}Done.${cNone}\n\n"
