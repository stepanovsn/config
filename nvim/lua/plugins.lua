return {
    {
        "ptzz/lf.vim",
        config = function()
            vim.g.lf_map_keys = 0

            vim.api.nvim_create_user_command('LfcdCurrentFile', function()
                vim.cmd('call OpenLfIn("%", "cd")')
            end, {})

            local keymap = vim.keymap.set

            keymap('n', '<C-n>', ':Lf<CR>', { noremap = true, silent = true })
            keymap('n', '<C-b>', ':LfWorkingDirectory<CR>', { noremap = true, silent = true })
            keymap('n', '<Leader>n', ':LfcdCurrentFile<CR>', { noremap = true, silent = true })
            keymap('n', '<Leader>b', ':Lfcd<CR>', { noremap = true, silent = true })
        end,
    },
    {
        "voldikss/vim-floaterm",
        config = function()
            vim.g.floaterm_height = 0.7
            vim.g.floaterm_width = 0.9
        end,
    },
}
