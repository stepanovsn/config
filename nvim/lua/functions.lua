-- View modes
function SetCodeViewMode()
  vim.opt.numberwidth = 6
  vim.opt.relativenumber = true
  vim.opt.number = true
  vim.opt.cursorline = true
  vim.opt.cursorlineopt = 'number'
  vim.opt.list = true
  vim.opt.cmdheight = 1
  vim.opt.laststatus = 2
  vim.opt.showtabline = 2
  vim.opt.guicursor:remove('a:Cursor')
  vim.opt.conceallevel = 0
  vim.opt.colorcolumn = '120,160'
end

function SetReaderViewMode()
  vim.opt.numberwidth = 12
  vim.opt.relativenumber = false
  vim.opt.number = true
  vim.opt.cursorline = false
  vim.opt.list = false
  vim.opt.cmdheight = 0
  vim.opt.laststatus = 0
  vim.opt.showtabline = 0
  vim.opt.guicursor:append('a:Cursor')
  vim.opt.conceallevel = 2
  vim.opt.colorcolumn = ''
end

function SetMinimalViewMode()
  vim.opt.numberwidth = 6
  vim.opt.relativenumber = false
  vim.opt.number = false
  vim.opt.cursorline = false
  vim.opt.list = false
  vim.opt.cmdheight = 1
  vim.opt.laststatus = 2
  vim.opt.showtabline = 2
  vim.opt.guicursor:remove('a:Cursor')
  vim.opt.conceallevel = 0
  vim.opt.colorcolumn = '120,160'
end

-- Search
function Rg(...)
  local search_string = table.concat({ ... }, ' ')
  local grepprg = vim.opt.grepprg:get()
  local cmd = grepprg .. " -F -l '" .. search_string .. "'"
  local output = vim.fn.system(cmd)
  local files = vim.fn.split(output, '\n')

  vim.fn.setqflist({}, ' ', { lines = files, efm = '%f' })
  OpenQflist()
  vim.fn.setreg('/', EscapeVimRegexp(search_string))
end

function Rgl(...)
  local search_string = table.concat({ ... }, ' ')
  local grepprg = vim.opt.grepprg:get()
  local cmd = grepprg .. " -F '" .. search_string .. "'"
  local output = vim.fn.system(cmd)
  local lines = vim.fn.split(output, '\n')

  vim.fn.setqflist({}, ' ', { lines = lines })
  OpenQflist()
end

function Rge(...)
  local search_string = table.concat({ ... }, ' ')
  local grepprg = vim.opt.grepprg:get()
  local cmd = grepprg .. " '" .. search_string .. "'"
  local output = vim.fn.system(cmd)
  local lines = vim.fn.split(output, '\n')

  vim.fn.setqflist({}, ' ', { lines = lines })
  OpenQflist()
end

function SearchLocal(str)
  if str == '' then
    return
  end

  local escaped_str = EscapeVimRegexp(str)
  vim.cmd('normal! :nohlsearch\\<CR>')
  vim.fn.search(escaped_str)
  vim.fn.setreg('/', escaped_str)
  vim.opt.hlsearch = true
end

-- Substitute
function SubstituteClean(str)
  vim.fn.feedkeys(':%s/' .. EscapeVimRegexp(str) .. '//gc')
  FeedLeftKey(3)
end

function SubstituteReplace(str)
  vim.fn.feedkeys(':%s/' .. EscapeVimRegexp(str) .. '/' .. str .. '/gc')
  FeedLeftKey(3)
end

function SubstituteCleanInScope(scope, str)
  vim.fn.feedkeys(':' .. scope .. ' %s/' .. EscapeVimRegexp(str) .. '//ge | update')
  FeedLeftKey(12)
end

function SubstituteReplaceInScope(scope, str)
  vim.fn.feedkeys(':' .. scope .. ' %s/' .. EscapeVimRegexp(str) .. '/' .. str .. '/ge | update')
  FeedLeftKey(12)
end

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

