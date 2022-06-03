#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

step_title "Bash"

# Add to user's bashrc
bashrc=$HOME/.bashrc
if [ ! -f $bashrc ]; then
    step_failed "$bashrc not found."
fi

text_to_add="source $ROOT_DIR/bash/bashrc_post.sh"
if grep -xq "${text_to_add}" $bashrc; then
    step_print "$bashrc is already updated."
else
    printf "\n# Add custom bash settings:\n${text_to_add}\n" >> $bashrc
    step_print "$bashrc updated."
fi

# Add to root's bashrc
bashrc=/root/.bashrc
if [ -z $(sudo find /root -maxdepth 1 -name .bashrc) ]; then
    step_failed "$bashrc not found."
fi

text_to_add="source $ROOT_DIR/bash/bashrc_root_post.sh"
if sudo grep -xq "${text_to_add}" $bashrc; then
    step_print "$bashrc is already updated."
else
    printf "\n# Add custom bash settings:\n${text_to_add}\n" | sudo tee -a $bashrc &> /dev/null
    step_print "$bashrc updated."
fi

step_done
