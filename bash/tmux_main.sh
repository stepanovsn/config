#!/bin/sh

tmux new -s main -n 'config' \; \
send-keys 'cd ~/.config/regconfig' C-m \; \
send-keys C-l \; \
new-window -n 'materials' \; \
send-keys 'cd ~/materials' C-m \; \
send-keys C-l \; \
new-window -n 'other' \; \
select-window -t 3 \;

# For window splitting
#split-window -h -l 40 \; \
#select-pane -t 0 \; \
