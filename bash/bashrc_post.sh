# bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
source $SCRIPT_DIR/bashrc_common.sh

# Set up environment variables
export RIPGREP_CONFIG_PATH=$HOME"/.rgrc"
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# Set up PS colors
export PS1='${debian_chroot:+($debian_chroot)}\[\033[32m\]\u@\h\[\033[00m\]\[\033[1;30m\]:\[\033[00m\]\[\033[34m\]\w\[\033[00m\]\[\033[1;30m\]\$\[\033[00m\] '

# Functions
r.view() {
    if [ "$#" -ne 1 ]; then
        echo "view error: provide 1 argument"
        return;
    fi

    /bin/bash ~/.config/lf/preview.sh "$1"
}

# Launch tmux session
# There should be tmux_main.sh in home directory
if $(command -v tmux &> /dev/null) && ! [ -n "$TMUX" ] && [ -z "$(tmux lsc)" ]; then
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

# Add fzf key-bindings
source "$HOME/.local/share/nvim/site/plugged/fzf/shell/key-bindings.bash" &> /dev/null
