#!/bin/bash

install_bash() {
    # Add to user's bashrc
    local message_shown=0
    local bashrc_updated=0
    local bashrc=$HOME/.bashrc
    local bash_source_text="source ${ROOT_DIR}/bash/bashrc_post.sh"
    local distr_text="export REG_DISTRO=\"${REG_DISTRO}\""
    local machine_text="export REG_MACHINE=\"${REG_MACHINE}\""

    if [ ! -f $bashrc ]; then
        printf "#!/bin/bash\n" >> $bashrc
        step_warn "$bashrc not found. Default one will be created."
        local message_shown=1
    fi

    if ! grep -xq "${distr_text}" $bashrc; then
        printf "\n# Specify Linux distribution:\n${distr_text}\n" >> $bashrc
        local bashrc_updated=1
    fi

    if [ ! -z ${REG_MACHINE} ]; then
        if ! grep -xq "${machine_text}" $bashrc; then
            printf "\n# Specify machine profile:\n${machine_text}\n" >> $bashrc
            local bashrc_updated=1
        fi
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
        step_warn "$bashrc not found. Default one will be created."
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

    # Add default tmux session
    local tmux_main="$HOME/tmux_main.sh"
    if [ -f ${tmux_main} ]; then
        step_print "$tmux_main already exists."
    else
        local tmux_main_default="$ROOT_DIR/bash/tmux_main.sh"
        cp $tmux_main_default $tmux_main
        step_print "Default $tmux_main created."
    fi

    step_done
}

install_bash
