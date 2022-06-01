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
    force_link $ROOT_DIR/internal/hook.sh $ROOT_DIR/.git/hooks/$hook
done
printf "\tGit hooks installed.\n"

printf "\t${cGreen}Done.${cNone}\n\n"
