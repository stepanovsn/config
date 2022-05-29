#!/bin/bash

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}";)" &> /dev/null && pwd 2> /dev/null;)";
source $ROOT_DIR/settings.sh

# Run tasks
printf "\n"
source $ROOT_DIR/internal/install.sh
source $ROOT_DIR/lf/install.sh
