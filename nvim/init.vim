" Plugins
call plug#begin('~/.local/share/nvim/site/plugged')
    Plug 'git@github.com:stepanovsn/vim-airline.git'
    Plug 'jlanzarotta/bufexplorer'
    Plug '~/.fzf'
    Plug 'ptzz/lf.vim'
    Plug 'voldikss/vim-floaterm'
    Plug 'tpope/vim-fugitive'
    Plug 'bfrg/vim-cpp-modern'
    Plug 'scrooloose/nerdcommenter'
call plug#end()

" Settings: Main
set termguicolors
syntax enable
set ffs=unix,dos,mac
set timeoutlen=3000
set ignorecase
set smartcase
set guicursor=a:block-blinkon1
set guicursor+=i:ver100-blinkon1

" Settings: Diff
set diffopt=filler,context:18
set diffopt+=vertical

" Settings: Line numbers
set numberwidth=6
set relativenumber
set number
set cursorline
set cursorlineopt=number

" Settings: Tabs
set tabstop=4
set shiftwidth=0
set smarttab
set expandtab
set autoindent
set smartindent

" Settings: Invisible characters
:set listchars=tab:>·,space:·,trail:~
:set list
hi ExtraWhitespace guifg=#ff0000 ctermfg=9
match ExtraWhitespace /\s\+$/

" Settings: Ruler
set colorcolumn=120
hi ColorColumn guibg=#303845 ctermbg=236

" Settings: Other
autocmd FileType git setlocal foldmethod=syntax

" Utils: Ctags
set tags=./tags,tags;$HOME

" Utils: Grep
set grepprg=rg\ --vimgrep
command! -nargs=+ Rg call Rg(<f-args>)
command! -nargs=+ Rgl call Rgl(<f-args>)
command! -nargs=+ Rge call Rge(<f-args>)

" Utils: BufExplorer
let g:bufExplorerDisableDefaultKeyMapping = 1
let g:bufExplorerDefaultHelp = 0

" Utils: Lf
let g:floaterm_height = 0.7
let g:floaterm_width = 0.9
let g:lf_map_keys = 0
hi FloatermBorder guifg=#808080 ctermfg=244

" Utils: Airline
let g:airline_theme='regular'
let g:airline#extensions#wordcount#enabled=0
let g:airline#extensions#whitespace#checks=[]
let g:airline_inactive_collapse=1
let g:airline#extensions#searchcount#enabled = 0

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_splits=0
let g:airline#extensions#tabline#show_buffers=0
let g:airline#extensions#tabline#show_tab_count=0
let g:airline#extensions#tabline#tab_nr_type=1
let g:airline#extensions#tabline#left_sep=''
let g:airline#extensions#tabline#left_alt_sep=''
let g:airline#extensions#tabline#tabs_label=''
let g:airline#extensions#tabline#show_close_button=0
let g:airline#extensions#tabline#fnamemod=':t'

let g:airline_mode_map={
    \ '__'     : '-',
    \ 'c'      : 'COMMAND',
    \ 'i'      : 'INSERT',
    \ 'ic'     : 'INSERT',
    \ 'ix'     : 'INSERT',
    \ 'n'      : 'NORMAL',
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

let g:airline#extensions#default#section_truncate_width = {
    \ 'x': 90,
    \ 'y': 40,
    \ 'z': 75,
    \ }

function! AirlineInit()
    let g:airline_section_b=airline#section#create([''])
    let g:airline_section_x=airline#section#create(['%{GetTabsOrSpacesString()} | ', 'filetype', 'ffenc', ' '])
    let g:airline_section_y=airline#section#create([' %{line("$")} '])
    let g:airline_section_z=airline#section#create([' %{col(".")} '])

    hi airline_tab guifg=#a0a6b0 guibg=#343d4d cterm=none ctermfg=239 ctermbg=234
    hi airline_tabsel guifg=#a0a6b0 guibg=#232830 cterm=none ctermfg=110 ctermbg=234
    hi airline_tabmod guifg=#eceff4 guibg=#2d5e91 cterm=none ctermfg=110 ctermbg=234
    hi airline_tablabel guifg=#ced4de guibg=#343d4d cterm=none ctermfg=110 ctermbg=234
