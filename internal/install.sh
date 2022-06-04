#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

step_title "Internal"

# Install git hooks
git_hooks=(
    "post-checkout"
    "post-commit"
    "post-merge"
    "post-rebase")
for hook in "${git_hooks[@]}"
do
    step_soft_link $ROOT_DIR/internal/hook.sh $ROOT_DIR/.git/hooks/$hook
done
step_print "Git hooks installed."

# Set up secure files
secure_files=(
    "bash/bashrc_common.sh"
    "bash/bashrc_root_post.sh")
for secure_file in "${secure_files[@]}"
do
    if ! sudo chown root:root $ROOT_DIR/$secure_file &> /dev/null; then
        step_failed "Can't change $secure_file ownership."
    fi

    if ! sudo chmod go+r $ROOT_DIR/$secure_file ; then
        step_failed "Can't change $secure_file mod."
    fi
done
step_print "Correct rights are set to config files."

step_done
