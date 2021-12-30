syntax match VimnoteHeaderSep /^======================= /
syntax match VimnoteHeaderSep / =======================$/
syntax match VimnoteHeaderName /\(^======================= \)\@<=.*\( =======================$\)\@=/
syntax match VimnoteEntry /^.*\(    [-=] \)\@=/
syntax match VimnoteSubheader /^\*\* .* \*\*$/
syntax match VimnoteFocus /\(^\|\s\)`\w\+\(\ \w\+\)*`/
