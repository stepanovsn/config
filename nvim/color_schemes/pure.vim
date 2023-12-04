function g:AirlineInitColors()
    hi airline_tab guifg=#a0a6b0 guibg=#343d4d cterm=none ctermfg=8 ctermbg=0
    hi airline_tabsel guifg=#a0a6b0 guibg=#232830 cterm=none ctermfg=7 ctermbg=0
    hi airline_tabmod guifg=#eceff4 guibg=#2d5e91 cterm=none ctermfg=6 ctermbg=0
    hi airline_tablabel guifg=#ced4de guibg=#343d4d cterm=none ctermfg=7 ctermbg=0
endfunction

" Settings: Ruler
hi ColorColumn guibg=#303845 ctermbg=8

" Colors: Special
hi Cursor blend=100

" Colors: Main
hi VertSplit guifg=#343d4d guibg=#343d4d ctermfg=8 ctermbg=0
hi StatusLine guifg=#343d4d guibg=#343d4d ctermfg=8 ctermbg=0
hi StatusLineNC guifg=#343d4d guibg=#343d4d ctermfg=8 ctermbg=0
hi LineNr guifg=#4c566a ctermfg=8
hi CursorLineNr guifg=#d8dee9 guibg=#343d4d cterm=none ctermfg=7 ctermbg=0
hi Normal guifg=#e5e9f0 guibg=#282e38 ctermfg=7 ctermbg=0
hi EndOfBuffer guifg=#282e38 ctermfg=0
hi DiffAdd guibg=#343d4d ctermbg=0
hi DiffDelete guifg=#232830 guibg=#232830 ctermfg=8 ctermbg=0
hi DiffChange guibg=#343d4d ctermbg=0
hi DiffText guibg=#235959 ctermfg=0 ctermbg=6
hi FoldColumn guifg=#15ebeb guibg=#39465c cterm=none ctermfg=6 ctermbg=0
hi Folded guifg=#15ebeb guibg=#435573 cterm=none ctermfg=6 ctermbg=0
hi Search guifg=#2e3440 guibg=#e0c896 ctermfg=0 ctermbg=3
hi IncSearch guifg=#bf616a guibg=#2e3440 ctermfg=0 ctermbg=3
hi Whitespace guifg=#434c5e ctermfg=8
hi Visual guibg=#434c5e ctermfg=0 ctermbg=2
hi MatchParen none
hi Conceal guifg=#e5e9f0 guibg=#282e38 ctermfg=7 ctermbg=0

" Colors: Code
hi Comment guifg=#4aa881 ctermfg=2

hi PreProc guifg=#7c8aa3 ctermfg=8
hi Define guifg=#7c8aa3 ctermfg=8
hi Macro guifg=#7c8aa3 ctermfg=8
hi Include guifg=#7c8aa3 ctermfg=8

hi Type guifg=#5fafff ctermfg=4
hi StorageClass guifg=#5fafff ctermfg=4
hi Structure guifg=#5fafff ctermfg=4
hi Typedef guifg=#5fafff ctermfg=4

hi Constant guifg=#7c8aa3 ctermfg=8
hi String guifg=#cf8e6d ctermfg=3
hi Character guifg=#d08770 ctermfg=3
hi Number guifg=#87d7ff ctermfg=6
hi Boolean guifg=#87d7ff  ctermfg=6
hi Float guifg=#87d7ff ctermfg=6

hi Statement guifg=#5fafff ctermfg=6
hi Conditional guifg=#5fafff ctermfg=6
hi Repeat guifg=#5fafff ctermfg=6
hi Label guifg=#5fafff ctermfg=6
hi Operator guifg=#5fafff ctermfg=6
hi Keyword guifg=#5fafff ctermfg=6
hi Exception guifg=#5fafff ctermfg=6

hi Identifier guifg=#bd5b5b ctermfg=1
hi Function guifg=#ebcb8b ctermfg=11

hi Special guifg=#875fff ctermfg=5
hi SpecialChar guifg=#875fff ctermfg=5
hi Tag guifg=#875fff ctermfg=5
hi Delimiter guifg=#875fff ctermfg=5
hi SpecialComment guifg=#875fff ctermfg=5
hi Debug guifg=#875fff ctermfg=5

hi Error guifg=#e5e9f0 guibg=#994e4e ctermfg=7 ctermbg=1
hi Todo guifg=#4aa881 ctermfg=2

" Colors: Vimnote
hi VimnoteHeader guifg=#cf8e6d ctermfg=3
hi VimnoteSubheader guifg=#ebcb8b ctermfg=11
hi VimnoteFocused guifg=#5fafff ctermfg=6
hi VimnoteDimmed guifg=#8697b5 ctermfg=8
hi VimnoteInstrumental guifg=#4f5a73 ctermfg=8
hi VimnoteConcealed guifg=#db79b9 ctermfg=5

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
