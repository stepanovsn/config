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

# Common functions
force_link () {
    if [ "$#" -ne 2 ]; then
        printf "\t${cRed}force_link() incorrect number of arguments${cNone}\n\n"
        exit 1
    fi

    rm -rf ${2}
    ln -sfn ${1} ${2}
}

minimize_path () {
    if [ "$#" -ne 1 ]; then
        printf "\t${cRed}minimize_path() incorrect number of arguments${cNone}\n\n"
        exit 1
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

upgrade_packages() {
    if [ "$#" -ne 1 ]; then
        printf "\t${cRed}upgrade_packages() incorrect number of arguments${cNone}\n\n"
        exit 1
    fi

    sudo apt upgrade -y ${1} &> /dev/null
    if [ $? != 0 ]; then
        printf "\tFailed to upgrade apt packages: ${1}\n\t${cRed}Failed.${cNone}\n\n"
        exit 1
    fi

    printf "\tApt packages upgraded.\n"
}
