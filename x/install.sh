#!/bin/bash

install_x() {
    local packages=(
        "autorandr"
        "libxkbcommon"
        "xorg"
        "xorg-xinit"
        "xterm")

    step_remove_pacman acpilight
    step_upgrade_pacman ${packages[@]}
    step_remove_pacman xorg-xbacklight
    step_upgrade_pacman acpilight

    # Fonts
    step_print_temp "Installing fonts.."
    local font_dir="/usr/share/fonts/googlefonts"
    step_reset_dir_sudo ${font_dir}
    sudo cp -r $ROOT_DIR/x/roboto_mono/* ${font_dir}
    sudo chmod -R ugo+rwx ${font_dir}

    if ! sudo fc-cache -fv &> /dev/null; then
        step_failed "Failed to update fonts"
    fi
    step_print "Fonts installed"

    # X files
    step_soft_link $ROOT_DIR/x/.xinitrc $HOME/.xinitrc
    step_soft_link $ROOT_DIR/x/.xprofile $HOME/.xprofile
    step_soft_link "$ROOT_DIR/x/color_schemes/.Xresources_${REG_CONSOLE_COLOR_SCHEME}" $HOME/.Xresources

    if $(xhost >& /dev/null) && ! xrdb -merge ~/.Xresources &> /dev/null; then
        step_warn "Failed to merge Xresources"
    fi
    step_print "Xresources merged"

    # Keyboard layout
    if ! sudo localectl --no-convert set-x11-keymap us,ru pc104 qwerty grp:alt_shift_toggle &> /dev/null; then
        step_failed "Failed to set keyboard layout"
    fi
    step_print "Keyboard layout set"

    # Udev rules
    sudo cp $ROOT_DIR/x/90-backlight.rules /etc/udev/rules.d/
    step_print "Udev rules copied"

    step_done
}

install_x
