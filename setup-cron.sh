#!/bin/bash

PLAYLISTS_FILE=${PLAYLISTS_FILE:-playlists.txt}
DELETE=${DELETE:-1}
LIST=${LIST:-0}

setup() {
    local min=${1:-*}
    local hour=${2:-*}
    local day=${3:-4}

    (crontab -l 2>/dev/null; \
    echo "${min} ${hour} ${day} * * $(pwd)/new-dl.sh > ${PLAYLISTS_FILE}.log") | crontab -
}

delete() {
    [ $DELETE -eq 1 ] && \
    crontab -l | grep -v "$(pwd)/new-dl.sh" | head -1 | crontab - || return 0
}

list() {
    [ $LIST -eq 1 ] && crontab -l
}

list
delete && \
setup $@
