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
        printf "\t${cRed}force_link() incorrect arguments${cNone}\n"
        exit 1
    fi

    rm -rf ${2}
    ln -sfn ${1} ${2}
}
