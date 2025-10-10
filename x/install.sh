#!/bin/bash

install_x() {
    local packages=(
        "autorandr"
        "libxkbcommon"
        "xorg"
        "xorg-server-devel"
        "xorg-xinit"
        "xorg-xrandr"
        "xterm")

    step_upgrade_pacman ${packages[@]}

    # Fonts
    step_print_temp "Installing fonts.."
    local font_dir="/usr/share/fonts/googlefonts"
    step_reset_dir_sudo ${font_dir}
    sudo cp -r $ROOT_DIR/x/roboto_mono/* ${font_dir}
    sudo chmod -R ugo+rwx ${font_dir}

    if ! run_command sudo fc-cache -fv; then
        step_failed "Failed to update fonts"
    fi
    step_print "Fonts installed"

    # X files
    step_soft_link $ROOT_DIR/x/.xinitrc $HOME/.xinitrc
    step_soft_link $ROOT_DIR/x/.xprofile $HOME/.xprofile
    step_soft_link "$ROOT_DIR/x/color_schemes/.Xresources_${REG_CONSOLE_COLOR_SCHEME}" $HOME/.Xresources

    if $(run_command xhost) && ! run_command xrdb -merge ~/.Xresources; then
        step_warn "Failed to merge Xresources"
    fi
    step_print "Xresources merged"

    # Keyboard layout
    # Alternatively, the keyboard layout can be configured by localectl
    # More info on https://wiki.archlinux.org/title/Xorg/Keyboard_configuration
    sudo cp "${ROOT_DIR}/x/00-keyboard.conf" "/etc/X11/xorg.conf.d/"
    step_print "Keyboard X config file copied."

    # Udev rules
    sudo cp $ROOT_DIR/x/90-backlight.rules /etc/udev/rules.d/
    step_print "Udev rules copied"

    step_done
}

install_x
