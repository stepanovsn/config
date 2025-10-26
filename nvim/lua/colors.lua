-- Special
vim.cmd('hi MatchParen none')
vim.cmd('hi Cursor blend=100')

-- Main
vim.api.nvim_set_hl(0, 'Normal', { bg = color.common.normal.bg, fg = color.common.normal.fg })
vim.api.nvim_set_hl(0, 'Conceal', { bg = color.common.normal.bg, fg = color.common.interface.fg })

vim.api.nvim_set_hl(0, 'Visual', { bg = color.visual_select })

vim.api.nvim_set_hl(0, 'LineNr', { fg = color.common.interface.fg })
vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = color.common.interface.bg, fg = color.common.normal.fg })
vim.api.nvim_set_hl(0, 'VertSplit', { bg = color.common.interface.bg, fg = color.common.interface.bg })
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = color.common.interface.bg })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { fg = color.common.normal.bg })

vim.api.nvim_set_hl(0, 'CurSearch', { fg = color.search.current_match.fg, bg = color.search.current_match.bg })
vim.api.nvim_set_hl(0, 'Search', { fg = color.search.other_match.fg, bg = color.search.other_match.bg })
vim.api.nvim_set_hl(0, 'IncSearch', { fg = color.search.incremental.fg, bg = color.search.incremental.bg })

vim.api.nvim_set_hl(0, 'TabLineFill', { bg = color.common.interface.bg, fg = color.common.normal.fg })
vim.api.nvim_set_hl(0, 'TabLineSel', { bg = color.common.dark, fg = color.common.normal.fg })
vim.api.nvim_set_hl(0, 'TabLine', { bg = color.common.interface.bg, fg = color.inactive_tab })

vim.api.nvim_set_hl(0, 'FoldColumn', { fg = color.fold.fg, bg = color.fold.bg })
vim.api.nvim_set_hl(0, 'Folded', { fg = color.fold.fg, bg = color.fold.bg })
vim.api.nvim_set_hl(0, 'DiffAdd', { bg = color.common.interface.bg })
vim.api.nvim_set_hl(0, 'DiffChange', { bg = color.common.interface.bg })
vim.api.nvim_set_hl(0, 'DiffDelete', { bg = color.common.dark, fg = color.common.dark })
vim.api.nvim_set_hl(0, 'DiffText', { fg = color.diff_text })

vim.api.nvim_set_hl(0, 'Whitespace', { fg = color.whitespace.normal })
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { fg = color.whitespace.extra })

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

-- Obsolete
vim.cmd('hi VimnoteHeader guifg=#cf8e6d ctermfg=3')
vim.cmd('hi VimnoteSubheader guifg=#cfac67 ctermfg=11')
vim.cmd('hi VimnoteFocused guifg=#66a2de ctermfg=6')
vim.cmd('hi VimnoteDimmed guifg=#727d8f ctermfg=8')
vim.cmd('hi VimnoteInstrumental guifg=#46494f ctermfg=8')
vim.cmd('hi VimnoteConcealed guifg=#db79b9 ctermfg=5')

vim.cmd('hi KlogDimmed guifg=#46494f ctermfg=6')
vim.cmd('hi KlogDebug guifg=#88caeb ctermfg=6')
vim.cmd('hi KlogInfo guifg=#88caeb ctermfg=6')
vim.cmd('hi KlogWarn guifg=#cfac67 ctermfg=11')
vim.cmd('hi KlogError guifg=#bd5b5b ctermfg=1')
vim.cmd('hi KlogAlert guibg=#632b2b ctermbg=1')
