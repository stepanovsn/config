#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh

printf "${cYellow}Htop${cNone}\n"

# Make links
force_link $ROOT_DIR/htop $HOME/.config/htop
printf "\tConfig link made.\n"

printf "\t${cGreen}Done.${cNone}\n\n"
