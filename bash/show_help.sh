#!/bin/bash

awk '
{
    gsub(/=h= /, "[38;5;236m===== [38;5;37m", $0)
    gsub(/=c= /, "[38;5;245m", $0)
    gsub(/=n= /, "[0m", $0)
    gsub(/$/, "[0m", $0)

    if (/^=H= .*$/) {
        # Extract the text after "=H= "
        text = substr($0, 5)

        # Calculate padding needed
        text_length = length(text)
        total_padding = 120 - text_length - 2  # -2 for spaces around text
        padding_each_side = int(total_padding / 2)

        # Create padding strings
        padding = ""
        for (i = 1; i <= padding_each_side; i++) padding = padding "="

        # Build the new line
        new_line = "[38;5;236m" padding " [38;5;37m" text " [38;5;236m" padding "[0m"

        # Handle odd numbers by adding one more = at the end if needed
        if (length(new_line) < 120) {
            new_line = new_line "="
        }

        print new_line
    } else {
        print
    }
}' ${1}
