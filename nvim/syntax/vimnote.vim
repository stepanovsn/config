syntax match VimnoteHeader /\(^=\{15,\} \)\@<=.*\( =\{15,\}$\)\@=/
syntax match VimnoteSubheader /\(^=== \)\@<=.*/ contains=ALL

syntax region VimnoteFocused matchgroup=Normal start=/«/ end=/»/ concealends contains=ALL
syntax match VimnoteFocused /⟪.*⟫/ contains=ALL
syntax region VimnoteDimmed matchgroup=Normal start=/‹/ end=/›/ concealends contains=ALL
syntax match VimnoteDimmed /⟨.*⟩/ contains=ALL
syntax match VimnoteDimmed /^.*\(    [-=] \)\@=/
  
syntax match VimnoteNormal /[⟨⟩⟪⟫]/ contained conceal cchar= 

syntax match VimnoteInstrumental /^=\{15,\} \(.* =\{15,\}$\)\@=/
syntax match VimnoteInstrumental /\(^=\{15,\} .*\)\@<= =\{15,\}$/
syntax match VimnoteInstrumental /^=== /
syntax match VimnoteInstrumental /[─│┌┐└┘├┤┬┴┼━┃┏┓┗┛┣┫┳┻╋┆╱╲▒🮙●◆▬◄►▲▼🢐🢒🢑🢓]/
