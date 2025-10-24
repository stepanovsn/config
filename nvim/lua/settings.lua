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

-- Tabline
function _G.my_tabline()
    local current_tab = vim.fn.tabpagenr()
    local total_tabs = vim.fn.tabpagenr('$')
    local tabline = ''

    local extra_tabs_on_right = current_tab < 4 and 4 - current_tab or 0
    local extra_tabs_on_left = current_tab + 3 > total_tabs and current_tab + 3 - total_tabs or 0

    local first_tab_to_display = current_tab - 3 - extra_tabs_on_left
    local last_tab_to_display = current_tab + 3 + extra_tabs_on_right

    local show_dots_at_start = first_tab_to_display > 1 and true or false
    local show_dots_at_end = last_tab_to_display < total_tabs and true or false

    local first_tab_to_display = math.max(first_tab_to_display, 1)
    local last_tab_to_display = math.min(last_tab_to_display, total_tabs)

    if show_dots_at_start then
        tabline = tabline .. '%#TabLine#... '
    end

    for i = first_tab_to_display, last_tab_to_display do
        local buflist = vim.fn.tabpagebuflist(i)
        local winnr = vim.fn.tabpagewinnr(i)
        local bufnr = buflist[winnr]
        local bufname = vim.fn.bufname(bufnr)
        local filetype = vim.fn.getbufvar(bufnr, '&filetype')

        local is_current = i == current_tab

        tabline = tabline .. '%' .. i .. 'T'
        tabline = tabline .. (is_current and '%#TabLineSel#' or '%#TabLine#')
        tabline = tabline ..  ' ' .. i .. ':'

        tabline = tabline .. get_custom_tab_name(bufname, filetype, bufnr)

        if vim.fn.getbufvar(bufnr, '&modified') == 1 then
            tabline = tabline .. ' [+]'
        end

        tabline = tabline .. ' %T'
    end

    if show_dots_at_end then
        tabline = tabline .. '%#TabLine# ...'
    end

    local cwd = vim.fn.getcwd()
    cwd = cwd:gsub('^' .. vim.env.HOME, '~')
    if #cwd > 30 then
        cwd = '..' .. cwd:sub(-29)
    end

    tabline = tabline .. '%#TabLineFill#%= ' .. cwd .. ' '
    return tabline
end

function get_custom_tab_name(bufname, filetype, bufnr)
    if bufname == '' then
        return '[noname]'
    elseif filetype == 'fugitive' then
        return '[git]'
    else
        return vim.fn.fnamemodify(bufname, ':t')
    end
end

vim.opt.tabline = "%!v:lua.my_tabline()"
