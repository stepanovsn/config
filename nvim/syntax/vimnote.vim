syntax match VimnoteHeader /\(^=\{15,\} \)\@<=.*\( =\{15,\}$\)\@=/
syntax match VimnoteSubheader /\(^=== \)\@<=.*/ contains=ALL

syntax region VimnoteFocused matchgroup=Normal start=/«/ end=/»/ concealends
syntax region VimnoteDimmed matchgroup=Normal start=/‹/ end=/›/ concealends
syntax match VimnoteDimmed /^.*\(    [-=] \)\@=/

syntax match VimnoteInstrumental /^=\{15,\} \(.* =\{15,\}$\)\@=/
syntax match VimnoteInstrumental /\(^=\{15,\} .*\)\@<= =\{15,\}$/
syntax match VimnoteInstrumental /^=== /
syntax match VimnoteInstrumental /[─│━🮙]/
