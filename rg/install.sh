#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

step_title "Rg"
step_upgrade_apt ripgrep
step_force_link $ROOT_DIR/rg/.rgrc $HOME/.rgrc
step_print "Config link made."
step_done
