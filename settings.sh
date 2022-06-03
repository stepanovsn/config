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

# Main steps
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
step_force_link () {
    if [ "$#" -ne 2 ]; then
        step_failed "step_force_link() incorrect number of arguments."
    fi

    rm -rf ${2}
    ln -sfn ${1} ${2}
}

step_upgrade_apt_packages() {
    sudo apt upgrade -y $@ &> /dev/null
    if [ $? != 0 ]; then
        step_failed "Failed to upgrade apt packages: ${@}"
    fi

    step_print "Apt packages upgraded."
}

step_install_snaps() {
    for package in "$@"
    do
        sudo snap install $package &> /dev/null
        if [ $? != 0 ]; then
            step_failed "Failed to install snap: $package"
        fi
    done

    step_print "Snaps installed."
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
