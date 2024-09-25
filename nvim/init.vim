" Plugins
call plug#begin('~/.local/share/nvim/site/plugged')
    Plug 'https://github.com/stepanovsn/vim-airline.git'
    Plug 'jlanzarotta/bufexplorer'
    Plug 'ptzz/lf.vim'
    Plug 'voldikss/vim-floaterm'
    Plug 'tpope/vim-fugitive'
    Plug 'bfrg/vim-cpp-modern'
    Plug 'scrooloose/nerdcommenter'
    Plug 'junegunn/fzf'
call plug#end()

" Settings: Define the color scheme
let color_scheme = $REG_CONSOLE_COLOR_SCHEME
if (len(color_scheme) == 0)
    let color_scheme = "pure"
endif

" Import colors
exec "source " . stdpath('config') . "/color_schemes/" . color_scheme . ".vim"

" Settings: Main
if (match(system("tput colors"), "8") == -1)
    set termguicolors
endif

syntax enable
set ffs=unix,dos,mac
set timeoutlen=3000
set ignorecase
set smartcase
set guicursor=a:block-blinkon1
set guicursor+=i:ver100-blinkon1
set mouse=
set concealcursor=n

" Settings: Diff
set diffopt=filler,context:18
set diffopt+=vertical

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

" Settings: Other
autocmd FileType git setlocal foldmethod=syntax
autocmd BufEnter * :syntax sync minlines=50
autocmd VimEnter * call SetCodeViewMode()

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
hi FloatermBorder guifg=#808080 ctermfg=8

" Utils: Airline
let g:airline_theme=color_scheme
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
let g:airline#extensions#tabline#fnamemod=':t:s?^$?[No filename]?'
let g:airline#extensions#tabline#fnamecollapse=1

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
    \ 'w': 60,
    \ 'x': 90,
    \ 'y': 40,
    \ 'z': 75,
    \ }

let g:russianMode = 0

function! AirlineInit()
    call airline#parts#define_function('rus', 'GetRussianModeString')

    let g:airline_section_b=airline#section#create([''])
    let g:airline_section_w=airline#section#create(['rus'])
    let g:airline_section_x=airline#section#create([' %{GetTabsOrSpacesString()} | ', 'filetype', 'ffenc', ' '])
    let g:airline_section_y=airline#section#create([' %{line("$")} '])
    let g:airline_section_z=airline#section#create([' %{col(".")} '])

    call g:AirlineInitColors()
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

" Keymap: Split motion
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Keymap: Motion on wrapped lines
noremap <M-j> gj
noremap <M-k> gk

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
nnoremap <Leader>gs :<C-u>call OpenGitStatus()<CR>
nnoremap <Leader>gc :Git difftool --name-only 
nnoremap <Leader>gd :Gvdiff 

" Keymap: Marks
nnoremap <Leader>ml :marks ABCDEFGHIJKLMNOPQRSTUVWXYZ<CR>
nnoremap <Leader>mc :delm A-Z<CR>

