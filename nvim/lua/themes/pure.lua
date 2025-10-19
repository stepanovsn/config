-- Trailing whitespace
vim.cmd('hi ExtraWhitespace guifg=#ff0000 ctermfg=9')

-- Ruler
vim.cmd('hi ColorColumn guibg=#272729 ctermbg=8')

-- Special
vim.cmd('hi Cursor blend=100')

-- Main
vim.cmd('hi VertSplit guifg=#272729 guibg=#272729 ctermfg=8 ctermbg=0')
vim.cmd('hi StatusLine guifg=#272729 guibg=#272729 ctermfg=8 ctermbg=0')
vim.cmd('hi StatusLineNC guifg=#272729 guibg=#272729 ctermfg=8 ctermbg=0')
vim.cmd('hi LineNr guifg=#46494f ctermfg=8')
vim.cmd('hi CursorLineNr guifg=#c1c3c9 guibg=#272729 cterm=none ctermfg=7 ctermbg=0')
vim.cmd('hi Normal guifg=#c1c3c9 guibg=#1b1b1b ctermfg=7 ctermbg=0')
vim.cmd('hi EndOfBuffer guifg=#1b1b1b ctermfg=0')
vim.cmd('hi DiffAdd guibg=#272729 ctermbg=0')
vim.cmd('hi DiffDelete guifg=#121212 guibg=#121212 ctermfg=8 ctermbg=0')
vim.cmd('hi DiffChange guibg=#272729 ctermbg=0')
vim.cmd('hi DiffText guibg=#0f4747 ctermfg=0 ctermbg=6')
vim.cmd('hi FoldColumn guifg=#15ebeb guibg=#40444a cterm=none ctermfg=6 ctermbg=0')
vim.cmd('hi Folded guifg=#15ebeb guibg=#40444a cterm=none ctermfg=6 ctermbg=0')
vim.cmd('hi Search guifg=#2a2e36 guibg=#b8a06c ctermfg=0 ctermbg=3')
vim.cmd('hi IncSearch guifg=#bf616a guibg=#2a2e36 ctermfg=0 ctermbg=3')
vim.cmd('hi Whitespace guifg=#383838 ctermfg=8')
vim.cmd('hi Visual guibg=#383838 ctermfg=0 ctermbg=2')
vim.cmd('hi MatchParen none')
vim.cmd('hi Conceal guifg=#46494f guibg=#1b1b1b ctermfg=8 ctermbg=0')

-- Code
vim.cmd('hi Comment guifg=#4aa881 ctermfg=2')

vim.cmd('hi PreProc guifg=#727d8f ctermfg=8')
vim.cmd('hi Define guifg=#727d8f ctermfg=8')
vim.cmd('hi Macro guifg=#727d8f ctermfg=8')
vim.cmd('hi Include guifg=#727d8f ctermfg=8')

vim.cmd('hi Type guifg=#66a2de ctermfg=4')
vim.cmd('hi StorageClass guifg=#66a2de ctermfg=4')
vim.cmd('hi Structure guifg=#66a2de ctermfg=4')
vim.cmd('hi Typedef guifg=#66a2de ctermfg=4')

vim.cmd('hi Constant guifg=#727d8f ctermfg=8')
vim.cmd('hi String guifg=#cf8e6d ctermfg=3')
vim.cmd('hi Character guifg=#d08770 ctermfg=3')
vim.cmd('hi Number guifg=#88caeb ctermfg=6')
vim.cmd('hi Boolean guifg=#88caeb ctermfg=6')
vim.cmd('hi Float guifg=#88caeb ctermfg=6')

vim.cmd('hi Statement guifg=#66a2de ctermfg=6')
vim.cmd('hi Conditional guifg=#66a2de ctermfg=6')
vim.cmd('hi Repeat guifg=#66a2de ctermfg=6')
vim.cmd('hi Label guifg=#66a2de ctermfg=6')
vim.cmd('hi Operator guifg=#66a2de ctermfg=6')
vim.cmd('hi Keyword guifg=#66a2de ctermfg=6')
vim.cmd('hi Exception guifg=#66a2de ctermfg=6')

