#!/bin/sh

case "$1" in
    *.tar) tar -tvf "$1";;
    *.tar.gz) tar -tvzf "$1";;
    *.tgz) tar -tvzf "$1";;
    *.tar.bz) tar -tvjf "$1";;
    *.tar.xz) tar -tvJf "$1";;
    *.zip) unzip -l "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1";;
    *.pdf) pdftotext "$1" -;;
    *.png|*.jpg|*.jpeg|*.mkv|*.mp4|*.m4v) mediainfo "$1";;
    *.html|*.xml) w3m -dump "$1";;
    *.pem|*.crt|*.cer) openssl x509 -in "$1" -noout -text -certopt no_pubkey,no_sigdump;;
    *.deb) dpkg-deb -I "$1";;
    *) highlight -O ansi --force "$1";;
esac
