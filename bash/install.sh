#!/bin/bash

install_bash() {
    # Add to user's bashrc
    local message_shown=0
    local bashrc_updated=0
    local bashrc=$HOME/.bashrc
    local bash_source_text="source ${ROOT_DIR}/bash/bashrc_post.sh"
    local distr_text="export DISTR=\"${DISTR}\""

    if [ ! -f $bashrc ]; then
        printf "#!/bin/bash\n" >> $bashrc
        step_warn "$bashrc not found. Default one created."
        local message_shown=1
    fi

    if ! grep -xq "${distr_text}" $bashrc; then
        printf "\n# Specify Linux distribution:\n${distr_text}\n" >> $bashrc
        local bashrc_updated=1
    fi

    if ! grep -xq "${bash_source_text}" $bashrc; then
        printf "\n# Add custom bash settings:\n${bash_source_text}\n" >> $bashrc
        local bashrc_updated=1
    fi

    if [ "${message_shown}" -eq 0 ]; then
        if [ "${bashrc_updated}" -eq 0 ]; then
            step_print "$bashrc is already updated."
        else
            step_print "$bashrc updated."
        fi
    fi

    # Add to root's bashrc
    local message_shown=0
    local bashrc_updated=0
    local bashrc=/root/.bashrc
    local bash_source_text="source ${ROOT_DIR}/bash/bashrc_root_post.sh"

    if [ -z $(sudo find /root -maxdepth 1 -name .bashrc) ]; then
        printf "#!/bin/bash\n" | sudo tee $bashrc > /dev/null
        step_warn "$bashrc not found. Default one created."
        local message_shown=1
    fi

    if ! sudo grep -xq "${bash_source_text}" $bashrc; then
        printf "\n# Add custom bash settings:\n${bash_source_text}\n" | sudo tee -a $bashrc &> /dev/null
        local bashrc_updated=1
    fi

    if [ "${message_shown}" -eq 0 ]; then
        if [ "${bashrc_updated}" -eq 0 ]; then
            step_print "$bashrc is already updated."
        else
            step_print "$bashrc updated."
        fi
    fi

    step_done
}

install_bash