endfunction
autocmd User AirlineAfterInit call AirlineInit()

function! GetTabsOrSpacesString()
    return (&expandtab? 'space' : 'tab') . ", " . &tabstop
endfunction

" Utils: vim-cpp-modern
let g:cpp_member_highlight = 1
let g:cpp_no_function_highlight = 0
let g:cpp_attributes_highlight = 0

" Utils: Nerdcommenter
let g:NERDCustomDelimiters={
    \ 'c': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' }
    \ }

" Colors: main
hi VertSplit guifg=#343d4d guibg=#343d4d ctermfg=237 ctermbg=237
hi StatusLine guifg=#343d4d guibg=#343d4d ctermfg=237 ctermbg=237
hi StatusLineNC guifg=#343d4d guibg=#343d4d ctermfg=237 ctermbg=237
hi LineNr guifg=#4c566a ctermfg=245
hi CursorLineNr guifg=#d8dee9 guibg=#343d4d ctermbg=237 ctermfg=110
hi Normal guifg=#e5e9f0 guibg=#282e38 ctermbg=235 ctermfg=254
hi EndOfBuffer guifg=#282e38 ctermfg=235
hi DiffAdd guibg=#343d4d ctermbg=236
hi DiffDelete guifg=#232830 guibg=#232830 ctermbg=234 ctermfg=234
hi DiffChange guibg=#343d4d ctermbg=236
hi DiffText guibg=#235959 ctermbg=23
hi FoldColumn guifg=#15ebeb guibg=#39465c cterm=none ctermbg=239 ctermfg=14
hi Folded guifg=#15ebeb guibg=#435573 cterm=none ctermbg=239 ctermfg=14
hi Search guifg=#2e3440 guibg=#e0c896 ctermbg=11 ctermfg=232
hi IncSearch guifg=#bf616a guibg=#2e3440 ctermbg=11 ctermfg=232
hi Whitespace guifg=#434c5e ctermfg=238
hi Visual guibg=#434c5e
hi MatchParen none

" Colors: code
hi Comment guifg=#4aa881 ctermfg=71

hi PreProc guifg=#7c8aa3 ctermfg=247
hi Define guifg=#7c8aa3 ctermfg=247
hi Macro guifg=#7c8aa3 ctermfg=247
hi Include guifg=#7c8aa3 ctermfg=247

hi Type guifg=#5fafff ctermfg=75
hi StorageClass guifg=#5fafff ctermfg=75
hi Structure guifg=#5fafff ctermfg=75
hi Typedef guifg=#5fafff ctermfg=75

hi Constant guifg=#7c8aa3 ctermfg=247
hi String guifg=#cf8e6d ctermfg=173
hi Character guifg=#d08770 ctermfg=173
hi Number guifg=#87d7ff ctermfg=117
hi Boolean guifg=#87d7ff  ctermfg=117
hi Float guifg=#87d7ff ctermfg=117

hi Statement guifg=#5fafff ctermfg=75
hi Conditional guifg=#5fafff ctermfg=75
hi Repeat guifg=#5fafff ctermfg=75
hi Label guifg=#5fafff ctermfg=75
hi Operator guifg=#5fafff ctermfg=75
hi Keyword guifg=#5fafff ctermfg=75
hi Exception guifg=#5fafff ctermfg=75

hi Identifier guifg=#bd5b5b ctermfg=96
hi Function guifg=#ebcb8b ctermfg=222

hi Special guifg=#875fff ctermfg=99
hi SpecialChar guifg=#875fff ctermfg=99
hi Tag guifg=#875fff ctermfg=99
hi Delimiter guifg=#875fff ctermfg=99
hi SpecialComment guifg=#875fff ctermfg=99
hi Debug guifg=#875fff ctermfg=99

