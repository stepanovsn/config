syntax match VimnoteHeader /\(^======================= \)\@<=.*\( =======================$\)\@=/ " Main header
syntax match VimnoteUnfocus /^======================= \(.* =======================$\)\@=/
syntax match VimnoteUnfocus /\(^======================= .*\)\@<= =======================$/

syntax match VimnoteSubheader /\(^=== \)\@<=.*/ contains=ALL " Secondary header
syntax match VimnoteUnfocus /^=== /

syntax match VimnoteFocus /`[^`]\+\(\s[^`]\+\)*`/ " Focused word
syntax match VimnoteDimmed /^.*\(    [-=] \)\@=/ " Options
syntax region VimnoteDimmed matchgroup=VimnoteHide start=/\([^`]\|^\)\@<=``$/ end=/\([^`]\)\@<=`$/
syntax match VimnoteUnfocus /[┌┐└┘─│┬┴├┤┼]/
