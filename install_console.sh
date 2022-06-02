#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

# Check that repository is clean
printf "${cYellow}Pre-check${cNone}\n"

if [[ "$(git status --porcelain)" ]]; then
    printf "\tThe config repo is not clean.\n\t${cRed}Failed.${cNone}\n\n"
    exit 1
fi
printf "\t${cGreen}Done.${cNone}\n\n"

# Run tasks
source $ROOT_DIR/internal/install.sh
source $ROOT_DIR/bash/install.sh
source $ROOT_DIR/other/install.sh
source $ROOT_DIR/lf/install.sh
source $ROOT_DIR/htop/install.sh
source $ROOT_DIR/rg/install.sh
source $ROOT_DIR/tmux/install.sh
source $ROOT_DIR/nvim/install.sh
