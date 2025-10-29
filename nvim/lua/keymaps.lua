-- Window navigation and manipulation
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')

vim.keymap.set('n', '<C-w>n', function() vim.cmd.vnew() end)

vim.keymap.set('n', '<C-q>', function() vim.cmd.quit() end)

-- Tab navigation and manipulation
vim.keymap.set('n', '<A-n>', '<cmd>tabnew<CR>')
vim.keymap.set('n', '<A-c>', '<cmd>tabclose<CR>')
vim.keymap.set('n', '<A-o>', '<cmd>tabonly<CR>')

vim.keymap.set('n', '<A-h>', '<cmd>tabprevious<CR>')
vim.keymap.set('n', '<A-l>', '<cmd>tabnext<CR>')

for i = 1, 9 do
  vim.keymap.set('n', '<A-' .. i .. '>', i .. 'gt')
end

vim.keymap.set('n', '<A-0>', '10gt')

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
vim.keymap.set('n', '<F2>', ':Rg<Space>')
vim.keymap.set('n', '<F3>', ':Rgl<Space>')
vim.keymap.set('n', '<F4>', ':Rge<Space>')
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

-- File format
vim.keymap.set('n', '<Leader>ru', ':e ++ff=unix<CR>')
vim.keymap.set('n', '<Leader>rd', ':e ++ff=dos<CR>')
vim.keymap.set('n', '<Leader>rm', ':e ++ff=mac<CR>')
vim.keymap.set('n', '<Leader>rcu', ':setlocal ff=unix<CR>')
vim.keymap.set('n', '<Leader>rcd', ':setlocal ff=dos<CR>')
vim.keymap.set('n', '<Leader>rcm', ':setlocal ff=mac<CR>')
vim.keymap.set('n', '<Leader>rx', ':%s/\\r//g<CR>')

-- Tabulation
vim.keymap.set('n', '<Leader>tt', function() vim.opt.expandtab = false end)
vim.keymap.set('n', '<Leader>ts', function() vim.opt.expandtab = true end)

vim.keymap.set('n', '<Leader>t2', function() vim.opt.tabstop = 2 end)
vim.keymap.set('n', '<Leader>t4', function() vim.opt.tabstop = 4 end)
vim.keymap.set('n', '<Leader>t8', function() vim.opt.tabstop = 8 end)

vim.keymap.set('n', '<Leader>tr', function() vim.cmd.retab('!') end)

-- Lf
vim.keymap.set('n', '<C-n>', function() _G.open_lf({ file = true, open = true }) end)
vim.keymap.set('n', '<C-b>', function() _G.open_lf({ file = false, open = true }) end)
vim.keymap.set('n', '<Leader>n', function() _G.open_lf({ file = true, open = false }) end)
vim.keymap.set('n', '<Leader>b', function() _G.open_lf({ file = false, open = false }) end)

-- Toggle
vim.keymap.set('n', '<F9>', function()
    if vim.opt.hlsearch:get() and vim.v.hlsearch == 1 then
        vim.cmd.nohlsearch()
    else
        vim.opt.hlsearch = true
    end
end, { desc = 'Toggle search highlighting' })

vim.keymap.set({'n', 'v', 'o'}, '<F10>', ToggleRussianMode)
vim.keymap.set('i', '<F10>', '<C-o>:lua ToggleRussianMode()<CR>')

-- Modes
vim.keymap.set('n', '<Leader>vc', SetCodeViewMode)
vim.keymap.set('n', '<Leader>vr', SetReaderViewMode)
vim.keymap.set('n', '<Leader>vm', SetMinimalViewMode)

-- Commenting
vim.keymap.set('v', '<leader>cc', _G.comment_selection)
vim.keymap.set('v', '<leader>cu', _G.uncomment_selection)

-- Keymap: Motion on wrapped lines
vim.keymap.set({'n', 'v'}, '<A-j>', 'gj')
vim.keymap.set({'n', 'v'}, '<A-k>', 'gk')

-- Keymap: Marks
vim.keymap.set('n', '<Leader>ml', ':marks ABCDEFGHIJKLMNOPQRSTUVWXYZ<CR>')
vim.keymap.set('n', '<Leader>mc', ':delm A-Z<CR>')

-- Keymap: Tag navigation
vim.keymap.set('n', 'tn', ':tn<CR>')
vim.keymap.set('n', 'tp', ':tp<CR>')

-- Other
vim.keymap.set('n', '<Leader>u', ':mod<CR>')

vim.keymap.set('n', '<Leader>ac', ClangTidy)

vim.keymap.set('n', '<Leader>p', '"0p')
vim.keymap.set('n', '<Leader>P', '"0P')

-- Rnote
vim.keymap.set('n', '<Leader>isb', 'a\\bold{}<ESC>i')
vim.keymap.set('v', '<Leader>isb', 'c\\bold{<C-R>"}<ESC>')
vim.keymap.set('n', '<Leader>isi', 'a\\italic{}<ESC>i')
vim.keymap.set('v', '<Leader>isi', 'c\\italic{<C-R>"}<ESC>')
vim.keymap.set('n', '<Leader>ism', 'a\\math{}<ESC>i')
vim.keymap.set('v', '<Leader>ism', 'c\\math{<C-R>"}<ESC>')
vim.keymap.set('n', '<Leader>isr', 'a\\reference{}<ESC>i')
vim.keymap.set('n', '<Leader>isl', 'a\\link[text=""]{}<ESC>i')
vim.keymap.set('v', '<Leader>isl', 'c\\link[text=""]{<C-R>"}<ESC>')
vim.keymap.set('n', '<Leader>isc', 'a\\code{}<ESC>i')
vim.keymap.set('v', '<Leader>isc', 'c\\code{<C-R>"}<ESC>')
vim.keymap.set('n', '<Leader>ise', 'o\\listing[numbered syntax="cpp"]<ESC>o')
vim.keymap.set('n', '<Leader>ist', 'a\\tag<ESC>i')
vim.keymap.set('n', '<Leader>iss', 'o\\set[italic bold]<ESC>o')
vim.keymap.set('n', '<Leader>isn', 'a\\line<ESC>o')

vim.keymap.set('n', '<Leader>ihd', 'O\\document[lang=eng]{}<ESC>i')

vim.keymap.set('n', '<Leader>ihc', 'O\\chapter{}<ESC>i')
vim.keymap.set('n', '<Leader>ihs', 'O\\section{}<ESC>i')
vim.keymap.set('n', '<Leader>ihu', 'O\\subsection[clear]{}<ESC>i')

vim.keymap.set('n', '<Leader>it', 'o\\text<ESC>')
vim.keymap.set('n', '<Leader>ie', 'o\\thead<Enter> \\cell  \\cell  \\end<Enter><Left>\\tbody<ESC>$<Delete><Up>0i')
vim.keymap.set('n', '<Leader>ia', 'o\\annotation<Enter> \\split  \\end<ESC>0i')
vim.keymap.set('n', '<Leader>ii', 'o\\image[title="Title" width="400" refbyname]{}<ESC>i')
vim.keymap.set('n', '<Leader>ib', 'o\\imageblock[groupby="2" width="1000"]<ESC>o\\item[title="Title" refbyname]{}<ESC>i')
vim.keymap.set('n', '<Leader>if', 'o\\formula{}<ESC>i')
