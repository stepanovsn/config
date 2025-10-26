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
vim.opt.showmode = false

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
vim.fn.matchadd('ExtraWhitespace', '\\s\\+$', 10)

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
        tabline = tabline ..  ' ' .. i .. ' '

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

-- Statusline
local function get_normalized_mode()
    local mode = vim.fn.mode()

    if mode == 'n' or mode == 'no' then
        return 'normal'
    elseif mode == 'i' then
        return 'insert'
    elseif mode == 'v' or mode == 'V' or mode == '' then
        return 'visual'
    elseif mode == 'c' then
        return 'command'
    elseif mode == 'r' or mode == 'R' then
        return 'replace'
    elseif mode == 't' then
        return 'terminal'
    else
        return 'normal'
    end
end

local mode_names = {
    normal = 'NORMAL',
    insert = 'INSERT',
    visual = 'VISUAL',
    command = 'COMMAND',
    replace = 'REPLACE',
    terminal = 'TERMINAL',
}

local mode_colors = {
    normal = 'normal',
    command = 'normal',
    terminal = 'normal',
    insert = 'insert',
    visual = 'visual',
    replace = 'replace',
}

function _G.my_statusline()
    local mode = get_normalized_mode()
    local color_name = mode_colors[mode]
    local colors = color.mode[color_name] or color.mode.normal
    local mode_name = mode_names[mode] or 'NORMAL'
    local is_active = vim.g.statusline_winid == vim.fn.win_getid()

    vim.api.nvim_set_hl(0, 'StatusLineMode', { bg = colors.mode.bg, fg = colors.mode.fg })
    vim.api.nvim_set_hl(0, 'StatusLineMain', { bg = colors.main.bg, fg = colors.main.fg })
    vim.api.nvim_set_hl(0, 'StatusLine', { bg = colors.line.bg, fg = colors.line.fg })
    vim.api.nvim_set_hl(0, 'StatusLineCount', { bg = colors.count.bg, fg = colors.count.fg })
    vim.api.nvim_set_hl(0, 'StatusLineInactive', { bg = colors.inactive.bg, fg = colors.inactive.fg })

    local status = ""

    if is_active then
        status = status .. "%#StatusLineMode# " .. mode_name .. " "

        status = status .. "%#StatusLineMain# %t"
        status = status .. "%{&modified ? '[+]' : ''}"
        status = status .. "%{&readonly ? '[RO]' : ''}"
        status = status .. "%="

        status = status .. "%#StatusLine# %{&fileencoding != '' ? &fileencoding : &encoding} "
        status = status .. "%{&fileformat} "
        if vim.bo.filetype ~= '' then
            status = status .. "%{&filetype} "
        end
        status = status .. " "

        status = status .. "%#StatusLineCount#  %L  "
        status = status .. "%#StatusLineMain#  %c  %#StatusLine#"
    else
        status = status .. "%#StatusLineInactive# %t"
    end

    return status
end

vim.opt.laststatus = 2
vim.opt.statusline = "%!v:lua.my_statusline()"