function _G.create_statusline()
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

-- Tabline
function _G.create_tabline()
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

function MoveTabToPosition(pos)
  local total_index = vim.fn.tabpagenr('$')
  if pos > total_index then
    return
  end

  local current_index = vim.fn.tabpagenr()
  if pos > current_index then
    vim.cmd('tabm ' .. pos)
  else
    vim.cmd('tabm ' .. (pos - 1))
  end
end

-- Russian mode
vim.g.russianMode = vim.g.russianMode or false

function _G.ToggleRussianMode(...)
    if vim.g.russianMode then
        disable_russian_mappings()
        vim.g.russianMode = false
        print('Russian mode disabled')
        -- @todo Display in statusline
        vim.api.nvim_command('redrawstatus')
    else
        enable_russian_mappings()
        vim.g.russianMode = true
        print('Russian mode enabled')
        -- @todo Display in statusline
        vim.api.nvim_command('redrawstatus')
    end
end

function enable_russian_mappings()
    local mappings = {
        ['@'] = '"', ['#'] = '№', ['$'] = ';', ['^'] = ':', ['&'] = '?',
        ['q'] = 'й', ['w'] = 'ц', ['e'] = 'у', ['r'] = 'к', ['t'] = 'е',
        ['y'] = 'н', ['u'] = 'г', ['i'] = 'ш', ['o'] = 'щ', ['p'] = 'з',
        ['['] = 'х', [']'] = 'ъ', ['a'] = 'ф', ['s'] = 'ы', ['d'] = 'в',
        ['f'] = 'а', ['g'] = 'п', ['h'] = 'р', ['j'] = 'о', ['k'] = 'л',
        ['l'] = 'д', [';'] = 'ж', ["'"] = 'э', ['z'] = 'я', ['x'] = 'ч',
        ['c'] = 'с', ['v'] = 'м', ['b'] = 'и', ['n'] = 'т', ['m'] = 'ь',
        [','] = 'б', ['.'] = 'ю', ['/'] = '.', ['Q'] = 'Й', ['W'] = 'Ц',
        ['E'] = 'У', ['R'] = 'К', ['T'] = 'Е', ['Y'] = 'Н', ['U'] = 'Г',
        ['I'] = 'Ш', ['O'] = 'Щ', ['P'] = 'З', ['{'] = 'Х', ['}'] = 'Ъ',
        ['A'] = 'Ф', ['S'] = 'Ы', ['D'] = 'В', ['F'] = 'А', ['G'] = 'П',
        ['H'] = 'Р', ['J'] = 'О', ['K'] = 'Л', ['L'] = 'Д', [':'] = 'Ж',
        ['"'] = 'Э', ['Z'] = 'Я', ['X'] = 'Ч', ['C'] = 'С', ['V'] = 'М',
        ['B'] = 'И', ['N'] = 'Т', ['M'] = 'Ь', ['<'] = 'Б', ['>'] = 'Ю',
        ['?'] = ','
    }

    for key, value in pairs(mappings) do
        vim.keymap.set('i', key, value, { noremap = true, silent = true })
    end
end

function disable_russian_mappings()
    local keys = {
        '@', '#', '$', '^', '&', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p',
        '[', ']', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', "'", 'z', 'x',
        'c', 'v', 'b', 'n', 'm', ',', '.', '/', 'Q', 'W', 'E', 'R', 'T', 'Y', 'U',
        'I', 'O', 'P', '{', '}', 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':',
        '"', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', '<', '>', '?'
    }

    for _, key in ipairs(keys) do
        pcall(vim.keymap.del, 'i', key)
    end
end

