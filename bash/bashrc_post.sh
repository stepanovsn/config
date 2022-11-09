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
