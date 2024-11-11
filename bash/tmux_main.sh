#!/bin/sh

tmux new -s main -n 'config' \; \
send-keys 'cd ~/.config/regconfig' C-m \; \
send-keys C-l \; \
new-window -n 'materials' \; \
send-keys 'cd ~/materials' C-m \; \
send-keys C-l \; \
split-window -h -l 50 \; \
send-keys 'cd ~/materials' C-m './watch.sh'  C-m \; \
select-pane -t 0 \; \
resize-pane -Z \; \
new-window -n 'rnote' \; \
send-keys 'cd ~/rn_converter' C-m \; \
send-keys C-l \; \
split-window -h -l 50 \; \
send-keys 'cd ~/rn_converter' C-m './watch.sh'  C-m \; \
select-pane -t 0 \; \
resize-pane -Z \; \
new-window -n 'wordstock' \; \
send-keys 'cd ~/wordstock' C-m \; \
send-keys C-l \; \
split-window -h -l 50 \; \
send-keys 'cd ~/wordstock' C-m './watch.sh'  C-m \; \
select-pane -t 0 \; \
resize-pane -Z \; \
new-window -n 'other' \; \

# For window splitting
#split-window -h -l 40 \; \
#select-pane -t 0 \; \

# For selecting startup window
#select-window -t 3 \;
