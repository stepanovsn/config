#!/bin/bash

awk '
BEGIN { 
    in_code_section = 0
}

{
    if (in_code_section) {
        gsub(/^/, "[38;5;242m", $0)
    } else if (/=c=($| )/) {
        gsub(/=c=($| )/, "[38;5;242m", $0)
        in_code_section = 1
    }

    if (/=n=($| )/) {
        gsub(/=n=($| )/, "[0m", $0)
        in_code_section = 0
    }

    gsub(/=h= /, "[38;5;235m===== [38;5;74m", $0)

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
        new_line = "[38;5;235m" padding " [38;5;62m" text " [38;5;235m" padding "[0m"

        # Handle odd numbers by adding one more = at the end if needed
        if (length(new_line) < 120) {
            new_line = new_line "="
        }

        print "    " new_line
    } else {
        print "    " $0
    }
}' ${1}
