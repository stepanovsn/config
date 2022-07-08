# bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
source $SCRIPT_DIR/bashrc_common.sh

# Set up PS colors
export PS1="${debian_chroot:+($debian_chroot)}${cRed}\u@\h${cNone}${cGrey}:${cNone}${cBlue}\w${cNone}${cGrey}\$${cNone} "
