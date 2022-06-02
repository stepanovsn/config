#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

printf "${cYellow}Bash${cNone}\n"

# Add to user's bashrc
bashrc=$HOME/.bashrc
if [ ! -f $bashrc ]; then
    printf "\t$bashrc not found.\n\t${cRed}Failed.${cNone}\n\n"
    exit 1
fi

text_to_add="source $ROOT_DIR/bash/bashrc_post.sh"
if grep -xq "${text_to_add}" $bashrc; then
    printf "\t$bashrc is already updated.\n"
else
    printf "\n# Add custom bash settings:\n${text_to_add}\n" >> $bashrc
    printf "\t$bashrc updated.\n"
fi

# Add to root's bashrc
bashrc=/root/.bashrc
if [ -z $(sudo find /root -maxdepth 1 -name .bashrc) ]; then
    printf "\t$bashrc not found.\n\t${cRed}Failed.${cNone}\n\n"
    exit 1
fi

text_to_add="source $ROOT_DIR/bash/bashrc_root_post.sh"
if sudo grep -xq "${text_to_add}" $bashrc; then
    printf "\t$bashrc is already updated.\n"
else
    printf "\n# Add custom bash settings:\n${text_to_add}\n" | sudo tee -a $bashrc &> /dev/null
    printf "\t$bashrc updated.\n"
fi

printf "\t${cGreen}Done.${cNone}\n\n"
