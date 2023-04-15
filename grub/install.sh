#!/bin/bash

install_grub() {
    local grub_file="/etc/default/grub"
    if ! [ -f $grub_file ]; then
        step_failed "$grub_file not found"
    fi

    local vt_colors="vt.default_red=24,201,81,209,73,187,66,200,96,222,19,227,22,247,17,255 vt.default_grn=24,87,196,162,116,56,207,200,96,58,232,209,102,10,247,255 vt.default_blu=24,79,106,69,191,194,200,200,96,47,65,52,240,235,236,255"
    if ! grep -q "${vt_colors}" $grub_file; then
        step_failed "Vt colors are outdated. Update the colors and remake grub config"
    fi
    step_print "Vt colors are up-to-date"

    step_done
}

install_grub
