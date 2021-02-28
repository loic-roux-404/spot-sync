#!/bin/bash -e

URL_BASE=https://open.spotify.com/playlist
export SPOTIPY_CLIENT_ID=d73c14999fd444fa94679c70e2be20ee
export SPOTIPY_CLIENT_SECRET=e753d776f9144c8faf0ef40cde12384c
DL_DIR=${HOME}/Music/spotify

cmd_exist() {
    command -v ${1} &>/dev/null;
}

requirements() {
    if ! cmd_exist spotify_dl; then
        pip install -r requirements.txt
    fi
    mkdir -p ${DL_DIR}
}

dl() {
    spotify_dl -l ${URL_BASE}/${1} -o ${DL_DIR}
}

get_playlists() {
    while IFS= read -r line; do dl ${line}; done < $@
}

get_playlists "$@"