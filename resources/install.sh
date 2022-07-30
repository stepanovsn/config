#!/bin/bash

# Install git hooks
install_resources() {
    local resources_dir="${HOME}/resources"
    if [ ! -d ${resources_dir} ]; then
        mkdir ${resources_dir}
        step_print "Resources dir created"
    else
        step_print "Resources dir already exists"
    fi

    local wallpaper_default="${ROOT_DIR}/resources/wallpaper.jpg"
    local wallpaper="${resources_dir}/wallpaper.jpg"
    if [ ! -f ${wallpaper} ]; then
        cp ${wallpaper_default} ${wallpaper}
        step_print "Wallpaper copied"
    else
        step_print "Wallpaper already exists"
    fi

    step_done
}

install_resources
