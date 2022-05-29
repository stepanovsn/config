#!/bin/bash

secure_files=(
    "bash/bashrc_common.sh"
    "bash/bashrc_root_post.sh")
files_to_update=()

for i in "${secure_files[@]}"
do
    read -r user group rights <<< $(stat -c '%U %G %a' $i)
    if [ $user != 'root' ] || [ $group != 'root' ] || [ $rights != '644' ]; then
        files_to_update+=($i)
    fi
done

if [ -n "$files_to_update" ]; then
    printf "\n\n          \e[0;33mWarning: some secure files have incorrect ownership/rights:\e[0m\n"
    for i in "${files_to_update[@]}"
    do
        printf "          $i\n"
    done
    printf "\n\n"
fi
