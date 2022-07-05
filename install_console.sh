#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

# Check that repository is clean
step_title "Pre-check"
if [[ "$(git status --porcelain)" ]]; then
    step_warn "The config repo is not clean."
fi
step_done

# Run tasks
source $ROOT_DIR/internal/install.sh
source $ROOT_DIR/bash/install.sh
source $ROOT_DIR/other/install.sh
source $ROOT_DIR/lf/install.sh
source $ROOT_DIR/htop/install.sh
source $ROOT_DIR/rg/install.sh
source $ROOT_DIR/tmux/install.sh
source $ROOT_DIR/python/install.sh
source $ROOT_DIR/nvim/install.sh
source $ROOT_DIR/ctags/install.sh
source $ROOT_DIR/gdb/install.sh
