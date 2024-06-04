" Variable
"syntax match Identifier +\(\W\|^\)\@<=let\(\W\|$\)\@=+
syntax match KlogDimmed +^\[[0-9T\-\:\.]*\]+ conceal
syntax match KlogDimmed +\(^\[[0-9T\-\:\.]*\]\(\[[^ \[\]]*\]\)\{2\}\)\@<=\(\[[^ \[\]]*\]\)\{2\}+ conceal
syntax match KlogDimmed +\(^\[[0-9T\-\:\.]*\]\(\[[^ \[\]]*\]\)\)\@<=\[[^ \[\]]*\]+

syntax match KlogDebug +\(^\[[0-9T\-\:\.]*\]\)\@<=\[Debug\]+
syntax match KlogInfo +\(^\[[0-9T\-\:\.]*\]\)\@<=\[Info\]+
syntax match KlogWarn +\(^\[[0-9T\-\:\.]*\]\)\@<=\[Warn\]+
syntax match KlogError +\(^\[[0-9T\-\:\.]*\]\)\@<=\[Error\]+

syntax match KlogAlert +\(^\[[0-9T\-\:\.]*\]\[[^ ]*\] .*\)\@<=\(fail\|\(No \)\@<!error\|abnormal\)+
