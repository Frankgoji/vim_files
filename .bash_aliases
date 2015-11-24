#! /bin/bash

alias cdhw="cd ~/Documents/HW/fa15"

function sync_backup {
    dropbox start
    zip -r dejadup.zip ~/deja-dup
    mv dejadup.zip ~/Dropbox/backup
    dropbox stop
}
