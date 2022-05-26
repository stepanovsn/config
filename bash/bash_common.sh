# bash

set -o ignoreeof
umask 077

# set up LS colors
export LS_COLORS='rs=0:di=34:ln=36:mh=00:pi=35:so=35:do=35:bd=35:cd=35:or=1;30:mi=1;30:su=37:sg=37:ca=30;41:tw=34:ow=34:st=34:ex=33:fi=37:';
export EDITOR=nvim
export FZF_DEFAULT_OPTS="-e"
export RIPGREP_CONFIG_PATH=$HOME"/.rgrc"
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# aliases
alias ll='ls -lah'
alias ncdu='ncdu -r'
alias r.du='du -ah --max-depth=1 | sort -h'
alias r.fzf='fzf -e --print0 | ifne xargs -0 -p'

# functions
r.ddiff () {
    if [ "$#" -ne 2 ]; then
        echo "ddiff error: provide 2 arguments"
        return;
    fi

    find "${1}" -type f -printf "%P\n" | sort > /tmp/ddiff1.txt
    find "${2}" -type f -printf "%P\n" | sort > /tmp/ddiff2.txt
    nvim -d -O /tmp/ddiff1.txt -O /tmp/ddiff2.txt
}

r.ddiffh () {
    if [ "$#" -ne 2 ]; then
        echo "ddiffh error: provide 2 arguments"
        return;
    fi

    local DIRNAME1=${1%%*(/)}
    local DIRNAME2=${2%%*(/)}
    # In awk, cut the first 36 symbols of the line to get path without parent folder
    # 36 = 32(hash length) + 2(md5sum separator) + 1(because index from 1) + 1(extra for '/' symbol)
    find "${DIRNAME1}" -type f -exec md5sum {} + |\
        awk -v cutlen="$((${#DIRNAME1}+36))" '{printf "%s: %s\n", $1, substr($0, cutlen)}' | sort -k 2 > /tmp/ddiffh1.txt
    find "${DIRNAME2}" -type f -exec md5sum {} + |\
        awk -v cutlen="$((${#DIRNAME2}+36))" '{printf "%s: %s\n", $1, substr($0, cutlen)}' | sort -k 2 > /tmp/ddiffh2.txt
    nvim -d -O /tmp/ddiffh1.txt -O /tmp/ddiffh2.txt
}

r.testcolor() {
    printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
}

r.reload_audio() {
    pulseaudio -k && sudo alsa force-reload
}

# set up lf
LFCD=$HOME"/.config/lf/lfcd.sh"
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi

# bindings
bind '"\C-n":"lfcd\C-m"'
bind '"\C-p":"fzf\C-m"'
bind '"\C-h":"nvim\C-m"'
bind '"\C-]":" | nvim -"'

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
