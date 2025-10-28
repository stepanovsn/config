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
vim.keymap.set({'n', 'v', 'o'}, '<F10>', ToggleRussianMode)
vim.keymap.set('i', '<F10>', '<C-o>:lua ToggleRussianMode()<CR>')

-- Lf
vim.keymap.set('n', '<C-b>', function() _G.open_lf({ file = false, open = true }) end)
vim.keymap.set('n', '<C-n>', function() _G.open_lf({ file = true, open = true }) end)
vim.keymap.set('n', '<Leader>b', function() _G.open_lf({ file = false, open = false }) end)
vim.keymap.set('n', '<Leader>n', function() _G.open_lf({ file = true, open = false }) end)

-- Commenting
vim.keymap.set('v', '<leader>cc', _G.comment_selection)
vim.keymap.set('v', '<leader>cu', _G.uncomment_selection)
