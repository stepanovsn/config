" Install required plugins
call plug#begin('~/.local/share/nvim/site/plugged')
    Plug 'https://github.com/regular8/vim-airline.git'
    Plug 'https://github.com/regular8/nerdtree.git'
    Plug 'tpope/vim-fugitive'
    Plug 'bfrg/vim-cpp-modern'
    Plug 'scrooloose/nerdcommenter'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

set ignorecase
set smartcase
set timeoutlen=3000

" Cursor
au VimEnter * set guicursor=a:block-blinkon1

" Diff
set diffopt=filler,context:18
set diffopt+=vertical

" Line numbers
set numberwidth=6
set relativenumber
set number

" Tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent
set smartindent

" Invisible characters
:set listchars=tab:>·,space:·,trail:~
:set list
hi ExtraWhitespace ctermfg=9
match ExtraWhitespace /\s\+$/

" Ruler
set colorcolumn=120
hi ColorColumn ctermbg=236

" Colors
hi VertSplit ctermfg=237 ctermbg=237
hi StatusLine ctermfg=237 ctermbg=237
hi StatusLineNC ctermfg=237 ctermbg=237
hi LineNr ctermfg=245
hi CursorLineNr ctermbg=237 ctermfg=110
hi Normal ctermbg=235 ctermfg=254
hi EndOfBuffer ctermfg=235
hi CursorLine cterm=none ctermbg=237
hi DiffAdd ctermbg=236
hi DiffDelete ctermbg=234 ctermfg=234
hi DiffChange ctermbg=236
hi DiffText ctermbg=23
hi FoldColumn cterm=none ctermbg=239 ctermfg=14
hi Folded cterm=none ctermbg=239 ctermfg=14
hi Search ctermbg=11 ctermfg=232
hi Whitespace ctermfg=238

" Ctags
set tags=./tags,tags;$HOME

" Grep
set grepprg=rg\ --vimgrep\ --hidden\ --smart-case\ --no-ignore-dot
command! -nargs=+ Rg call Rg(<f-args>)
command! -nargs=+ Rge call Rge(<f-args>)

" Airline: Statusline settings
let g:airline_theme='regular'
let g:airline#extensions#wordcount#enabled=0
let g:airline#extensions#whitespace#checks=[]

" Ariline: Tabline settings
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_splits=0
let g:airline#extensions#tabline#show_buffers=0
let g:airline#extensions#tabline#show_tab_count=2
let g:airline#extensions#tabline#tab_nr_type=1
let g:airline#extensions#tabline#left_sep=''
let g:airline#extensions#tabline#left_alt_sep=''
let g:airline#extensions#tabline#tabs_label=''
let g:airline#extensions#tabline#show_close_button=0
let g:airline#extensions#tabline#fnamemod=':t'

" Airline: Modemap
let g:airline_mode_map={
    \ '__'     : '-',
    \ 'c'      : 'COMMAND',
    \ 'i'      : 'INSERT',
    \ 'ic'     : 'INSERT',
    \ 'ix'     : 'INSERT',
    \ 'n'      : 'N',
    \ 'multi'  : 'MULTI',
    \ 'ni'     : 'NORMAL',
    \ 'no'     : 'NORMAL',
    \ 'R'      : 'REPLACE',
    \ 'Rv'     : 'REPLACE',
    \ 's'      : 'S',
    \ 'S'      : 'Sl',
    \ 't'      : 'T',
    \ 'v'      : 'VISUAL',
    \ 'V'      : 'VISUAL',
    \ }

" Airline: Initialization
function! AirlineInit()
    let g:airline_section_x=airline#section#create([])
    let g:airline_section_y=airline#section#create(['%{bufnr("%")} | ', 'ffenc', ' | %{line("$")} '])
    let g:airline_section_z=airline#section#create(['%{col(".")}'])

    hi airline_tab cterm=none ctermfg=239 ctermbg=234
    hi airline_tabsel cterm=none ctermfg=110 ctermbg=234
    hi airline_tabmod cterm=none ctermfg=110 ctermbg=234
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" NERDTree: Settings
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinSize=50
let g:NERDTreeShowHidden=1
let g:NERDTreeCascadeSingleChildDir=0
let g:NERDTreeDirArrowExpandable=' '
let g:NERDTreeDirArrowCollapsible=' '
let g:NERDTreeStatusline="%{getcwd()}"
let g:NERDTreeQuitOnOpen=0
let g:NERDTreeShowBookmarks=1
"au VimEnter * NERDTree

