syntax match BnoteHeader /=H=.*$/ contains=BnoteTag keepend
syntax match BnoteSubheader /=h=.*$/ contains=BnoteTag keepend
syntax region BnoteCode start=/=c=/ end=/=n=/ contains=BnoteTag keepend

syntax match BnoteTag /=H=/ contained
syntax match BnoteTag /=h=/ contained
syntax match BnoteTag /=c=/ contained
syntax match BnoteTag /=n=/ contained
