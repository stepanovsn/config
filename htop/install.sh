#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

step_title "Htop"
step_upgrade_apt htop
step_soft_link $ROOT_DIR/htop $HOME/.config/htop
step_print "Config link made."
step_done
