#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

ALL_COMPONENTS=(
    "nvidia"
    "awesome"
    "feh"
    "other_system"
    "resources")

step_check_repo
step_get_components "$@"
step_install_components "${SELECTED_COMPONENTS[@]}"
