#!/bin/sh

if file "${1}" | rg -e "ELF.*executable" &> /dev/null; then
    readelf -h ${1}
    return 0
fi

case "${1,,}" in
    *.7z) 7z l "$1";;
    *.deb) dpkg-deb -I "$1";;
    *.doc|*.docx) docx2txt "$1" -;;
    *.html|*.xml) w3m -dump "$1";;
    *.mp3) mp3info -x "$1";;
    *.pem|*.crt|*.cer) openssl x509 -in "$1" -noout -text -certopt no_pubkey,no_sigdump;;
    *.pdf) pdftotext "$1" -;;
    *.png|*.mov|*.jpg|*.gif|*.jpeg|*.mkv|*.mp4|*.m4v) mediainfo "$1";;
    *.rar) unrar l "$1";;
    *.tar) tar -tvf "$1";;
    *.tar.bz) tar -tvjf "$1";;
    *.tar.gz) tar -tvzf "$1";;
    *.tar.xz) tar -tvJf "$1";;
    *.tgz) tar -tvzf "$1";;
    *.xls|*.xlsx) in2csv "$1";;
    *.zip) unzip -l "$1";;
    *) highlight -O ansi --force "$1";;
esac
