-- Set termguicolors if supported
local handle = io.popen('tput colors')
local result = handle:read('*a')
handle:close()

if result and tonumber(result) > 8 then
  vim.opt.termguicolors = true
end

-- Syntax and basic settings
vim.cmd('syntax enable')
vim.opt.ffs = 'unix,dos,mac'
vim.opt.timeoutlen = 3000
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Cursor and mouse
vim.opt.guicursor = 'a:block-blinkon1,i:ver100-blinkon1'
vim.opt.mouse = ''
vim.opt.concealcursor = 'n'

-- Diff options
vim.opt.diffopt = 'filler,context:18,vertical'

-- Tab and indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Color scheme
local color_scheme = os.getenv('REG_CONSOLE_COLOR_SCHEME') or 'pure'
require('themes.' .. color_scheme)

-- Invisible characters
vim.opt.listchars = 'tab:>·,space:·,trail:~'
vim.opt.list = true

-- Ctags
vim.opt.tags = './tags,tags;$HOME'

-- Set grep program
vim.opt.grepprg = 'rg --vimgrep'

-- Syntax
vim.cmd('match ExtraWhitespace /\\s\\+$/')
