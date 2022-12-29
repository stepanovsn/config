# bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
source $SCRIPT_DIR/bashrc_common.sh

# Set up environment variables
export RIPGREP_CONFIG_PATH=$HOME"/.rgrc"
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# Set up PS colors
export PS1="${debian_chroot:+($debian_chroot)}${cGreen}\u@\h${cNone}${cGrey}:${cNone}${cBlue}\w${cNone}${cGrey}\$${cNone} "

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

    rsync -vcrtuh --delete ${REG_CONFIG} /storage/storage
    rsync -vcrtuh --delete ${REG_STORAGE} /storage/storage
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
