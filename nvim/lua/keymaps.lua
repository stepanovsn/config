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
    else
        enable_russian_mappings()
        vim.g.russianMode = true
        print('Russian mode enabled')
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

-- Fugitive
vim.keymap.set('n', '<Leader>gs', function() OpenGitStatus() end)
