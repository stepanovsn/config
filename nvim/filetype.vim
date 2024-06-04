if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    au! BufRead,BufNewFile *.vimnote  setfiletype vimnote
    au! BufRead,BufNewFile *.rnote  setfiletype rnote
    au! BufRead,BufNewFile *.psl  setfiletype kaspersky-psl
    au! BufRead,BufNewFile *.log  call SetCorrectLogType()
augroup END

function! SetCorrectLogType(...)
    if search("kasperskyos", "n", 0, 10) != 0
        setfiletype kaspersky-log
    endif
endfunction
