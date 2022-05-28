# bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
source $SCRIPT_DIR/bash_common.sh

# set up PS colors
export PS1='${debian_chroot:+($debian_chroot)}\[\033[32m\]\u@\h\[\033[00m\]\[\033[1;30m\]:\[\033[00m\]\[\033[34m\]\w\[\033[00m\]\[\033[1;30m\]\$\[\033[00m\] '

# launch tmux session
# there should be main.sh in home directory
if $(command -v tmux &> /dev/null) && ! [ -n "$TMUX" ]; then
    if tmux ls &> /dev/null; then
        tmux attach
    else
        cd ~/
        FILE=./tmux_main.sh
        if [ -f "$FILE" ]; then
            ./tmux_main.sh
        else
            tmux new -s main
        fi
    fi
fi
