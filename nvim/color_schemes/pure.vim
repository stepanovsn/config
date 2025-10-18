function g:AirlineInitColors()
    hi airline_tab guifg=#a0a6b0 guibg=#272729 cterm=none ctermfg=8 ctermbg=0
    hi airline_tabsel guifg=#a0a6b0 guibg=#121212 cterm=none ctermfg=7 ctermbg=0
    hi airline_tabmod guifg=#eceff4 guibg=#254569 cterm=none ctermfg=6 ctermbg=0
    hi airline_tablabel guifg=#ced4de guibg=#272729 cterm=none ctermfg=7 ctermbg=0
endfunction

" Settings: Ruler
hi ColorColumn guibg=#272729 ctermbg=8

" Colors: Special
hi Cursor blend=100

" Colors: Main
hi VertSplit guifg=#272729 guibg=#272729 ctermfg=8 ctermbg=0
hi StatusLine guifg=#272729 guibg=#272729 ctermfg=8 ctermbg=0
hi StatusLineNC guifg=#272729 guibg=#272729 ctermfg=8 ctermbg=0
hi LineNr guifg=#46494f ctermfg=8
hi CursorLineNr guifg=#c1c3c9 guibg=#272729 cterm=none ctermfg=7 ctermbg=0
hi Normal guifg=#c1c3c9 guibg=#1b1b1b ctermfg=7 ctermbg=0
hi EndOfBuffer guifg=#1b1b1b ctermfg=0
hi DiffAdd guibg=#272729 ctermbg=0
hi DiffDelete guifg=#121212 guibg=#121212 ctermfg=8 ctermbg=0
hi DiffChange guibg=#272729 ctermbg=0
hi DiffText guibg=#0f4747 ctermfg=0 ctermbg=6
hi FoldColumn guifg=#15ebeb guibg=#40444a cterm=none ctermfg=6 ctermbg=0
hi Folded guifg=#15ebeb guibg=#40444a cterm=none ctermfg=6 ctermbg=0
hi Search guifg=#2a2e36 guibg=#b8a06c ctermfg=0 ctermbg=3
hi IncSearch guifg=#bf616a guibg=#2a2e36 ctermfg=0 ctermbg=3
hi Whitespace guifg=#383838 ctermfg=8
hi Visual guibg=#383838 ctermfg=0 ctermbg=2
hi MatchParen none
hi Conceal guifg=#46494f guibg=#1b1b1b ctermfg=8 ctermbg=0

" Colors: Code
hi Comment guifg=#4aa881 ctermfg=2

hi PreProc guifg=#727d8f ctermfg=8
hi Define guifg=#727d8f ctermfg=8
hi Macro guifg=#727d8f ctermfg=8
hi Include guifg=#727d8f ctermfg=8

hi Type guifg=#66a2de ctermfg=4
hi StorageClass guifg=#66a2de ctermfg=4
hi Structure guifg=#66a2de ctermfg=4
hi Typedef guifg=#66a2de ctermfg=4

hi Constant guifg=#727d8f ctermfg=8
hi String guifg=#cf8e6d ctermfg=3
hi Character guifg=#d08770 ctermfg=3
hi Number guifg=#88caeb ctermfg=6
hi Boolean guifg=#88caeb  ctermfg=6
hi Float guifg=#88caeb ctermfg=6

hi Statement guifg=#66a2de ctermfg=6
hi Conditional guifg=#66a2de ctermfg=6
hi Repeat guifg=#66a2de ctermfg=6
hi Label guifg=#66a2de ctermfg=6
hi Operator guifg=#66a2de ctermfg=6
hi Keyword guifg=#66a2de ctermfg=6
hi Exception guifg=#66a2de ctermfg=6

hi Identifier guifg=#bd5b5b ctermfg=1
hi Function guifg=#cfac67 ctermfg=11

hi Special guifg=#875fff ctermfg=5
hi SpecialChar guifg=#875fff ctermfg=5
hi Tag guifg=#875fff ctermfg=5
hi Delimiter guifg=#875fff ctermfg=5
hi SpecialComment guifg=#875fff ctermfg=5
hi Debug guifg=#875fff ctermfg=5

hi Error guifg=#d4dee6 guibg=#994e4e ctermfg=7 ctermbg=1
hi Todo guifg=#4aa881 ctermfg=2

" Colors: Vimnote
hi VimnoteHeader guifg=#cf8e6d ctermfg=3
hi VimnoteSubheader guifg=#cfac67 ctermfg=11
hi VimnoteFocused guifg=#66a2de ctermfg=6
hi VimnoteDimmed guifg=#727d8f ctermfg=8
hi VimnoteInstrumental guifg=#46494f ctermfg=8
hi VimnoteConcealed guifg=#db79b9 ctermfg=5

" Colors: Bnote
hi BnoteHeader guifg=#725fff
hi BnoteSubheader guifg=#88caeb
hi BnoteCode guifg=#787878
hi BnoteTag guifg=#303030

" Colors: Rnote
hi RnoteAlert guibg=#632b2b ctermbg=1
hi RnoteDocument guifg=#bd5b5b ctermfg=1
hi RnoteChapter guifg=#ba6338 ctermfg=5
hi RnoteSection guifg=#cf8e6d ctermfg=3
hi RnoteSubsection guifg=#cfac67 ctermfg=11
hi RnoteStyled guifg=#66a2de ctermfg=6
hi RnoteSpecial guifg=#d07ad6 ctermfg=5
hi RnoteService1 guifg=#46494f ctermfg=8
hi RnoteService2 guifg=#46494f ctermfg=8
hi RnoteService3 guifg=#46494f ctermfg=8
hi RnoteServiceCell guifg=#d07ad6 ctermfg=5

" Colors: Kaspersky log
hi KlogDimmed guifg=#46494f ctermfg=6
hi KlogDebug guifg=#88caeb ctermfg=6
hi KlogInfo guifg=#88caeb ctermfg=6
hi KlogWarn guifg=#cfac67 ctermfg=11
hi KlogError guifg=#bd5b5b ctermfg=1
hi KlogAlert guibg=#632b2b ctermbg=1

" Colors: 16
if has('termguicolors') && &termguicolors
    let g:terminal_color_0 = '#000000'
    let g:terminal_color_1 = '#c02727'
    let g:terminal_color_2 = '#1fb33d'
    let g:terminal_color_3 = '#c9c331'
    let g:terminal_color_4 = '#3579de'
    let g:terminal_color_5 = '#a031c9'
    let g:terminal_color_6 = '#2ebece'
    let g:terminal_color_7 = '#e8e8e8'
    let g:terminal_color_8 = '#727272'
    let g:terminal_color_9 = '#c71d1d'
    let g:terminal_color_10 = '#20cb31'
    let g:terminal_color_11 = '#eee615'
    let g:terminal_color_12 = '#2c7bf2'
    let g:terminal_color_13 = '#b838eb'
    let g:terminal_color_14 = '#2ccadb'
    let g:terminal_color_15 = '#e8e8e8'
endif
