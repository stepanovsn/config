#!/bin/sh

case "$1" in
    *.tar) tar -tvf "$1";;
    *.tar.gz) tar -tvzf "$1";;
    *.zip) unzip -l "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1";;
    #*.pdf) pdftotext "$1" -;;
    #*.png|*.jpg|*.jpeg|*.mkv|*.mp4|*.m4v) mediainfo "$1";;
    #*.md) glow -s dark "$1";;
    #*.html|*.xml) w3m -dump "$1";;
    *.pem) openssl x509 -in "$1" -noout -text;;
    *) highlight -O ansi "$1";;
esac
