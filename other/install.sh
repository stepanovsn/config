#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

printf "${cYellow}Other${cNone}\n"

upgrade_packages "tar zip unzip rar unrar \
    moreutils ncdu net-tools hwinfo minicom \
    git cmake clang-tidy \
    mmv termshark ncal fzf"

printf "\t${cGreen}Done.${cNone}\n\n"