-- lf
function _G.open_lf(opts)
    local cmd = "lf "

    if opts.open then
        cmd = cmd .. "-selection-path /tmp/lf_file "
    else
        cmd = cmd .. "-last-dir-path /tmp/lf_file "
    end

    if opts.file then
        local filename = vim.fn.expand('%:p')
        if filename == '' then
            cmd = cmd .. vim.fn.getcwd()
        else
            cmd = cmd .. filename
        end
    else
        cmd = cmd .. vim.fn.getcwd()
    end

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = col,
        row = row,
        style = 'minimal',
        border = 'rounded'
    })

    vim.fn.termopen(cmd, {
        cwd = cwd,
        on_exit = function(_, exit_code)
            vim.api.nvim_win_close(win, true)
            vim.defer_fn(function()
                if vim.api.nvim_buf_is_valid(buf) then
                    vim.api.nvim_buf_delete(buf, {force = true})
                end
            end, 10)

            if exit_code == 0 and vim.loop.fs_stat("/tmp/lf_file") ~= nil then
                local output = vim.fn.system('cat /tmp/lf_file')
                if output and output ~= "" then
                    local path = vim.trim(output)
                    if opts.open then
                        vim.cmd("edit " .. vim.fn.fnameescape(path))
                    else
                        vim.cmd("cd " .. vim.fn.fnameescape(path))
                    end
                end
            end
            vim.fn.system('rm -f /tmp/lf_file')
        end
    })

    vim.cmd('startinsert')
end

-- Commenting
comment_strings = {
  lua = '--',
  python = '#',
  javascript = '//',
  typescript = '//',
  c = '//',
  cpp = '//',
  java = '//',
  php = '//',
  ruby = '#',
  sh = '#',
  vim = '"',
  sql = '--',
  yaml = '#',
  json = '//',
  rust = '//',
  go = '//',
  _default = '#'
}

local function get_comment_string()
    local ft = vim.bo.filetype
    return comment_strings[ft] or comment_strings._default
end

function _G.uncomment_selection()
    local mode = vim.fn.mode()
    if mode ~= 'V' then
        print("Not in visual line mode")
        return
    end

    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")

    if start_line > end_line then
        start_line, end_line = end_line, start_line
    end

    local comment_str = get_comment_string()
    local comment_str_spaced = comment_str .. ' '
    local lines = {}

    for i = start_line, end_line do
        local line = vim.fn.getline(i)
        local leading_ws = line:match('^(%s*)') or ''
        local content = line:sub(#leading_ws + 1)

        if content:sub(1, #comment_str_spaced) == comment_str_spaced then
            content = content:sub(#comment_str_spaced + 1)
        elseif content:sub(1, #comment_str) == comment_str then
            content = content:sub(#comment_str + 1)
        end

        lines[#lines + 1] = leading_ws .. content
    end

    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
    vim.api.nvim_input('<Esc>')
end

function _G.comment_selection()
    local mode = vim.fn.mode()
    if mode ~= 'V' then
        print("Not in visual line mode")
        return
    end

    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")

    if start_line > end_line then
        start_line, end_line = end_line, start_line
    end

    local comment_str = get_comment_string()
    local lines = {}

    for i = start_line, end_line do
        local line = vim.fn.getline(i)
        local leading_ws = line:match('^(%s*)') or ''
        local content = line:sub(#leading_ws + 1)
        lines[#lines + 1] = leading_ws .. comment_str .. ' ' .. content
    end

    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
    vim.api.nvim_input('<Esc>')
end

-- Utils
function OpenQflist()
  vim.cmd('copen')

  local qflist = vim.fn.getqflist()
  local length = #qflist + 1

  if length > 15 then
    length = 15
  elseif length < 3 then
    length = 3
  end

  vim.cmd('resize ' .. length)
end

function EscapeVimRegexp(str)
  return vim.fn.escape(str, '^$.*~/[\\]')
end

function FeedLeftKey(count)
  vim.api.nvim_input(string.rep('<Left>', count))
end

function GetVisualSelection()
    local saved_register = vim.fn.getreg('"')
    local saved_register_type = vim.fn.getregtype('"')

    vim.cmd('normal! "xy')
    local selected_text = vim.fn.getreg('x')
    vim.fn.setreg('"', saved_register, saved_register_type)

    return selected_text
end
