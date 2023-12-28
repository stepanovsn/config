# bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
source $SCRIPT_DIR/bashrc_common.sh

# Set up environment variables
export RIPGREP_CONFIG_PATH=$HOME"/.rgrc"
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# Set up PS colors
function prompt_func {
    local ps1="${cGrey}${debian_chroot:+($debian_chroot)}${cGreen}\u${cGrey}:"

    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        local baseDirRelative=$(git rev-parse  --show-cdup)
        if [ -z ${baseDirRelative} ]; then
            local baseDir=$(dirname $(pwd))
        else
            local baseDir=$(dirname $(cd ${baseDirRelative} && pwd))
        fi
        local repoDir=$(realpath -s --relative-base=${baseDir} $(pwd))
        local baseDir=$(realpath -s --relative-base=${HOME} ${baseDir})
        if [[ ${baseDir} == "." ]]; then
            local baseDir="~"
        elif [[ ${baseDir:0:1} != "/" ]]; then
            local baseDir="~/${baseDir}"
        fi

        # Verify the result
        local reference=$(dirs +0)
        if [[ "${baseDir}/${repoDir}" != "${reference}" ]]; then
            ps1+="${cRed}\w"
        else
            local dirLength=$(echo "${baseDir}/${repoDir}" | wc -c)
            if [[ ${dirLength} -gt 48 ]]; then
                local baseDir=$(echo "${baseDir}" | sed -r 's|/([^/]{,2})[^/]*|/\1..|g')
            fi

            ps1+="${cBlue}${baseDir}/${cCyan}${repoDir}"

            local gitBranch=$(git branch --show-current)
            if [[ ${#gitBranch} -gt 24 ]]; then
                local gitBranch="~${gitBranch:(-24)}"
            fi
            ps1+="${cGrey}:${gitBranch}"
        fi
    else
        ps1+="${cBlue}\w"
    fi

    jobs > /dev/null 2>&1
    local jobCount="$(jobs | wc -l)"
    if [[ $jobCount != 0 ]]; then
        ps1+="${cGrey}:${cPurple}${jobCount}"
    fi

    export PS1="${ps1}${cGrey}\$${cNone} "
}

export PROMPT_COMMAND=prompt_func

# Functions
r.view() {
    if [ "$#" -ne 1 ]; then
        echo "view error: provide 1 argument"
        return;
    fi

    /bin/bash ~/.config/lf/preview.sh "$1"
}

r.gdb() {
    local id="$(tmux split-window -p 60 -hPF "#D" "tail -f /dev/null")"
    tmux last-pane
    local tty="$(tmux display-message -p -t "$id" '#{pane_tty}')"
    gdb -ex "dashboard -output $tty" "$@"
    tmux kill-pane -t "$id"
}

r.storage_open() {
    if [ "$#" -ne 1 ]; then
        printf "${cRed}specify the device${cNone}\n"
        return;
    fi

    if [ ! -z "$(mount | grep " on /storage ")" ]; then
        printf "${cRed}/storage is busy${cNone}\n"
        return;
    fi

    if [ ! -d "/storage" ]; then
        sudo mkdir -p /storage
    fi

    sudo cryptsetup luksOpen ${1} usb_storage
    sudo mount /dev/mapper/usb_storage /storage
    sudo chmod -R ugo+rw /storage
}

r.storage_close() {
    if [ -z "$(mount | grep "/dev/mapper/usb_storage on /storage type ext4")" ]; then
        printf "${cRed}/storage is not mount${cNone}\n"
        return;
    fi

    sudo umount /storage
    sudo cryptsetup close usb_storage
}

r.storage_sync() {
    if [ -z ${REG_CONFIG} ] || [ -z ${REG_STORAGE} ]; then
        echo "required variables are not set"
        return;
    fi

    if [ -z "$(mount | grep "/dev/mapper/usb_storage on /storage type ext4")" ]; then
        printf "${cRed}/storage is not mount${cNone}\n"
        return;
    fi

    rsync -vcrtuh --delete ${REG_CONFIG} /storage
    rsync -vcrtuh --delete ${REG_STORAGE} /storage
}

r.gpg_encrypt() {
    if [ "$#" -ne 1 ]; then
        printf "${cRed}specify the file/directory${cNone}\n"
        return;
    fi

    local input="${1}"
    if [ ! -e "${input}" ]; then
        printf "${cRed}${input} not found${cNone}\n"
        return;
    fi

    if [ "$(pwd)" != "$(dirname $(realpath "${input}"))" ]; then
        printf "${cRed}${input} is located outside this directory${cNone}\n"
        return;
    fi

    local input="$(basename ${input})"
    local cleanup=""
    if [ -d "${input}" ]; then
        local archive="${input}.tar"
        if [ -e "${archive}" ]; then
            printf "${cRed}can't create ${archive}. file already exists${cNone}\n"
            return;
        fi

        tar cvf "${archive}" "${input}"
        local input="${archive}"
        local cleanup="${archive}"
    elif [ ! -f "${input}" ]; then
        printf "${cRed}${input} is neither file nor directory${cNone}\n"
        return;
    fi

    local output="${input}.gpg"
    if [ -e "${output}" ]; then
        printf "${cRed}${output} already exists${cNone}\n"
    else
        gpg --symmetric --cipher-algo AES256 --no-symkey-cache --output "${output}" "${input}"
        if [ -e "${output}" ]; then
            echo "${output} created"
        else
            printf "${cRed}${output} hasn't been created. something went wrong${cNone}\n"
        fi
    fi

    if [ ! -z "${cleanup}" ]; then
        rm "${cleanup}"
    fi
}

r.gpg_decrypt() {
    if [ "$#" -ne 1 ]; then
        printf "${cRed}specify the encrypted file${cNone}\n"
        return;
    fi

    local input="${1}"
    if [ ! -f "${input}" ]; then
        printf "${cRed}${input} is not a file${cNone}\n"
        return;
    fi

    if [ "$(pwd)" != "$(dirname $(realpath "${input}"))" ]; then
        printf "${cRed}${input} is located outside this directory${cNone}\n"
        return;
    fi

    local input="$(basename ${input})"
    if [ "${input##*.}" != "gpg" ]; then
        printf "${cRed}${input} is not gpg signed file${cNone}\n"
        return;
    fi

    local output="${input%.*}"
    if [ -e "${output}" ]; then
        printf "${cRed}${output} already exists${cNone}\n"
        return;
    fi

    gpg --decrypt --cipher-algo AES256 --no-symkey-cache --output "${output}" "${input}"
    if [ ! -e "${output}" ]; then
        printf "${cRed}${output} hasn't been created. something went wrong${cNone}\n"
        return;
    fi

    if [ "${output##*.}" != "tar" ]; then
        echo "${output} created"
        return;
    fi

    local directory="${output%.*}"
    if [ -e "${directory}" ]; then
        printf "${cRed}${directory} already exists${cNone}\n"
    else
        tar xvf "${output}"
        if [ -e "${output}" ]; then
            echo "${directory} created"
        else
            printf "${cRed}${directory} hasn't been created. something went wrong${cNone}\n"
        fi
    fi

    rm "${output}"
}

# Add fzf key-bindings
source "$HOME/.local/share/nvim/site/plugged/fzf/shell/key-bindings.bash" &> /dev/null

# Launch tmux session
if $(command -v awesome &> /dev/null) && ! $(pgrep awesome &> /dev/null) && [ "$(tty)" == "/dev/tty1" ]; then
    startx
elif $(command -v tmux &> /dev/null) && ! [ -n "$TMUX" ] && [ -z "$(tmux lsc)" ]; then
    if tmux ls &> /dev/null; then
        tmux attach
    else
        cd ~/
        FILE=$HOME/tmux_main.sh
        if [ -f "$FILE" ]; then
            $FILE
        else
            tmux new -s main
        fi
    fi
fi
