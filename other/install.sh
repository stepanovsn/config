#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

step_title "Other"

# Update apt indices
sudo apt update &> /dev/null
step_print "Apt indices updated."

step_upgrade_apt tar zip unzip rar unrar \
    moreutils ncdu net-tools hwinfo minicom \
    git cmake clang-tidy \
    mmv termshark fzf ncal
step_done