hi Error guifg=#e5e9f0 guibg=#994e4e
hi Todo guifg=#4aa881 ctermfg=71 guibg=#343d4d

" Colors: vimnote
hi VimnoteHeader guifg=#cf8e6d ctermfg=173
hi VimnoteSubheader guifg=#db79b9 ctermfg=74
hi VimnoteFocus guifg=#5fafff ctermfg=74
hi VimnoteDimmed guifg=#8697b5 ctermfg=117
hi VimnoteUnfocus guifg=#4f5a73 ctermfg=240
hi VimnoteHide guifg=#282e38 ctermfg=240

" Colors: 16
if has('termguicolors') && &termguicolors
    let g:terminal_color_0 = '#000000'
    let g:terminal_color_1 = '#c02727'
    let g:terminal_color_2 = '#1fb33d'
    let g:terminal_color_3 = '#c9c331'
    let g:terminal_color_4 = '#3579de'
    let g:terminal_color_5 = '#a031c9'
    let g:terminal_color_6 = '#2ebece'
    let g:terminal_color_7 = '#e8e8e8'
    let g:terminal_color_8 = '#727272'
    let g:terminal_color_9 = '#c71d1d'
    let g:terminal_color_10 = '#20cb31'
    let g:terminal_color_11 = '#eee615'
    let g:terminal_color_12 = '#2c7bf2'
    let g:terminal_color_13 = '#b838eb'
    let g:terminal_color_14 = '#2ccadb'
    let g:terminal_color_15 = '#e8e8e8'
endif

" Keymap: Split motion
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Keymap: Tag navigation
nnoremap tp :tp<CR>
nnoremap tn :tn<CR>

" Keymap: Replace
nnoremap <Leader>sc :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
nnoremap <Leader>sr :%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>
vnoremap <Leader>sc :<c-u>call SubstituteClean(GetVisualSelection())<CR>
vnoremap <Leader>sr :<c-u>call SubstituteReplace(GetVisualSelection())<CR>
vnoremap <Leader>sbc :<c-u>call SubstituteCleanInScope("bufdo", GetVisualSelection())<CR>
vnoremap <Leader>sbr :<c-u>call SubstituteReplaceInScope("bufdo", GetVisualSelection())<CR>
vnoremap <Leader>sac :<c-u>call SubstituteCleanInScope("argdo", GetVisualSelection())<CR>
vnoremap <Leader>sar :<c-u>call SubstituteReplaceInScope("argdo", GetVisualSelection())<CR>

" Keymap: File format
nnoremap <Leader>ru :execute 'e ++ff=unix'<CR>
nnoremap <Leader>rd :execute 'e ++ff=dos'<CR>
nnoremap <Leader>rm :execute 'e ++ff=mac'<CR>
nnoremap <Leader>rcu :execute 'setlocal ff=unix'<CR>
nnoremap <Leader>rcd :execute 'setlocal ff=dos'<CR>
nnoremap <Leader>rcm :execute 'setlocal ff=mac'<CR>
nnoremap <Leader>rx :%s/\r//g<CR>

" Keymap: Tabs and windows
nnoremap <F2> :tabnew<CR>
nnoremap <F3> :tabclose<CR>
nnoremap <F4> :q<CR>
nnoremap <C-w>n :vnew<CR>

" Keymap: Hexdump
nnoremap <Leader>xx :%!xxd -g 2 -c 8 <CR> \| :set ft=xxd<CR>
nnoremap <Leader>xr :%!xxd -g 2 -c 8 -r<CR> \| :filetype detect<CR>

" Keymap: Spaces
noremap <Leader>tr :retab!<CR>
noremap <Leader>tt :set noexpandtab<CR>
noremap <Leader>ts :set expandtab<CR>
noremap <Leader>t2 :set tabstop=2<CR>
noremap <Leader>t4 :set tabstop=4<CR>
noremap <Leader>t8 :set tabstop=8<CR>

