#!/bin/bash

# Common variables
if [ -t 1 ]; then
    cNone='\e[0m'
    cBlack='\e[0;30m'
    cRed='\e[0;31m'
    cGreen='\e[0;32m'
    cYellow='\e[0;33m'
    cBlue='\e[0;34m'
    cPurple='\e[0;35m'
    cCyan='\e[0;36m'
    cWhite='\e[0;37m'
else
    cNone=''
    cBlack=''
    cRed=''
    cGreen=''
    cYellow=''
    cBlue=''
    cPurple=''
    cCyan=''
    cWhite=''
fi

# Print steps
step_title () {
    printf "${cCyan}$@${cNone}\n"
}

step_print () {
    printf "\t$@\n"
}

step_failed () {
    printf "\t${cRed}$@${cNone}\n"
    exit 1
}

step_warn () {
    printf "\t${cYellow}$@${cNone}\n"
}

step_done () {
    printf "\t${cGreen}Done.${cNone}\n"
}

# Other steps
step_soft_link () {
    if [ "$#" -ne 2 ]; then
        step_failed "step_soft_link() incorrect number of arguments."
    fi

    rm -rf ${2}
    ln -sfn ${1} ${2}
}

step_hard_link () {
    if [ "$#" -ne 2 ]; then
        step_failed "step_hard_link() incorrect number of arguments."
    fi

    ln -fn ${1} ${2}
}

step_upgrade_apt() {
    local count=0
    local failed_packages=""
    local package
    for package in "$@"
    do
        sudo apt upgrade -y $package &> /dev/null
        if [ $? != 0 ]; then
            failed_packages+=" $package"
        else
            count=$((count + 1))
        fi
    done

    if [ $count != 0 ]; then
        step_print "$count apt packages upgraded."
    fi

    if [[ $failed_packages ]]; then
        step_warn "Skipped apt packages:$failed_packages"
    fi
}

step_install_snap() {
    count=0
    failed_snaps=""
    local snap
    for snap in "$@"
    do
        sudo snap install $snap &> /dev/null
        if [ $? != 0 ]; then
            failed_snaps+=" $snap"
        else
            count=$((count + 1))
        fi
    done

    if [ $count != 0 ]; then
        step_print "$count snaps installed."
    fi

    if [[ $failed_snaps ]]; then
        step_warn "Skipped snaps:$failed_snaps"
    fi
}

step_check_repo () {
    step_title "Pre-check"
    if [[ "$(git status --porcelain)" ]]; then
        step_warn "The config repo is not clean."
    else
        step_done
    fi
}

step_get_components () {
    SELECTED_COMPONENTS=()
    if [ "$#" -ne 0 ]; then
        local selected
        for selected in "$@"
        do
            SELECTED_COMPONENTS+=($selected)
        done
    else
        SELECTED_COMPONENTS=("${ALL_COMPONENTS[@]}")
    fi
}

step_install_components () {
    local component
    for component in "$@"
    do
        local component_name=${component^}
        step_title "${component_name//_/ }"

        local install_script="${ROOT_DIR}/${component}/install.sh"
        if [ -f ${install_script} ]; then
            source ${install_script}
        else
            step_warn "Install script not found"
        fi
    done
}

# Common functions
minimize_path () {
    if [ "$#" -ne 1 ]; then
        step_failed "minimize_path() incorrect number of arguments."
    fi

    echo $(sed \
        -e ':a' -e 's|/\./|/|g' -e 't a' \
        -e ':b' -e 's|/\.$|/|g' -e 't b' \
        -e ':c' -e 's|/[^/]*/\.\./|/|' -e 't c' \
        -e ':d' -e 's|/[^/]*/\.\.$|/|' -e 't d' \
        -e ':e' -e 's|//|/|g' -e 't e' \
        -e ':f' -e '/^.\{2,\}$/ s|/$||g' -e 't f' \
        <<< ${1})
}