vim.cmd('hi Identifier guifg=#bd5b5b ctermfg=1')
vim.cmd('hi Function guifg=#cfac67 ctermfg=11')

vim.cmd('hi Special guifg=#875fff ctermfg=5')
vim.cmd('hi SpecialChar guifg=#875fff ctermfg=5')
vim.cmd('hi Tag guifg=#875fff ctermfg=5')
vim.cmd('hi Delimiter guifg=#875fff ctermfg=5')
vim.cmd('hi SpecialComment guifg=#875fff ctermfg=5')
vim.cmd('hi Debug guifg=#875fff ctermfg=5')

vim.cmd('hi Error guifg=#d4dee6 guibg=#994e4e ctermfg=7 ctermbg=1')
vim.cmd('hi Todo guifg=#4aa881 ctermfg=2')

-- Vimnote
vim.cmd('hi VimnoteHeader guifg=#cf8e6d ctermfg=3')
vim.cmd('hi VimnoteSubheader guifg=#cfac67 ctermfg=11')
vim.cmd('hi VimnoteFocused guifg=#66a2de ctermfg=6')
vim.cmd('hi VimnoteDimmed guifg=#727d8f ctermfg=8')
vim.cmd('hi VimnoteInstrumental guifg=#46494f ctermfg=8')
vim.cmd('hi VimnoteConcealed guifg=#db79b9 ctermfg=5')

-- Bnote
vim.cmd('hi BnoteHeader guifg=#725fff')
vim.cmd('hi BnoteSubheader guifg=#88caeb')
vim.cmd('hi BnoteCode guifg=#787878')
vim.cmd('hi BnoteTag guifg=#303030')

-- Rnote
vim.cmd('hi RnoteAlert guibg=#632b2b ctermbg=1')
vim.cmd('hi RnoteDocument guifg=#bd5b5b ctermfg=1')
vim.cmd('hi RnoteChapter guifg=#ba6338 ctermfg=5')
vim.cmd('hi RnoteSection guifg=#cf8e6d ctermfg=3')
vim.cmd('hi RnoteSubsection guifg=#cfac67 ctermfg=11')
vim.cmd('hi RnoteStyled guifg=#66a2de ctermfg=6')
vim.cmd('hi RnoteSpecial guifg=#d07ad6 ctermfg=5')
vim.cmd('hi RnoteService1 guifg=#46494f ctermfg=8')
vim.cmd('hi RnoteService2 guifg=#46494f ctermfg=8')
vim.cmd('hi RnoteService3 guifg=#46494f ctermfg=8')
vim.cmd('hi RnoteServiceCell guifg=#d07ad6 ctermfg=5')

-- Kaspersky log
vim.cmd('hi KlogDimmed guifg=#46494f ctermfg=6')
vim.cmd('hi KlogDebug guifg=#88caeb ctermfg=6')
vim.cmd('hi KlogInfo guifg=#88caeb ctermfg=6')
vim.cmd('hi KlogWarn guifg=#cfac67 ctermfg=11')
vim.cmd('hi KlogError guifg=#bd5b5b ctermfg=1')
vim.cmd('hi KlogAlert guibg=#632b2b ctermbg=1')

-- 16 colors
if vim.fn.has('termguicolors') == 1 and vim.opt.termguicolors:get() then
    vim.g.terminal_color_0 = '#000000'
    vim.g.terminal_color_1 = '#c02727'
    vim.g.terminal_color_2 = '#1fb33d'
    vim.g.terminal_color_3 = '#c9c331'
    vim.g.terminal_color_4 = '#3579de'
    vim.g.terminal_color_5 = '#a031c9'
    vim.g.terminal_color_6 = '#2ebece'
    vim.g.terminal_color_7 = '#e8e8e8'
    vim.g.terminal_color_8 = '#727272'
    vim.g.terminal_color_9 = '#c71d1d'
    vim.g.terminal_color_10 = '#20cb31'
    vim.g.terminal_color_11 = '#eee615'
    vim.g.terminal_color_12 = '#2c7bf2'
    vim.g.terminal_color_13 = '#b838eb'
    vim.g.terminal_color_14 = '#2ccadb'
    vim.g.terminal_color_15 = '#e8e8e8'
end
