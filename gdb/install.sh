#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

step_title "Gdb"

gdb_dir=$HOME/.gdbinit.d
rm -rf $gdb_dir && mkdir $gdb_dir
step_soft_link $ROOT_DIR/gdb/.gdbinit $HOME/.gdbinit
step_soft_link $ROOT_DIR/gdb/init $gdb_dir/init
step_print "Config links made."

step_done