" NERDTree: Colors
hi NERDTreeDir ctermfg=72
hi NERDTreeUp ctermfg=72
hi NERDTreeCWD ctermfg=72
hi NERDTreeLinkFile ctermfg=75
hi NERDTreeLinkDir ctermfg=75
hi NERDTreeLinkTarget ctermfg=254
hi NERDTreeBookmark cterm=none ctermfg=245
hi NERDTreeBookmarkName cterm=none ctermfg=14
hi NERDTreeExecFile cterm=none ctermfg=254
hi NERDTreeIgnore ctermfg=245
hi NERDTreeDirSlash ctermfg=72

" Vim-cpp-modern: Settings
let g:cpp_member_highlight = 1
let g:cpp_no_function_highlight = 0
let g:cpp_attributes_highlight = 0

" Nerdcommenter: Settings
let g:NERDCustomDelimiters={
    \ 'c': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' }
    \ }

" Code colors
hi Comment ctermfg=71

hi PreProc ctermfg=247
hi Define ctermfg=247
hi Macro ctermfg=247
hi Include ctermfg=247

hi Type ctermfg=75
hi StorageClass ctermfg=75
hi Structure ctermfg=75
hi Typedef ctermfg=75

hi Constant ctermfg=247
hi String ctermfg=173
hi Character ctermfg=173
hi Number ctermfg=117
hi Boolean ctermfg=117
hi Float ctermfg=117

hi Statement ctermfg=75
hi Conditional ctermfg=75
hi Repeat ctermfg=75
hi Label ctermfg=75
hi Operator ctermfg=75
hi Keyword ctermfg=75
hi Exception ctermfg=75

hi Identifier ctermfg=89
hi Function ctermfg=222

hi Special ctermfg=99
hi SpecialChar ctermfg=99
hi Tag ctermfg=99
hi Delimiter ctermfg=99
hi SpecialComment ctermfg=99
hi Debug ctermfg=99

" Keymap: Split motion
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Keymap: Nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <Leader>n :NERDTreeFind<CR>

" Keymap: Tag navigation
nnoremap tp :tp<CR>
nnoremap tn :tn<CR>

" Keymap: Replace
nnoremap <Leader>sc :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
nnoremap <Leader>sr :%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>
vnoremap <Leader>sc :<c-u>call SubstituteClean(GetVisualSelection())<CR>
vnoremap <Leader>sr :<c-u>call SubstituteReplace(GetVisualSelection())<CR>

" Keymap: File format
nnoremap <Leader>eu :execute 'e ++ff=unix'<CR>
nnoremap <Leader>ed :execute 'e ++ff=dos'<CR>

" Keymap: Tabs
nnoremap <F2> :tabnew<CR>
nnoremap <F3> :tabclose<CR>
nnoremap <F4> :q<CR>

" Keymap: Spaces
nnoremap <Leader>tt :execute 'set noexpandtab \| %retab!'<CR>
nnoremap <Leader>ts :execute 'set expandtab \| %retab!'<CR>

" Keymap: Search
nnoremap <F5> :Rg 
nnoremap <F6> :FZF -e<CR>
vnoremap <Leader>fg :<c-u>call Rg(GetVisualSelection())<cr>
vnoremap <Leader>fl :<c-u>call SearchLocal(GetVisualSelection())<cr>

" Keymap: Git
nnoremap <Leader>gl :Glog -30 -- 
nnoremap <Leader>gs :execute 'tabnew \| Gstatus'<CR>
nnoremap <Leader>gc :Git difftool --name-only 
nnoremap <Leader>gd :Gvdiff 

" Keymap: Marks
nnoremap <Leader>ml :marks ABCDEFGHIJKLMNOPQRSTUVWXYZ<CR>
nnoremap <Leader>mc :delm A-Z<CR>

" Keymap: Toggling
nnoremap <silent><expr> <F9> (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
set pastetoggle=<Leader>p

" Keymap: Minimal mode
nnoremap <Leader>vm :execute 'set nonu \| set nornu \| set nolist'<CR>
nnoremap <Leader>vf :execute 'set nu \| set rnu \| set list'<CR>

" Functions
function! Rg(...)
    let searchString = join(a:000, ' ')
    let files = split(system(&grepprg . ' -F -l "' . searchString . '"'))
    call setqflist([], ' ', {'lines': files, 'efm': '%f'})
    copen
    let @/ = searchString
endfunction

function! Rge(...)
    let searchString = join(a:000, ' ')
    execute 'silent grep! "' . searchString . '"'
    copen
endfunction

function! GetVisualSelection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines,'\n')
endfunction

function! SubstituteClean(string)
    call feedkeys(":%s/" . a:string . "//gc\<Left>\<Left>\<Left>")
endfunction

function! SubstituteReplace(string)
    call feedkeys(":%s/" . a:string . "/" . a:string . "/gc\<Left>\<Left>\<Left>")
endfunction

function! SearchLocal(string)
    call feedkeys("/" . a:string . "\<CR>")
endfunction
