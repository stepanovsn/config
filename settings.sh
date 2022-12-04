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

    eClearLine='\033[2K'
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

    eClearLine=''
fi

# Print steps
step_title () {
    printf "${cCyan}$@${cNone}\n"
}

step_print () {
    printf "\t$@\n"
}

step_print_temporary () {
    printf "${eClearLine}\r\t$@"
}

step_print_final () {
    printf "${eClearLine}\r\t$@\n"
}

step_failed () {
    printf "\t$@\n"
    printf "\t${cRed}Failed.${cNone}\n"
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

step_service_activate () {
    if [ "$#" -ne 1 ]; then
        step_failed "step_service_activate() incorrect number of arguments."
    fi

    if ! sudo systemctl enable ${1}.service; then
        step_failed "Systemd service \"${1}\" failed to enable."
    fi

    if ! sudo systemctl start ${1}.service; then
        step_failed "Systemd service \"${1}\" failed to start."
    fi

    if ! systemctl is-active --quiet snapd; then
        step_failed "Systemd service \"${1}\" failed to activate."
    fi

    step_print "Systemd service \"${1}\" activated."
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
            step_print_temporary "Apt packages upgraded: $count/$#"
        fi
    done

    if [ $count != 0 ]; then
        step_print_final "Apt packages upgraded: $count"
    fi

    if [[ $failed_packages ]]; then
        step_warn "Apt packages skipped:$failed_packages"
    fi
}

step_upgrade_pacman() {
    local count=0
    local failed_packages=""
    local package
    for package in "$@"
    do
        sudo pacman -S --noconfirm $package &> /dev/null
        if [ $? != 0 ]; then
            failed_packages+=" $package"
        else
            count=$((count + 1))
            step_print_temporary "Pacman packages upgraded: $count/$#"
        fi
    done

    if [ $count != 0 ]; then
        step_print_final "Pacman packages upgraded: $count"
    fi

    if [[ $failed_packages ]]; then
        step_warn "Pacman packages skipped:$failed_packages"
    fi
}

step_remove_pacman() {
    local count=0
    local failed_packages=""
    local package
    for package in "$@"
    do
        if ! pacman -Q $package &> /dev/null; then
            continue
        fi

        sudo pacman -R --noconfirm $package &> /dev/null
        if [ $? != 0 ]; then
            failed_packages+=" $package"
        else
            count=$((count + 1))
            step_print_temporary "Pacman packages removed: $count/$#"
        fi
    done

    if [ $count != 0 ]; then
        step_print_final "Pacman packages remove: $count"
    fi

    if [[ $failed_packages ]]; then
        step_warn "Failed to remove pacman packages:$failed_packages"
    fi
}

step_upgrade_aur() {
    local count=0
    local failed_packages=""
    local package
    for package in "$@"
    do
        local package_path=$HOME/.aur/$package
        mkdir -p $package_path
        cd $package_path
        if [ -z "$(ls -A)" ]; then
            if ! git clone https://aur.archlinux.org/${package}.git . &> /dev/null; then
                failed_packages+=" $package"
                continue
            fi
        elif ! git pull &> /dev/null; then
            failed_packages+=" $package"
            continue
        fi

        makepkg -si --noconfirm &> /dev/null
        if [ $? != 0 ]; then
            failed_packages+=" $package"
        else
            count=$((count + 1))
            step_print_temporary "Aur packages upgraded: $count/$#"
        fi
    done

    if [ $count != 0 ]; then
        step_print_final "Aur packages upgraded: $count"
    fi

    if [[ $failed_packages ]]; then
        step_warn "Aur packages skipped:$failed_packages"
    fi
}

step_install_snap() {
    if ! systemctl is-active --quiet snapd; then
        step_failed "Snaps can't be installed. snapd is not running."
    fi

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
            step_print_temporary "Snaps installed: $count/$#"
        fi
    done

    if [ $count != 0 ]; then
        step_print_final "Snaps installed: $count"
    fi

    if [[ $failed_snaps ]]; then
        step_warn "Snaps skipped:$failed_snaps"
        return 1
    else
        return 0
    fi
}

step_check_repo () {
    step_title "Pre-check"

    if [ ${#REG_DISTRO_LIST[@]} -ne 0 ]; then
        if [ -z "${REG_DISTRO}" ]; then
            local error_message="Distro isn't set. Possible options are: ${REG_DISTRO_LIST[@]}"
            step_failed "${error_message}"
        fi

        if [[ ! " ${REG_DISTRO_LIST[*]} " =~ " ${REG_DISTRO} " ]]; then
            local error_message="Distro \"${REG_DISTRO}\" is incorrect. Possible options are: ${REG_DISTRO_LIST[@]}"
            step_failed "${error_message}"
        fi
    fi
    step_print "Distro checked."

    if [ ${#REG_MACHINE_LIST[@]} -ne 0 ]; then
        if [ -z "${REG_MACHINE}" ]; then
            local error_message="Machine isn't set. Possible options are: ${REG_MACHINE_LIST[@]}"
            step_failed "${error_message}"
        fi

        if [[ ! " ${REG_MACHINE_LIST[*]} " =~ " ${REG_MACHINE} " ]]; then
            local error_message="Machine \"${REG_MACHINE}\" is incorrect. Possible options are: ${REG_MACHINE_LIST[@]}"
            step_failed "${error_message}"
        fi
    fi
    step_print "Machine checked."

    if [[ "$(git status --porcelain)" ]]; then
        step_warn "The config repo is not clean."
    else
        step_print "The config repo is clean."
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

distro_arch() {
    if [ "${REG_DISTRO}" == "ARCH" ]; then
        return 0
    fi
    return 1
}

distro_ubuntu() {
    if [ "${REG_DISTRO}" == "UBUNTU" ]; then
        return 0
    fi
    return 1
}
