#!/bin/bash

install_grub() {
    local grub_file="/etc/default/grub"
    if ! [ -f $grub_file ]; then
        step_failed "$grub_file not found"
    else
        local vt_colors="vt.default_red=24,201,81,209,73,187,66,200,85,222,55,227,50,224,50,255 vt.default_grn=24,87,196,162,116,56,207,200,85,58,212,209,107,31,219,255 vt.default_blu=24,79,106,69,191,194,200,200,85,47,89,52,207,215,211,255"
        if ! grep -q "${vt_colors}" $grub_file; then
            step_failed "Vt colors are outdated"
        else
            step_print "Vt colors are up-to-date"
        fi
    fi

    step_done
}

install_grub
