syntax match BnoteHeader /=H= .*$/ contains=BnoteTag keepend
syntax match BnoteSubheader /=h= .*$/ contains=BnoteTag keepend
syntax region BnoteCode start=/=[Cc]=\(\|$\)/ end=/=[Nn]=\(\|$\)/ contains=BnoteTag keepend

syntax match BnoteTag /=[HhCcNn]=\(\|$\)/ contained
