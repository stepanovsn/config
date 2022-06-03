#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

step_title "Ctags"
step_install_snap universal-ctags

ctags_dir=$HOME/.ctags.d
rm -rf $ctags_dir && mkdir $ctags_dir
step_make_hard_link $ROOT_DIR/ctags/default.ctags $ctags_dir/default.ctags
step_print "Config link made."

step_done
