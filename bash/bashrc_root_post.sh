# bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
source $SCRIPT_DIR/bashrc_common.sh

# Set up PS colors
export PS1='${debian_chroot:+($debian_chroot)}\[\033[31m\]\u@\h\[\033[00m\]\[\033[1;30m\]:\[\033[00m\]\[\033[34m\]\w\[\033[00m\]\[\033[1;30m\]\$\[\033[00m\] '