" Keymap: Search
nnoremap <F5> :Rg 
nnoremap <F6> :Rgl 
nnoremap <F7> :Rge 
nnoremap <C-p> :FZF<CR>
nnoremap <Leader>f :Rg <C-r><C-w><CR>
vnoremap <Leader>f :<C-u>call Rg(GetVisualSelection())<CR>
vnoremap <Leader>l :<C-u>call SearchLocal(GetVisualSelection())<CR>

" Keymap: Git
nnoremap <Leader>gl :Gclog -30 -- 
nnoremap <Leader>gs :execute 'tabnew \| Git'<CR>
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

" Keymap: Lf
command! LfcdCurrentFile call OpenLfIn("%", 'cd')
nnoremap <C-n> :Lf<CR>
nnoremap <C-b> :LfWorkingDirectory<CR>
nnoremap <Leader>n :LfcdCurrentFile<CR>
nnoremap <Leader>b :Lfcd<CR>

" Keymap: Other
nnoremap <F8> :ToggleBufExplorer<CR>
nnoremap <F10> :pwd<CR>
nnoremap <Leader>u :mod<CR>
nnoremap <Leader>ac :call ClangTidy()<CR><CR>

" Functions
function! Rg(...)
    let searchString = join(a:000, ' ')
    let files = split(system(&grepprg . " -F -l '" . searchString . "'"), '\n')
    call setqflist([], ' ', {'lines': files, 'efm': '%f'})
    copen
    let @/ = EscapeVimRegexp(searchString)
endfunction

function! Rgl(...)
    let searchString = join(a:000, ' ')
    let lines = split(system(&grepprg . " -F '" . searchString . "'"), '\n')
    call setqflist([], ' ', {'lines': lines})
    copen
endfunction

function! Rge(...)
    let searchString = join(a:000, ' ')
    let lines = split(system(&grepprg . " '" . searchString . "'"), '\n')
    call setqflist([], ' ', {'lines': lines})
    copen
endfunction

function! SearchLocal(string)
    call feedkeys("/" . EscapeVimRegexp(a:string) . "\<CR>")
endfunction

function! EscapeVimRegexp(str)
  return escape(a:str, '^$.*~/\[]')
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
    call feedkeys(":%s/" . EscapeVimRegexp(a:string) . "//gc")
    call FeedLeftKey(3)
endfunction

function! SubstituteReplace(string)
    call feedkeys(":%s/" . EscapeVimRegexp(a:string) . "/" . a:string . "/gc")
    call FeedLeftKey(3)
endfunction

function! SubstituteCleanInScope(scope, string)
    call feedkeys(":" . a:scope . " %s/" . EscapeVimRegexp(a:string) . "//ge | update")
    call FeedLeftKey(12)
endfunction

function! SubstituteReplaceInScope(scope, string)
    call feedkeys(":" . a:scope . " %s/" . EscapeVimRegexp(a:string) . "/" . a:string . "/ge | update")
    call FeedLeftKey(12)
endfunction

function! FeedLeftKey(count)
    let c = 0
    while c < a:count
        call feedkeys("\<Left>")
        let c += 1
    endwhile
endfunction

function! ClangTidy()
    let l:filename = expand('%')
    if l:filename =~ '\.\(cpp\|c\)$'
        let l:cmd = 'clang-tidy ' . l:filename
        let l:output = split(system(l:cmd), '\n')
        if (match(l:output, 'Error while trying to load a compilation database') >= 0)
            echo 'No compilation database'
        else
            call filter(l:output, {idx, val -> match(val, '\d\+:\d\+: \w\+: ') >= 0})
            if (len(l:output) == 0)
                echo 'No issues'
                cclose
            else
                cexpr l:output
                copen
                let w:quickfix_title = l:cmd
            endif
        endif
    else
        echo "Only for C/C++ source file"
    endif
endfunction
