syntax match VimnoteHeader /\(^======================= \)\@<=.*\( =======================$\)\@=/ " Main header
syntax match VimnoteUnfocus /^======================= \(.* =======================$\)\@=/
syntax match VimnoteUnfocus /\(^======================= .*\)\@<= =======================$/

syntax match VimnoteSubheader /\(^=== \)\@<=.*/ contains=ALL " Secondary header
syntax match VimnoteUnfocus /^=== /

syntax match VimnoteFocus /\(`\)\@<=\(\w\|:\|_\|-\)\+\(\ \(\w\|:\|_\|-\)\+\)*\(`\)\@=/ " Focused word
syntax match VimnoteDimmed /^.*\(    [-=] \)\@=/ " Options
syntax match VimnoteDimmed /\_[^`]*[^`]\(`$\)\@=/ contains=ALL " Listing
syntax match VimnoteHide /\(\_[^`]\)\@<=`\{1,2\}$/
