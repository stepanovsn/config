-- Special
vim.cmd('hi MatchParen none')
vim.cmd('hi Cursor blend=100')

-- Main
vim.api.nvim_set_hl(0, 'Normal', { bg = color.common.normal.bg, fg = color.common.normal.fg })
vim.api.nvim_set_hl(0, 'Conceal', { bg = color.common.normal.bg, fg = color.common.interface.fg })

vim.api.nvim_set_hl(0, 'Visual', { bg = color.visual_select.bg })

vim.api.nvim_set_hl(0, 'LineNr', { fg = color.common.interface.fg })
vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = color.common.interface.bg, fg = color.common.normal.fg })
vim.api.nvim_set_hl(0, 'VertSplit', { bg = color.common.interface.bg, fg = color.common.interface.bg })
vim.api.nvim_set_hl(0, 'WinSeparator', { bg = color.common.interface.bg, fg = color.common.interface.bg })
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = color.color_column.bg })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { fg = color.common.normal.bg })

vim.api.nvim_set_hl(0, 'CurSearch', { fg = color.search.current_match.fg, bg = color.search.current_match.bg })
vim.api.nvim_set_hl(0, 'Search', { fg = color.search.other_match.fg, bg = color.search.other_match.bg })
vim.api.nvim_set_hl(0, 'IncSearch', { fg = color.search.incremental.fg, bg = color.search.incremental.bg })

vim.api.nvim_set_hl(0, 'TabLineFill', { bg = color.common.interface.bg, fg = color.common.normal.fg })
vim.api.nvim_set_hl(0, 'TabLineSel', { bg = color.common.dark, fg = color.common.normal.fg })
vim.api.nvim_set_hl(0, 'TabLine', { bg = color.common.interface.bg, fg = color.inactive_tab.fg })

vim.api.nvim_set_hl(0, 'FoldColumn', { fg = color.fold.fg, bg = color.fold.bg })
vim.api.nvim_set_hl(0, 'Folded', { fg = color.fold.fg, bg = color.fold.bg })
vim.api.nvim_set_hl(0, 'DiffAdd', { bg = color.common.interface.bg })
vim.api.nvim_set_hl(0, 'DiffChange', { bg = color.common.interface.bg })
vim.api.nvim_set_hl(0, 'DiffDelete', { bg = color.common.dark, fg = color.common.dark })
vim.api.nvim_set_hl(0, 'DiffText', { bg = color.diff_text.bg })

vim.api.nvim_set_hl(0, 'Whitespace', { fg = color.whitespace.normal })
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { fg = color.whitespace.extra })

vim.api.nvim_set_hl(0, 'FloatBorder', { bg = color.common.normal.bg, fg = color.common.interface.fg })

-- Code
vim.api.nvim_set_hl(0, 'Comment', { fg = color.code.comment })
vim.api.nvim_set_hl(0, 'Todo', { fg = color.code.comment })

vim.api.nvim_set_hl(0, 'PreProc', { fg = color.code.define })
vim.api.nvim_set_hl(0, 'Define', { fg = color.code.define })
vim.api.nvim_set_hl(0, 'Macro', { fg = color.code.define })
vim.api.nvim_set_hl(0, 'Include', { fg = color.code.define })
vim.api.nvim_set_hl(0, 'Constant', { fg = color.code.define })

vim.api.nvim_set_hl(0, 'Type', { fg = color.code.statement })
vim.api.nvim_set_hl(0, 'StorageClass', { fg = color.code.statement })
vim.api.nvim_set_hl(0, 'Structure', { fg = color.code.statement })
vim.api.nvim_set_hl(0, 'Typedef', { fg = color.code.statement })
vim.api.nvim_set_hl(0, 'Statement', { fg = color.code.statement })
vim.api.nvim_set_hl(0, 'Conditional', { fg = color.code.statement })
vim.api.nvim_set_hl(0, 'Repeat', { fg = color.code.statement })
vim.api.nvim_set_hl(0, 'Label', { fg = color.code.statement })
vim.api.nvim_set_hl(0, 'Operator', { fg = color.code.statement })
vim.api.nvim_set_hl(0, 'Keyword', { fg = color.code.statement })
vim.api.nvim_set_hl(0, 'Exception', { fg = color.code.statement })

vim.api.nvim_set_hl(0, 'String', { fg = color.code.string })

vim.api.nvim_set_hl(0, 'Character', { fg = color.code.character })

vim.api.nvim_set_hl(0, 'Number', { fg = color.code.number })
vim.api.nvim_set_hl(0, 'Boolean', { fg = color.code.number })
vim.api.nvim_set_hl(0, 'Float', { fg = color.code.number })

vim.api.nvim_set_hl(0, 'Identifier', { fg = color.code.identifier })

vim.api.nvim_set_hl(0, 'Function', { fg = color.code.func })

vim.api.nvim_set_hl(0, 'Special', { fg = color.code.special })
vim.api.nvim_set_hl(0, 'SpecialChar', { fg = color.code.special })
vim.api.nvim_set_hl(0, 'Tag', { fg = color.code.special })
vim.api.nvim_set_hl(0, 'Delimiter', { fg = color.code.special })
vim.api.nvim_set_hl(0, 'SpecialComment', { fg = color.code.special })
vim.api.nvim_set_hl(0, 'Debug', { fg = color.code.special })

vim.api.nvim_set_hl(0, 'Error', { fg = color.code.error.fg, fg = color.code.error.bg })

-- Bnote
vim.api.nvim_set_hl(0, 'BnoteHeader', { fg = color.bnote.header })
vim.api.nvim_set_hl(0, 'BnoteSubheader', { fg = color.bnote.subheader })
vim.api.nvim_set_hl(0, 'BnoteCode', { fg = color.bnote.code })
vim.api.nvim_set_hl(0, 'BnoteTag', { fg = color.bnote.tag })

-- Rnote
vim.api.nvim_set_hl(0, 'RnoteAlert', { fg = color.rnote.alert })
vim.api.nvim_set_hl(0, 'RnoteDocument', { fg = color.rnote.document })
vim.api.nvim_set_hl(0, 'RnoteChapter', { fg = color.rnote.chapter })
vim.api.nvim_set_hl(0, 'RnoteSection', { fg = color.rnote.section })
vim.api.nvim_set_hl(0, 'RnoteSubsection', { fg = color.rnote.subsection })
vim.api.nvim_set_hl(0, 'RnoteStyled', { fg = color.rnote.styled })
vim.api.nvim_set_hl(0, 'RnoteSpecial', { fg = color.rnote.special })
vim.api.nvim_set_hl(0, 'RnoteServiceCell', { fg = color.rnote.special })
vim.api.nvim_set_hl(0, 'RnoteService1', { fg = color.rnote.service })
vim.api.nvim_set_hl(0, 'RnoteService2', { fg = color.rnote.service })
vim.api.nvim_set_hl(0, 'RnoteService3', { fg = color.rnote.service })

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
