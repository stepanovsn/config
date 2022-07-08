# bash

set -o ignoreeof
umask 077

# Colors
if [ -t 1 ]; then
    cNone='\e[0m'
    cBlack='\e[0;30m'
    cGrey='\e[1;30m'
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
    cGrey=''
    cRed=''
    cGreen=''
    cYellow=''
    cBlue=''
    cPurple=''
    cCyan=''
    cWhite=''
fi

# Set up environment variables
ls_colors="rs=0:di=34:ln=36:mh=00:pi=35:so=35:do=35:bd=35:cd=35:or=1;\
30:mi=1;30:su=37:sg=37:ca=30;41:tw=34:ow=34:st=34:ex=33:fi=37:";
export LS_COLORS="$ls_colors"
export EDITOR=nvim
export FZF_DEFAULT_OPTS="-e"

# Aliases
alias ll='ls -lah'
alias ncdu='ncdu -r'
alias od='od -A x -t xcz'

# Functions
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

# Set up lf: change working dir in shell to last dir in lf on exit.
# Latest script can be found at: https://raw.githubusercontent.com/gokcehan/lf/master/etc/lfcd.sh
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# Bindings
bind '"\C-n":"lfcd\C-m"'
bind '"\C-p":"fzf\C-m"'
bind '"\C-h":"nvim\C-m"'
bind '"\C-]":" | nvim -"'
