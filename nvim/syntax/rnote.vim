" Highlight some of not escaped backslash symbols
syntax match RnoteAlert /\(\\\)\@<!\(\\\{1\}\|\\\{3\}\|\\\{5\}\|\\\{7\}\|\\\{9\}\|\\\{11\}\|\\\{11\}\|\\\{13\}\|\\\{15\}\)[^\\]\+/

" Blocks with data and parameters
syntax region RnoteChapter matchgroup=RnoteService1 start=|\(\\\)\@<!\\chapter\(\[.\{-}\(\(\\\)\@<!\]\)\)\?{| end=|\(\\\)\@<!}| concealends
syntax region RnoteSection matchgroup=RnoteService1 start=|\(\\\)\@<!\\section\(\[.\{-}\(\(\\\)\@<!\]\)\)\?{| end=|\(\\\)\@<!}| concealends
syntax region RnoteSubsection matchgroup=RnoteService1 start=|\(\\\)\@<!\\subsection\(\[.\{-}\(\(\\\)\@<!\]\)\)\?{| end=|\(\\\)\@<!}| concealends

syntax region RnoteDocument matchgroup=RnoteService1 start=|\(\\\)\@<!\\document\(\[.\{-}\(\(\\\)\@<!\]\)\)\?{| end=|\(\\\)\@<!}| concealends
syntax region RnoteSpecial matchgroup=RnoteService1 start=|\(\\\)\@<!\\image\(\[.\{-}\(\(\\\)\@<!\]\)\)\?{| end=|\(\\\)\@<!}| concealends
syntax region RnoteSpecial matchgroup=RnoteService1 start=|\(\\\)\@<!\\item\(\[.\{-}\(\(\\\)\@<!\]\)\)\?{| end=|\(\\\)\@<!}| concealends

syntax region RnoteStyled matchgroup=RnoteService1 start=|\(\\\)\@<!\\l\(\[.\{-}\(\(\\\)\@<!\]\)\)\?{| end=|\(\\\)\@<!}| concealends
syntax region RnoteStyled matchgroup=RnoteService1 start=|\(\\\)\@<!\\r\(\[.\{-}\(\(\\\)\@<!\]\)\)\?{| end=|\(\\\)\@<!}| concealends

" Blocks with data and no parameters
syntax region RnoteStyled matchgroup=RnoteService1 start=|\(\\\)\@<!\\b{| end=|\(\\\)\@<!}| concealends
syntax region RnoteStyled matchgroup=RnoteService1 start=|\(\\\)\@<!\\i{| end=|\(\\\)\@<!}| concealends
syntax region RnoteStyled matchgroup=RnoteService1 start=|\(\\\)\@<!\\m{| end=|\(\\\)\@<!}| concealends
syntax region RnoteStyled matchgroup=RnoteService1 start=|\(\\\)\@<!\\t{| end=|\(\\\)\@<!}| concealends
syntax region RnoteStyled matchgroup=RnoteService1 start=|\(\\\)\@<!\\e{| end=|\(\\\)\@<!}| concealends

syntax region RnoteSpecial matchgroup=RnoteService1 start=|\(\\\)\@<!\\math{| end=|\(\\\)\@<!}| concealends

" Blocks with no data and parameters
syntax match RnoteService1 /\(\\\)\@<!\\annotation\(\[.\{-}\(\(\\\)\@<!\]\)\)\?\(\($\|\s\)\)\@=/ conceal contains=RnoteService2
syntax match RnoteService1 /\(\\\)\@<!\\listing\(\[.\{-}\(\(\\\)\@<!\]\)\)\?\(\($\|\s\)\)\@=/ conceal contains=RnoteService2
syntax match RnoteService1 /\(\\\)\@<!\\imageblock\(\[.\{-}\(\(\\\)\@<!\]\)\)\?\(\($\|\s\)\)\@=/ conceal contains=RnoteService2
syntax match RnoteService1 /\(\\\)\@<!\\thead\(\[.\{-}\(\(\\\)\@<!\]\)\)\?\(\($\|\s\)\)\@=/ conceal contains=RnoteService2
syntax match RnoteService1 /\(\\\)\@<!\\tbody\(\[.\{-}\(\(\\\)\@<!\]\)\)\?\(\($\|\s\)\)\@=/ conceal contains=RnoteService2
syntax match RnoteServiceCell /\(\\\)\@<!\\c\(\[.\{-}\(\(\\\)\@<!\]\)\)\?\(\($\|\s\)\)\@=/ conceal cchar=┃

syntax match RnoteService2 /\(\\\)\@<!\\annotation/ conceal contained contains=RnoteService3 " used for better view mode
syntax match RnoteService2 /\(\\\)\@<!\\listing/ conceal contained contains=RnoteService3 " used for better view mode
syntax match RnoteService2 /\(\\\)\@<!\\imageblock/ conceal contained contains=RnoteService3 " used for better view mode
syntax match RnoteService2 /\(\\\)\@<!\\thead/ conceal contained contains=RnoteService3 " used for better view mode
syntax match RnoteService2 /\(\\\)\@<!\\tbody/ conceal contained contains=RnoteService3 " used for better view mode

" Blocks with no data and no parameters
syntax match RnoteService1 /\(\\\)\@<!\\n\(\($\|\s\)\)\@=/ conceal cchar=▼ " line break
syntax match RnoteService1 /\(\\\)\@<!\\end\(\($\|\s\)\)\@=/ conceal cchar=┃ " end of table row or annotation line
syntax match Normal /\(\\\)\@<!\\-\(\($\|\s\)\)\@=/ " escaped hyphen

syntax match RnoteService1 /\(\\\)\@<!\\text\(\($\|\s\)\)\@=/ conceal contains=RnoteService3
syntax match RnoteService1 /\(\\\)\@<!\\s\(\($\|\s\)\)\@=/ conceal cchar=┃

" Special highlight groups
syntax match RnoteService3 /\\l/ conceal contained cchar=L
syntax match RnoteService3 /\\t/ conceal contained cchar=T
syntax match RnoteService3 /\\w/ conceal contained cchar=W
syntax match RnoteService3 /a/ conceal contained cchar=A
syntax match RnoteService3 /b/ conceal contained cchar=B
syntax match RnoteService3 /d/ conceal contained cchar=D
syntax match RnoteService3 /c/ conceal contained cchar=C
syntax match RnoteService3 /e/ conceal contained cchar=E
syntax match RnoteService3 /g/ conceal contained cchar=G
syntax match RnoteService3 /h/ conceal contained cchar=H
syntax match RnoteService3 /i/ conceal contained cchar=I
syntax match RnoteService3 /m/ conceal contained cchar=M
syntax match RnoteService3 /n/ conceal contained cchar=N
syntax match RnoteService3 /k/ conceal contained cchar=K
syntax match RnoteService3 /l/ conceal contained cchar=L
syntax match RnoteService3 /o/ conceal contained cchar=O
syntax match RnoteService3 /s/ conceal contained cchar=S
syntax match RnoteService3 /t/ conceal contained cchar=T
syntax match RnoteService3 /u/ conceal contained cchar=U
syntax match RnoteService3 /x/ conceal contained cchar=X
syntax match RnoteService3 /y/ conceal contained cchar=Y
