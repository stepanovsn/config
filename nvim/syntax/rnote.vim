" Highlight some of not escaped backslash symbols
syntax match RnoteAlert /\(\\\)\@<!\(\\\{1\}\|\\\{3\}\|\\\{5\}\|\\\{7\}\|\\\{9\}\|\\\{11\}\|\\\{11\}\|\\\{13\}\|\\\{15\}\)[^\\]\+/

" Blocks with no data
syntax match RnoteService1 /\(\\\)\@<!\\n\(\($\|\s\)\)\@=/ conceal cchar=▼ " line break

" Blocks with enclosed data
syntax region RnoteChapter matchgroup=RnoteService1 start=|\(\\\)\@<!\\chapter{| end=|\(\\\)\@<!}| concealends
syntax region RnoteSection matchgroup=RnoteService1 start=|\(\\\)\@<!\\section{| end=|\(\\\)\@<!}| concealends
syntax region RnoteSubsection matchgroup=RnoteService1 start=|\(\\\)\@<!\\subsection\(\[[^\[\]]*\]\)\?{| end=|\(\\\)\@<!}| concealends

syntax region RnoteSpecial matchgroup=RnoteService1 start=|\(\\\)\@<!\\math{| end=|\(\\\)\@<!}| concealends
syntax region RnoteSpecial matchgroup=RnoteService1 start=|\(\\\)\@<!\\image\(\[[^\[\]]*\]\)\?{| end=|\(\\\)\@<!}| concealends
syntax region RnoteSpecial matchgroup=RnoteService1 start=|\(\\\)\@<!\\item\(\[[^\[\]]*\]\)\?{| end=|\(\\\)\@<!}| concealends

syntax region RnoteStyled matchgroup=RnoteService1 start=|\(\\\)\@<!\\b{| end=|\(\\\)\@<!}| concealends
syntax region RnoteStyled matchgroup=RnoteService1 start=|\(\\\)\@<!\\i{| end=|\(\\\)\@<!}| concealends
syntax region RnoteStyled matchgroup=RnoteService1 start=|\(\\\)\@<!\\m{| end=|\(\\\)\@<!}| concealends

" Blocks with open data and no parameters
syntax match RnoteService1 /\(\\\)\@<!\\text\(\($\|\s\)\)\@=/ conceal contains=RnoteService3
syntax match RnoteService1 /\(\\\)\@<!\\list\(\($\|\s\)\)\@=/ conceal contains=RnoteService3
syntax match RnoteService1 /\(\\\)\@<!\\s\(\($\|\s\)\)\@=/ conceal cchar=┃

" Blocks with open data and parameters
syntax match RnoteService1 /\(\\\)\@<!\\annotation\(\[[^\[\]]*\]\)\?\(\($\|\s\)\)\@=/ conceal contains=RnoteService2
syntax match RnoteService1 /\(\\\)\@<!\\listing\(\[[^\[\]]*\]\)\?\(\($\|\s\)\)\@=/ conceal contains=RnoteService2
syntax match RnoteService1 /\(\\\)\@<!\\imageblock\(\[[^\[\]]*\]\)\?\(\($\|\s\)\)\@=/ conceal contains=RnoteService2
syntax match RnoteService1 /\(\\\)\@<!\\thead\(\[[^\[\]]*\]\)\?\(\($\|\s\)\)\@=/ conceal contains=RnoteService2
syntax match RnoteService1 /\(\\\)\@<!\\tbody\(\[[^\[\]]*\]\)\?\(\($\|\s\)\)\@=/ conceal contains=RnoteService2
syntax match RnoteService1 /\(\\\)\@<!\\layout\(\[[^\[\]]*\]\)\?\(\($\|\s\)\)\@=/ conceal contains=RnoteService2
syntax match RnoteServiceCell /\(\\\)\@<!\\c\(\[[^\[\]]*\]\)\?\(\($\|\s\)\)\@=/ conceal cchar=┃

syntax match RnoteService2 /\(\\\)\@<!\\annotation/ conceal contained contains=RnoteService3
syntax match RnoteService2 /\(\\\)\@<!\\listing/ conceal contained contains=RnoteService3
syntax match RnoteService2 /\(\\\)\@<!\\imageblock/ conceal contained contains=RnoteService3
syntax match RnoteService2 /\(\\\)\@<!\\thead/ conceal contained contains=RnoteService3
syntax match RnoteService2 /\(\\\)\@<!\\tbody/ conceal contained contains=RnoteService3
syntax match RnoteService2 /\(\\\)\@<!\\layout/ conceal contained contains=RnoteService3

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
