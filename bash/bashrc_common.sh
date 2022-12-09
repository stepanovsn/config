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
alias sudo='sudo '
alias ls='ls --color=auto -l'
alias ll='ls -lah'
alias ncdu='ncdu -r'
alias od='od -A x -t xcz'
alias nmcli='nmcli -p -c yes'
alias cal='cal -3m'

# Functions
r.diff () {
    if [ "$#" -ne 2 ]; then
        echo "diff error: provide 2 arguments"
        return;
    fi

    find "${1}" -type f -printf "%P\n" | sort > /tmp/ddiff1.txt
    find "${2}" -type f -printf "%P\n" | sort > /tmp/ddiff2.txt
    nvim -d -O /tmp/ddiff1.txt -O /tmp/ddiff2.txt
}

r.diff_hash () {
    if [ "$#" -ne 2 ]; then
        echo "diff_hash error: provide 2 arguments"
        return;
    fi

    local dirname1=${1%%*(/)}
    local dirname2=${2%%*(/)}
    # In awk, cut the first 36 symbols of the line to get path without parent folder
    # 36 = 32(hash length) + 2(md5sum separator) + 1(because index from 1) + 1(extra for '/' symbol)
    find "${dirname1}" -type f -exec md5sum {} + |\
        awk -v cutlen="$((${#dirname1}+36))" '{printf "%s: %s\n", $1, substr($0, cutlen)}' | sort -k 2 > /tmp/ddiffh1.txt
    find "${dirname2}" -type f -exec md5sum {} + |\
        awk -v cutlen="$((${#dirname2}+36))" '{printf "%s: %s\n", $1, substr($0, cutlen)}' | sort -k 2 > /tmp/ddiffh2.txt
    nvim -d -O /tmp/ddiffh1.txt -O /tmp/ddiffh2.txt
}

r.reload_audio() {
    pulseaudio -k && sudo alsa force-reload
}

r.status_color() {
    printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
}

r.status_graphics() {
    lspci -k | grep -A 2 -E "(VGA|3D)"
}

r.openvpn_connect() {
    local openvpn_config="/etc/openvpn/client.conf"
    if [ ! -f $openvpn_config ]; then
        echo "Openvpn config file not found."

    fi

    sudo openvpn --config /etc/openvpn/client.conf
}

r.mount_fat() {
    sudo mount -o fmask=011,dmask=000 ${1} ${2}
}

# Set up lf: change working dir in shell to last dir in lf on exit.
# Latest script can be found at: https://raw.githubusercontent.com/gokcehan/lf/master/etc/lfcd.sh
lfcd () {
    local tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        local dir="$(cat "$tmp")"
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
bind '"\C-b":"nvim\C-m"'
bind '"\C-]":" | nvim -"'
