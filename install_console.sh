#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

# Run tasks
printf "\n"

source $ROOT_DIR/internal/install.sh
source $ROOT_DIR/lf/install.sh
source $ROOT_DIR/htop/install.sh
source $ROOT_DIR/rg/install.sh
source $ROOT_DIR/tmux/install.sh
source $ROOT_DIR/other/install.sh
