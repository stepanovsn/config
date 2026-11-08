#!/bin/bash

install_opencode() {
    # Install only config files. The agent itself should be installed in custom docker container
    local config_dir=$HOME/.config/opencode
    mkdir -p $config_dir
    step_soft_link $RECIPE_DIR/cli.json $config_dir/cli.json
    step_soft_link $RECIPE_DIR/opencode.json $config_dir/opencode.json
    step_done
}

install_opencode
