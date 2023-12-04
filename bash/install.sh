#!/bin/bash

install_bash() {
    # Add to user's bashrc
    local bashrc=$HOME/.bashrc
    if [ ! -f $bashrc ]; then
        step_warn "$bashrc not found. Default one will be created"
        printf "#!/bin/bash\n" >> $bashrc
    fi

    local distr_text="export REG_DISTRO"
    insert_text_info_file "${bashrc}" "${distr_text}=${REG_DISTRO}" "${distr_text}" "${REG_NON_COMMENT_LINE}"

    if [ ! -z ${REG_MACHINE} ]; then
        local machine_text="export REG_MACHINE"
        insert_text_info_file "${bashrc}" "${machine_text}=${REG_MACHINE}" "${machine_text}" "${REG_NON_COMMENT_LINE}"
    fi

    local color_scheme_text="export REG_CONSOLE_COLOR_SCHEME"
    replace_text_in_file "${bashrc}" "${color_scheme_text}=${REG_CONSOLE_COLOR_SCHEME}" "${color_scheme_text}" "${REG_NON_COMMENT_LINE}"

    local bash_source_text="source ${ROOT_DIR}/bash/bashrc_post.sh"
    insert_text_info_file "${bashrc}" "${bash_source_text}" "${bash_source_text}"

    step_print "$bashrc updated"

    # Add to root's bashrc
    local bash_source_text="source ${ROOT_DIR}/bash/bashrc_root_post.sh"

    local bashrc=/root/.bashrc
    if [ -z $(sudo find /root -maxdepth 1 -name .bashrc) ]; then
        step_warn "$bashrc not found. Default one will be created"
        printf "#!/bin/bash\n" | sudo tee $bashrc &> /dev/null
    fi

    if ! sudo grep -xq "${bash_source_text}" $bashrc; then
        sudo sed -i "\$a\\${bash_source_text}" $bashrc
    fi

    step_print "$bashrc updated"

    # Add default tmux session
    local tmux_main="$HOME/tmux_main.sh"
    if [ -f ${tmux_main} ]; then
        step_print "$tmux_main already exists"
    else
        local tmux_main_default="$ROOT_DIR/bash/tmux_main.sh"
        cp $tmux_main_default $tmux_main
        step_print "Default $tmux_main created"
    fi

    step_done
}

install_bash
