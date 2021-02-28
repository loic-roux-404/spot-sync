#!/bin/bash

PLAYLISTS_FILE=${PLAYLISTS_FILE:-playlists.txt}
DELETE=${DELETE:-0}

setup() {
    local min=${1:-0}
    local hour=${2:-3}
    local day=${3:-4}

    (crontab -l 2>/dev/null; \
    echo "${min} ${hour} ${day} * * ./new-dl.sh > ${PLAYLISTS_FILE}.log") | crontab -
}

delete() {
    [ $DELETE -eq 1 ] && \
    crontab -l | grep -v './new-dl.sh' | crontab - || return 0
}

delete && setup $@
