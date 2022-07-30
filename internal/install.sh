#!/bin/bash

# Install git hooks
install_internal() {
    local git_hooks=(
        "post-checkout"
        "post-commit"
        "post-merge"
        "post-rebase")
    local hook
    for hook in "${git_hooks[@]}"
    do
        step_soft_link $ROOT_DIR/internal/hook.sh $ROOT_DIR/.git/hooks/$hook
    done
    step_print "Git hooks installed."

    # Set up secure files
    local secure_files=(
        "bash/bashrc_common.sh"
        "bash/bashrc_root_post.sh")
    local secure_file
    for secure_file in "${secure_files[@]}"
    do
        if ! sudo chown root:root $ROOT_DIR/$secure_file &> /dev/null; then
            step_failed "Can't change $secure_file ownership."
        fi

        if ! sudo chmod ugo+r $ROOT_DIR/$secure_file ; then
            step_failed "Can't change $secure_file mod."
        fi
    done
    step_print "Correct rights are set to config files."
    step_done
}

install_internal
