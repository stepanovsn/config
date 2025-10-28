-- Tab navigation
vim.keymap.set('n', '<A-h>', '<cmd>tabprevious<CR>')
vim.keymap.set('n', '<A-l>', '<cmd>tabnext<CR>')
vim.keymap.set('n', '<A-n>', '<cmd>tabnew<CR>')
vim.keymap.set('n', '<A-c>', '<cmd>tabclose<CR>')
vim.keymap.set('n', '<A-o>', '<cmd>tabonly<CR>')

for i = 1, 9 do
  vim.keymap.set('n', '<A-' .. i .. '>', i .. 'gt')
end

vim.keymap.set('n', '<A-0>', '10gt')

-- Tab movement
vim.keymap.set('n', '<A-m>h', '<cmd>tabmove -1<CR>')
vim.keymap.set('n', '<A-m>l', '<cmd>tabmove +1<CR>')

for i = 1, 9 do
  vim.keymap.set('n', '<A-m>' .. i, function()
    MoveTabToPosition(i)
  end)
end

vim.keymap.set('n', '<A-m>0', function()
  MoveTabToPosition(10)
end)

-- Search
vim.keymap.set('n', '<F5>', ':Rg<Space>')
vim.keymap.set('n', '<F6>', ':Rgl<Space>')
vim.keymap.set('n', '<F7>', ':Rge<Space>')
vim.keymap.set('n', '<Leader>f', ':Rg<Space><C-r><C-w><CR>')

vim.keymap.set('v', '<Leader>f', function()
    local selected_text = GetVisualSelection()
    if selected_text and selected_text ~= '' then
        Rg(selected_text)
    else
        print('No text selected')
    end
end)

vim.keymap.set('v', '<Leader>l', function()
    local selected_text = GetVisualSelection()
    if selected_text and selected_text ~= '' then
        SearchLocal(selected_text)
    else
        print('No text selected')
    end
end)

-- Substitute
vim.keymap.set('n', '<Leader>sc', ':%s/\\<<C-r><C-w>\\>//gc<Left><Left><Left>')
vim.keymap.set('n', '<Leader>sr', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gc<Left><Left><Left>')

vim.keymap.set('v', '<Leader>sc', function()
  local selection = GetVisualSelection()
  if selection and selection ~= '' then
    SubstituteClean(selection)
  end
end)

vim.keymap.set('v', '<Leader>sr', function()
  local selection = GetVisualSelection()
  if selection and selection ~= '' then
    SubstituteReplace(selection)
  end
end)

vim.keymap.set('v', '<Leader>sbc', function()
  local selection = GetVisualSelection()
  if selection and selection ~= '' then
    SubstituteCleanInScope("bufdo", selection)
  end
end)

vim.keymap.set('v', '<Leader>sbr', function()
  local selection = GetVisualSelection()
  if selection and selection ~= '' then
    SubstituteReplaceInScope("bufdo", selection)
  end
end)

vim.keymap.set('v', '<Leader>sac', function()
  local selection = GetVisualSelection()
  if selection and selection ~= '' then
    SubstituteCleanInScope("argdo", selection)
  end
end)

vim.keymap.set('v', '<Leader>sar', function()
  local selection = GetVisualSelection()
  if selection and selection ~= '' then
    SubstituteReplaceInScope("argdo", selection)
  end
end)

-- Modes
vim.keymap.set('n', '<Leader>vc', SetCodeViewMode)
vim.keymap.set('n', '<Leader>vr', SetReaderViewMode)
vim.keymap.set('n', '<Leader>vm', SetMinimalViewMode)

-- Russian mode
vim.g.russianMode = vim.g.russianMode or false

function ToggleRussianMode(...)
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

-- Other
vim.keymap.set({'n', 'v', 'o'}, '<F10>', ToggleRussianMode)
vim.keymap.set('i', '<F10>', '<C-o>:lua ToggleRussianMode()<CR>')

-- Lf
local function open_lf(opts)
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

vim.keymap.set('n', '<C-b>', function() open_lf({ file = false, open = true }) end)
vim.keymap.set('n', '<C-n>', function() open_lf({ file = true, open = true }) end)
vim.keymap.set('n', '<Leader>b', function() open_lf({ file = false, open = false }) end)
vim.keymap.set('n', '<Leader>n', function() open_lf({ file = true, open = false }) end)

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

function uncomment_selection()
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

function comment_selection()
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

vim.keymap.set('v', '<leader>cc', comment_selection)
vim.keymap.set('v', '<leader>cu', uncomment_selection)