" Keymap: Toggling
nnoremap <silent><expr> <F9> (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
set pastetoggle=<Leader>p

" Keymap: Lf
command! LfcdCurrentFile call OpenLfIn("%", 'cd')
nnoremap <C-n> :Lf<CR>
nnoremap <C-b> :LfWorkingDirectory<CR>
nnoremap <Leader>n :LfcdCurrentFile<CR>
nnoremap <Leader>b :Lfcd<CR>

" Keymap: View mode
nnoremap <Leader>vc :<C-u>call SetCodeViewMode()<CR>
nnoremap <Leader>vr :<C-u>call SetReaderViewMode()<CR>
nnoremap <Leader>vm :<C-u>call SetMinimalViewMode()<CR>

" Keymap: Vimnote keynotes
nnoremap <Leader>oh O=====================================================
            \  =====================================================<ESC>bhi
nnoremap <Leader>ot o━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━<CR><ESC>0i
            \    │    │    │<CR><ESC>0i
            \━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━<CR><ESC>0i
            \    │    │    │<CR><ESC>0i
            \───────────────────────────────────────────<ESC>kkk0la
nnoremap <Leader>of a«»<ESC>i
vnoremap <Leader>of c«<C-R>"»<ESC>
nnoremap <Leader>oF a⟪⟫<ESC>i
vnoremap <Leader>oF c⟪<C-R>"⟫<ESC>
nnoremap <Leader>od a‹›<ESC>i
vnoremap <Leader>od c‹<C-R>"›<ESC>
nnoremap <Leader>oD a⟨⟩<ESC>i
vnoremap <Leader>oD c⟨<C-R>"⟩<ESC>
nnoremap <Leader>os o<ESC>o<ESC>O─│┌┐└┘├┤┬┴┼<Enter>━┃┏┓┗┛┣┫┳┻╋<Enter>═║╢╟╤╧<Enter>╴╵╶╷╸╹╺╻┆<Enter>● ◆ ▬ ◄ ► ▲ ▼ 🢐 🢒 🢑 🢓<Enter>╱╲<Enter>▒🮙<ESC>4k0

" Keymap: Rnote keynotes
nnoremap <Leader>isb a\b{}<ESC>i
vnoremap <Leader>isb c\b{<C-R>"}<ESC>
nnoremap <Leader>isi a\i{}<ESC>i
vnoremap <Leader>isi c\i{<C-R>"}<ESC>
nnoremap <Leader>ism a\m{}<ESC>i
vnoremap <Leader>ism c\m{<C-R>"}<ESC>
nnoremap <Leader>isn a\n<ESC>i

nnoremap <Leader>ihc O\chapter{}<ESC>i
nnoremap <Leader>ihs O\section{}<ESC>i
nnoremap <Leader>ihu O\subsection[clear]{}<ESC>i

nnoremap <Leader>it o\text<ESC>
nnoremap <Leader>ie o\thead<Enter>\tbody[headcol="1" full]<ESC>O
nnoremap <Leader>ia o\annotation[width="80"]<ESC>o
nnoremap <Leader>ii o\image[title="Title" width="30"]{}<ESC>i
nnoremap <Leader>ib o\imageblock[groupby="1" width="100"]<ESC>o\item[title="Title"]{}<ESC>i
nnoremap <Leader>il o\listing[syntax="cpp"]<ESC>o
nnoremap <Leader>in o\list<ESC>j
nnoremap <Leader>im o\math{}<ESC>i

" Keymap: insert special chars
nnoremap <Leader>cw i <ESC>

" Keymap: Other
nnoremap <F8> :ToggleBufExplorer<CR>
noremap <F10> :call ToggleRussianMode()<CR>
inoremap <F10> <C-o>:call ToggleRussianMode()<CR>
nnoremap <Leader>u :mod<CR>
nnoremap <Leader>ac :call ClangTidy()<CR><CR>

" Functions
function! SetCodeViewMode()
    set numberwidth=6
    set relativenumber
    set number
    set cursorline
    set cursorlineopt=number
    set list
    set cmdheight=1
    set laststatus=2
    set showtabline=2
    set guicursor-=a:Cursor
    set conceallevel=0
    set colorcolumn=120,160
endfunction

function! SetReaderViewMode()
    set numberwidth=12
    set norelativenumber
    set number
    set nocursorline
    set nolist
    set cmdheight=0
    set laststatus=0
    set showtabline=0
    set guicursor+=a:Cursor
    set conceallevel=2
    set colorcolumn=
endfunction

function! SetMinimalViewMode()
    set numberwidth=6
    set norelativenumber
    set nonumber
    set nocursorline
    set nolist
    set cmdheight=1
    set laststatus=2
    set showtabline=2
    set guicursor-=a:Cursor
    set conceallevel=0
    set colorcolumn=120,160
endfunction

function! OpenQflist()
    copen
    let length = len(getqflist()) + 1
    if (length > 15)
        let length = 15
    elseif (length < 3)
        let length = 3
    endif
    call feedkeys(":resize " . length . "\<CR>")
endfunction

function! Rg(...)
    let searchString = join(a:000, ' ')
    let files = split(system(&grepprg . " -F -l '" . searchString . "'"), '\n')
    call setqflist([], ' ', {'lines': files, 'efm': '%f'})
    call OpenQflist()
    let @/ = EscapeVimRegexp(searchString)
endfunction

function! Rgl(...)
    let searchString = join(a:000, ' ')
    let lines = split(system(&grepprg . " -F '" . searchString . "'"), '\n')
    call setqflist([], ' ', {'lines': lines})
    call OpenQflist()
endfunction

function! Rge(...)
    let searchString = join(a:000, ' ')
    let lines = split(system(&grepprg . " '" . searchString . "'"), '\n')
    call setqflist([], ' ', {'lines': lines})
    call OpenQflist()
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

function! GetRussianModeString()
    if g:russianMode
        return ' RU '
    else
        return ''
    endif
endfunction

function! ToggleRussianMode(...)
    if g:russianMode
        iunmap @
        iunmap #
        iunmap $
        iunmap ^
        iunmap &
        iunmap q
        iunmap w
        iunmap e
        iunmap r
        iunmap t
        iunmap y
        iunmap u
        iunmap i
        iunmap o
        iunmap p
        iunmap [
        iunmap ]
        iunmap a
        iunmap s
        iunmap d
        iunmap f
        iunmap g
        iunmap h
        iunmap j
        iunmap k
        iunmap l
        iunmap ;
        iunmap '
        iunmap z
        iunmap x
        iunmap c
        iunmap v
        iunmap b
        iunmap n
        iunmap m
        iunmap ,
        iunmap .
        iunmap /
        iunmap Q
        iunmap W
        iunmap E
        iunmap R
        iunmap T
        iunmap Y
        iunmap U
        iunmap I
        iunmap O
        iunmap P
        iunmap {
        iunmap }
        iunmap A
        iunmap S
        iunmap D
        iunmap F
        iunmap G
        iunmap H
        iunmap J
        iunmap K
        iunmap L
        iunmap :
        iunmap "
        iunmap Z
        iunmap X
        iunmap C
        iunmap V
        iunmap B
        iunmap N
        iunmap M
        iunmap <
        iunmap >
        iunmap ?
        let g:russianMode = 0
    else
        inoremap @ "
        inoremap # №
        inoremap $ ;
        inoremap ^ :
        inoremap & ?
        inoremap q й
        inoremap w ц
        inoremap e у
        inoremap r к
        inoremap t е
        inoremap y н
        inoremap u г
        inoremap i ш
        inoremap o щ
        inoremap p з
        inoremap [ х
        inoremap ] ъ
        inoremap a ф
        inoremap s ы
        inoremap d в
        inoremap f а
        inoremap g п
        inoremap h р
        inoremap j о
        inoremap k л
        inoremap l д
        inoremap ; ж
        inoremap ' э
        inoremap z я
        inoremap x ч
        inoremap c с
        inoremap v м
        inoremap b и
        inoremap n т
        inoremap m ь
        inoremap , б
        inoremap . ю
        inoremap / .
        inoremap Q Й
        inoremap W Ц
        inoremap E У
        inoremap R К
        inoremap T Е
        inoremap Y Н
        inoremap U Г
        inoremap I Ш
        inoremap O Щ
        inoremap P З
        inoremap { Х
        inoremap } Ъ
        inoremap A Ф
        inoremap S Ы
        inoremap D В
        inoremap F А
        inoremap G П
        inoremap H Р
        inoremap J О
        inoremap K Л
        inoremap L Д
        inoremap : Ж
        inoremap " Э
        inoremap Z Я
        inoremap X Ч
        inoremap C С
        inoremap V М
        inoremap B И
        inoremap N Т
        inoremap M Ь
        inoremap < Б
        inoremap > Ю
        inoremap ? ,
        let g:russianMode = 1
    endif
endfunction

function! OpenGitStatus(...)
    call system('git rev-parse --is-inside-work-tree')
    if v:shell_error != 0
        echo "Not inside work tree"
        return
    endif

    tab G
endfunction
