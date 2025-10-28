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

-- Other
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

-- Utils
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
