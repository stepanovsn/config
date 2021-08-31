# bash

# set up LS colors
export LS_COLORS='rs=0:di=34:ln=36:mh=00:pi=35:so=35:do=35:bd=35:cd=35:or=1;30:mi=1;30:su=37:sg=37:ca=30;41:tw=34:ow=34:st=34:ex=33:fi=37:';

export EDITOR=nvim

# aliases
alias ncdu='ncdu -r'
alias r.du='du -ah --max-depth=1 | sort -h'
alias r.fzf='fzf -e --print0 | ifne xargs -0 -p'
