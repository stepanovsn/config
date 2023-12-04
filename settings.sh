#!/bin/bash

case "${REG_CONSOLE_COLOR_SCHEME,,}" in
    "moonlight");;
    "pure");;
    *) export REG_CONSOLE_COLOR_SCHEME="moonlight";;
esac

export REG_NON_COMMENT_LINE="\\(^\\s*[^\\s#].*$\\|^$\\)"

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
    eCarriageRet='\r'
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
    eCarriageRet=''
fi

# Print steps
step_title () {
    printf "${eClearLine}${eCarriageRet}${cCyan}${@}${cNone}\n"
}

step_print () {
    printf "${eClearLine}${eCarriageRet}\t${@}\n"
}

step_print_temp () {
    if [ -t 1 ]; then
        local limit=$(($(tput cols)-9))
        if [ $limit -gt 2 ]; then
            local message=${@}
            if [ ${#message} -gt $limit ]; then
                local message="${message:0:$((limit))-2}.."
            fi

            printf "${eClearLine}${eCarriageRet}\t${message}"
        fi
    fi
}

step_failed () {
    printf "${eClearLine}${eCarriageRet}\t${cRed}${@}${cNone}\n"
    exit 1
}

step_warn () {
    printf "${eClearLine}${eCarriageRet}\t${cYellow}${@}${cNone}\n"
}

step_done () {
    printf "${eClearLine}${eCarriageRet}\t${cGreen}Done${cNone}\n"
}

# Other steps
step_soft_link () {
    if [ "$#" -ne 2 ]; then
        step_failed "step_soft_link() incorrect number of arguments"
    fi

    if ! rm -rf ${2} &> /dev/null; then
        step_failed "Failed to create soft link \"${1}\" -> \"${2}\""
    fi

    if ! ln -sfn ${1} ${2} &> /dev/null; then
        step_failed "Failed to create soft link \"${1}\" -> \"${2}\""
    fi

    step_print "Created soft link: \"${1}\" -> \"${2}\""
}

step_hard_link () {
    if [ "$#" -ne 2 ]; then
        step_failed "step_hard_link() incorrect number of arguments"
    fi

    if ! ln -fn ${1} ${2} &> /dev/null; then
        step_failed "Failed to create hard link \"${1}\" -> \"${2}\""
    fi

    step_print "Created hard link: \"${1}\" -> \"${2}\""
}

step_replace_file_sudo () {
    if [ "$#" -ne 2 ]; then
        step_failed "step_replace_file_sudo() incorrect number of arguments"
    fi

    if ! sudo mkdir -p $(dirname ${1}) &> /dev/null; then
        step_failed "Failed to replace file \"${2}\" -> \"${1}\""
    fi

    if ! sudo rm -f ${1} &> /dev/null; then
        step_failed "Failed to replace file \"${2}\" -> \"${1}\""
    fi

    if ! sudo cp ${2} ${1} &> /dev/null; then
        step_failed "Failed to replace file \"${2}\" -> \"${1}\""
    fi

    step_print "File replaced: \"${2}\" -> \"${1}\""
}

step_reset_dir () {
    if [ "$#" -ne 1 ]; then
        step_failed "step_reset_dir() incorrect number of arguments"
    fi

    if ! rm -rf ${1} &> /dev/null; then
        step_failed "Failed to reset dir ${1}"
    fi

    if ! mkdir -p ${1} &> /dev/null; then
        step_failed "Failed to reset dir ${1}"
    fi
}

step_reset_dir_sudo () {
    if [ "$#" -ne 1 ]; then
        step_failed "step_reset_dir() incorrect number of arguments"
    fi

    if ! sudo rm -rf ${1} &> /dev/null; then
        step_failed "Failed to reset dir ${1}"
    fi

    if ! sudo mkdir -p ${1} &> /dev/null; then
        step_failed "Failed to reset dir ${1}"
    fi
}

step_wget () {
    if [ "$#" -ne 2 ]; then
        step_failed "step_wget() incorrect number of arguments"
    fi

    step_print_temp "Downloading \"${1}\" to \"${2}\" .."

    if ! wget -O ${2} ${1} &> /dev/null; then
        step_failed "Failed to download: ${1}"
    fi

    step_print "Downloaded \"${1}\" to \"${2}\""
}

step_untar () {
    if [ "$#" -ne 2 ]; then
        step_failed "step_untar() incorrect number of arguments"
    fi

    step_print_temp "Unpacking \"${1}\" to \"${2}\" .."

    if ! tar xvzf ${1} -C ${2} &> /dev/null; then
        step_failed "Failed to untar: ${1}"
    fi

    step_print "Unpacked \"${1}\" to \"${2}\""
}

step_service_activate () {
    if [ "$#" -ne 1 ]; then
        step_failed "step_service_activate() incorrect number of arguments"
    fi

    if ! sudo systemctl enable ${1}.service &> /dev/null; then
        step_failed "Systemd service \"${1}\" failed to enable"
    fi

    if ! sudo systemctl start ${1}.service &> /dev/null; then
        step_failed "Systemd service \"${1}\" failed to start"
    fi

    if ! systemctl is-active --quiet snapd &> /dev/null; then
        step_failed "Systemd service \"${1}\" failed to activate"
    fi

    step_print "Systemd service \"${1}\" activated"
}

step_upgrade_apt() {
    if [ "$#" -eq 0 ]; then
        step_failed "step_upgrade_apt() incorrect number of arguments"
    fi

    step_print_temp "Upgrading ${#} apt packages.."

    local packages="${@}"
    if ! sudo apt upgrade -y ${packages} &> /dev/null; then
        step_failed "Failed to upgrade apt packages: ${packages}"
    fi

    step_print "Upgraded ${#} apt packages"
}

step_upgrade_pacman() {
    if [ "$#" -eq 0 ]; then
        step_failed "step_upgrade_pacman() incorrect number of arguments"
    fi

    step_print_temp "Upgrading ${#} pacman packages.."

    local packages="${@}"
    if ! sudo pacman -S --noconfirm ${packages} &> /dev/null; then
        step_failed "Failed to upgrade pacman packages: ${packages}"
    fi

    step_print "Upgraded ${#} pacman packages"
}

step_remove_pacman() {
    if [ "$#" -eq 0 ]; then
        step_failed "step_remove_pacman() incorrect number of arguments"
    fi

    step_print_temp "Removing ${#} pacman packages.."

    local packages="${@}"
    if ! sudo pacman -R --noconfirm ${packages} &> /dev/null; then
        step_failed "Failed to remove pacman packages: ${packages}"
    fi

    step_print "Removed ${#} pacman packages"
}

step_upgrade_yay() {
    if [ "$#" -eq 0 ]; then
        step_failed "step_upgrade_yay() incorrect number of arguments"
    fi

    step_print_temp "Upgrading ${#} yay packages.."

    local packages="${@}"
    if ! yay -S --noconfirm ${packages} &> /dev/null; then
        step_failed "Failed to upgrade yay packages: ${packages}"
    fi

    step_print "Upgraded ${#} yay packages"
}

step_upgrade_aur() {
    if [ "$#" -eq 0 ]; then
        step_failed "step_upgrade_aur() incorrect number of arguments"
    fi

    local installed=0
    local failed_package=""
    local package
    for package in "$@"
    do
        step_print_temp "Upgrading AUR package: $package"

        local package_path=$HOME/.aur/$package
        if ! mkdir -p $package_path &> /dev/null; then
            failed_package=$package
            break
        fi

        cd $package_path
        if [ -z "$(ls -A)" ]; then
            if ! git clone https://aur.archlinux.org/${package}.git . &> /dev/null; then
                failed_package=$package
                break
            fi
        elif ! git pull &> /dev/null; then
            failed_package=$package
            break
        fi

        if ! makepkg -si --noconfirm &> /dev/null; then
            failed_package=$package
            break
        else
            installed=$((installed + 1))
        fi
    done

    if [ $installed != 0 ]; then
        step_print "$installed aur packages upgraded"
    fi

    if [[ $failed_package ]]; then
        step_failed "Failed to install aur package: $failed_package"
    fi
}

step_install_snap() {
    if ! systemctl is-active --quiet snapd; then
        step_failed "Snaps can't be installed. snapd is not running"
    fi

    local snap
    for snap in "$@"
    do
        step_print_temp "Installing snap: $snap"

        if ! sudo snap install ${snap} &> /dev/null; then
            step_failed "Failed to install snap: ${snap}"
        fi
    done

    step_print "Installed ${#} snaps"
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
    step_print "Distro checked"

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
    step_print "Machine checked"

    if [ -d "$ROOT_DIR/.git" ]; then
        if [[ "$(git status --porcelain)" ]]; then
            step_warn "Repo check: not clean"
        else
            step_print "Repo check: clean"
        fi
    else
        step_warn "Repo check: not a git repo"
    fi
    step_done
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
            step_failed "Install script not found"
        fi
    done
}

# Common functions
minimize_path () {
    if [ "$#" -ne 1 ]; then
        step_failed "minimize_path() incorrect number of arguments"
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

escape_variable() {
    if [[ "$#" -ne 1 ]]; then
        step_failed "escape_variable() incorrect number of arguments"
    fi

    RESULT=$(sed -e 's|/|\\/|g' -e 's|\.|\\.|g' <<< "${1}")
}

insert_text_info_file() {
    if [[ "$#" -lt 2 || "$#" -gt 4 ]]; then
        step_failed "insert_text_info_file() incorrect number of arguments"
    fi

    local file=${1}
    local text=${2}
    if [[ ! -z ${3} ]]; then
        local check=${3}
    fi
    if [[ ! -z ${4} ]]; then
        local pattern=${4}
    fi

    if [ ! -f ${file} ]; then
        step_failed "insert_text_info_file() ${file} does not exist"
    fi

    if [[ ! -z ${check} ]] && $(grep -qe "${check}" "${file}"); then
        return 0
    fi

    escape_variable "${text}"
    local text_escaped="${RESULT}"
    if [[ ! -z ${pattern} ]] && $(grep -qe "${pattern}" "${file}"); then
        sed -i "0,/${pattern}/s//${text_escaped}\n&/" "${file}"
    else
        sed -i "\$a\\${text_escaped}" "${file}"
    fi
}

replace_text_in_file() {
    if [[ "$#" -lt 3 || "$#" -gt 4 ]]; then
        step_failed "replace_text_in_file() incorrect number of arguments"
    fi

    local file=${1}
    local text=${2}
    local check=${3}
    if [[ ! -z ${4} ]]; then
        local pattern=${4}
    fi

    if [ ! -f ${file} ]; then
        step_failed "replace_text_in_file() ${file} does not exist"
    fi

    escape_variable "${check}"
    local check_escaped="${RESULT}"
    sed -i "/${check_escaped}/d" "${file}"

    escape_variable "${text}"
    local text_escaped="${RESULT}"
    if [[ ! -z ${pattern} ]] && $(grep -qe "${pattern}" "${file}"); then
        sed -i "0,/${pattern}/s//${text_escaped}\n&/" "${file}"
    else
        sed -i "\$a\\${text_escaped}" "${file}"
    fi
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
