if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    au! BufRead,BufNewFile *.vimnote  setfiletype vimnote
    au! BufRead,BufNewFile *.psl  setfiletype kaspersky-psl
augroup END
