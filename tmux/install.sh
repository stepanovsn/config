#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

step_title "Tmux"
step_upgrade_apt_packages tmux
step_force_link $ROOT_DIR/tmux/.tmux.conf $HOME/.tmux.conf
step_print "Config link made."
step_done
