return {
    {
        'tpope/vim-fugitive',
        config = function()
            vim.api.nvim_create_user_command('OpenGitStatus', function()
                local output = vim.fn.system('git rev-parse --is-inside-work-tree')
                if vim.v.shell_error ~= 0 then
                    print("Not inside work tree")
                    return
                end

                vim.cmd('tab G')
            end, {})

            vim.keymap.set('n', '<Leader>gl', ':Gclog -30 -- ')
            vim.keymap.set('n', '<Leader>gc', ':Git difftool --name-only ')
            vim.keymap.set('n', '<Leader>gd', ':Gvdiff ')
            vim.keymap.set('n', '<Leader>gs', ':OpenGitStatus<CR>')
        end,
    },
    {
        "junegunn/fzf",
        build = function()
            vim.fn["fzf#install"]()
        end,
        config = function()
            vim.keymap.set("n", "<C-p>", ":FZF<CR>", { noremap = true, silent = true })
        end,
    },
    {
        'jlanzarotta/bufexplorer',
        config = function()
            vim.g.bufExplorerDisableDefaultKeyMapping = 1
            vim.g.bufExplorerDefaultHelp = 0

            vim.keymap.set('n', '<F8>', ':ToggleBufExplorer<CR>')
        end
    },
    {
        'bfrg/vim-cpp-modern',
        config = function()
            vim.g.cpp_member_highlight = 1
            vim.g.cpp_no_function_highlight = 0
            vim.g.cpp_attributes_highlight = 0
        end
    }
}
