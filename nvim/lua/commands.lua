-- Search commands
vim.api.nvim_create_user_command('Rg', function(opts)
  Rg(unpack(vim.split(opts.args, '%s+')))
end, { nargs = '+' })

vim.api.nvim_create_user_command('Rgl', function(opts)
  Rgl(unpack(vim.split(opts.args, '%s+')))
end, { nargs = '+' })

vim.api.nvim_create_user_command('Rge', function(opts)
  Rge(unpack(vim.split(opts.args, '%s+')))
end, { nargs = '+' })

-- Autocommands
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'git',
  callback = function()
    vim.opt_local.foldmethod = 'syntax'
  end
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    vim.cmd('syntax sync minlines=50')
  end
})

vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  callback = SetCodeViewMode,
  group = vim.api.nvim_create_augroup('VimEnterSettings', { clear = true })
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.winhl = "Normal:Normal"
  end,
})
