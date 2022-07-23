#!/bin/bash

function install_bash() {
    # Add to user's bashrc
    local bashrc=$HOME/.bashrc
    if [ ! -f $bashrc ]; then
        step_failed "$bashrc not found."
    fi

    local text_to_add="source ${ROOT_DIR}/bash/bashrc_post.sh"
    if grep -xq "${text_to_add}" $bashrc; then
        step_print "$bashrc is already updated."
    else
        printf "\n# Add custom bash settings:\n${text_to_add}\n" >> $bashrc
        step_print "$bashrc updated."
    fi

    # Add to root's bashrc
    local bashrc=/root/.bashrc
    if [ -z $(sudo find /root -maxdepth 1 -name .bashrc) ]; then
        step_failed "$bashrc not found."
    fi

    local text_to_add="source ${ROOT_DIR}/bash/bashrc_root_post.sh"
    if sudo grep -xq "${text_to_add}" $bashrc; then
        step_print "$bashrc is already updated."
    else
        printf "\n# Add custom bash settings:\n${text_to_add}\n" | sudo tee -a $bashrc &> /dev/null
        step_print "$bashrc updated."
    fi

    step_done
}

install_bash
