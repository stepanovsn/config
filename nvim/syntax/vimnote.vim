syntax match VimnoteHeaderSep /^============= /
syntax match VimnoteHeaderSep / =============$/
syntax match VimnoteHeaderName /\(^============= \)\@<=.*\( =============$\)\@=/
syntax match VimnoteEntry /^.*\(    [-=] \)\@=/
