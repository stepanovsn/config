#!/bin/sh

case "$f" in
    *.tar) tar -tvf "$1";;
    *.tar.gz) tar -tvzf "$1";;
    *.zip) unzip -l "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1" || true;;
    #*.pdf) pdftotext "$1" -;;
    #*.png|*.jpg|*.jpeg|*.mkv|*.mp4|*.m4v) mediainfo "$1";;
    #*.md) glow -s dark "$1";;
    #*.html|*.xml) w3m -dump "$1";;
    *) highlight -O ansi "$1";;
esac
