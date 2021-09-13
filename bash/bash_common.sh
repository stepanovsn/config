# bash

# set up LS colors
export LS_COLORS='rs=0:di=34:ln=36:mh=00:pi=35:so=35:do=35:bd=35:cd=35:or=1;30:mi=1;30:su=37:sg=37:ca=30;41:tw=34:ow=34:st=34:ex=33:fi=37:';
export EDITOR=nvim
export FZF_DEFAULT_OPTS="-e"
export RIPGREP_CONFIG_PATH=$HOME"/.rgrc"

# aliases
alias ncdu='ncdu -r'
alias r.du='du -ah --max-depth=1 | sort -h'
alias r.fzf='fzf -e --print0 | ifne xargs -0 -p'

# functions
ddiff () {
    if [ "$#" -ne 2 ]; then
        echo "ddiff error: provide 2 arguments"
        return;
    fi

    find "${1}" -type f -printf "%P\n" | sort > /tmp/ddiff1.txt
    find "${2}" -type f -printf "%P\n" | sort > /tmp/ddiff2.txt
    nvim -d -O /tmp/ddiff1.txt -O /tmp/ddiff2.txt
}

ddiffh () {
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
