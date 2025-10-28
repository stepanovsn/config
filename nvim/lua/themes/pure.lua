-- Color scheme
_G.color = {
    common = {
        normal ={ fg = '#c1c3c9', bg = '#1b1b1b', },
        interface = { bg = '#272729', fg = '#46494f', },
        dark = '#121212',
    },
    whitespace = { normal = '#383838', extra = '#ff0000', },
    visual_select = { bg = '#383838' },
    inactive_tab = { fg = '#a0a6b0' },
    diff_text = { bg = '#0f4747' },
    color_column = { bg = '#181818' },
    fold = { fg = '#15ebeb', bg = '#40444a', },
    search = {
        current_match = { fg = '#07080d', bg = '#fce094', },
        other_match = { fg = '#2a2e36', bg = '#b8a06c', },
        incremental = { fg = '#bf616a', bg = '#2a2e36', },
    },
    mode = {
        normal = {
            mode = { fg = '#a0a6b0', bg = '#121212', },
            main = { fg = '#c1c3c9', bg = '#272929', },
            line = { fg = '#a0a6b0', bg = '#272929', },
            count = { fg = '#ced4de', bg = '#121212', },
            inactive = { fg = '#c1c3c9', bg = '#272929', },
        },
        insert = {
            mode = { fg = '#eceff4', bg = '#254569', },
            main = { fg = '#eceff4', bg = '#406c9c', },
            line = { fg = '#eceff4', bg = '#406c9c', },
            count = { fg = '#eceff4', bg = '#254569', },
            inactive = { fg = '#c1c3c9', bg = '#272929', },
        },
        visual = {
            mode = { fg = '#eceff4', bg = '#1d632e', },
            main = { fg = '#eceff4', bg = '#317542', },
            line = { fg = '#eceff4', bg = '#317542', },
            count = { fg = '#eceff4', bg = '#1d632e', },
            inactive = { fg = '#c1c3c9', bg = '#272929', },
        },
        replace = {
            mode = { fg = '#eceff4', bg = '#85292b', },
            main = { fg = '#eceff4', bg = '#a3393b', },
            line = { fg = '#eceff4', bg = '#a3393b', },
            count = { fg = '#eceff4', bg = '#85292b', },
            inactive = { fg = '#c1c3c9', bg = '#272929', },
        },
    },
    code = {
        comment = '#4aa881',
        define = '#727d8f',
        statement = '#66a2de', -- type, etc
        string = '#cf8e6d',
        character = '#d08770',
        number = '#88caeb',
        identifier = '#bd5b5b',
        func = '#cfac67',
        special = '#875fff',
        error = { fg = '#d4dee6', bg = '#994e4e', },
    },
    bnote = {
        header = '#725fff',
        subheader = '#88caeb',
        code = '#787878',
        tag = '#303030',
    },
    rnote = {
        alert = '#632b2b',
        document = '#bd5b5b',
        chapter = '#ba6338',
        section = '#cf8e6d',
        subsection = '#cfac67',
        styled = '#66a2de',
        special = '#d07ad6',
        service = '#46494f',
    },
}

-- 16 colors
if vim.fn.has('termguicolors') == 1 and vim.opt.termguicolors:get() then
    vim.g.terminal_color_0 = '#1b1b1b'
    vim.g.terminal_color_1 = '#c9574f'
    vim.g.terminal_color_2 = '#51c46a'
    vim.g.terminal_color_3 = '#d1a245'
    vim.g.terminal_color_4 = '#4974bf'
    vim.g.terminal_color_5 = '#bb38c2'
    vim.g.terminal_color_6 = '#42cfc8'
    vim.g.terminal_color_7 = '#c8c8c8'
    vim.g.terminal_color_8 = '#606060'
    vim.g.terminal_color_9 = '#de3b2f'
    vim.g.terminal_color_10 = '#13e841'
    vim.g.terminal_color_11 = '#e3d134'
    vim.g.terminal_color_12 = '#1666f0'
    vim.g.terminal_color_13 = '#f70aeb'
    vim.g.terminal_color_14 = '#11f7ec'
    vim.g.terminal_color_15 = '#ffffff'
end
