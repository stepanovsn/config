#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)/..";
source $ROOT_DIR/settings.sh
ROOT_DIR=$(minimize_path "${ROOT_DIR}")

printf "${cYellow}Internal${cNone}\n"

# Install git hooks
git_hooks=(
    "post-checkout"
    "post-commit"
    "post-merge"
    "post-rebase")
for hook in "${git_hooks[@]}"
do
    step_force_link $ROOT_DIR/internal/hook.sh $ROOT_DIR/.git/hooks/$hook
done
printf "\tGit hooks installed.\n"

secure_files=(
    "bash/bashrc_common.sh"
    "bash/bashrc_root_post.sh")
for secure_file in "${secure_files[@]}"
do
    if ! sudo chown root:root $ROOT_DIR/$secure_file &> /dev/null; then
        printf "\tCan't change $secure_file ownership.\n\t${cRed}Failed.${cNone}\n\n"
        exit 1
    fi

    if ! sudo chmod go+r $ROOT_DIR/$secure_file ; then
        printf "\tCan't change $secure_file mod.\n\t${cRed}Failed.${cNone}\n\n"
        exit 1
    fi
done
printf "\tCorrect rights are set to config files.\n"

printf "\t${cGreen}Done.${cNone}\n\n"
