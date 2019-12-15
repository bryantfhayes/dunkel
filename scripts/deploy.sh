#!/bin/bash

set -e
set -o pipefail

if [[ -z "${BUTLER_API_KEY}" ]]; then
  echo "Unable to deploy! No BUTLER_API_KEY environment variable specified!"
  exit 1
fi

prepare_butler() {
    echo "Preparing butler..."
    download_if_not_exist http://dl.itch.ovh/butler/linux-amd64/head/butler butler
    chmod +x butler
}

prepare_and_push() {
    echo "./butler push $2 $1:$3 --userversion $TRAVIS_TAG"
    ./butler push $2 $1:$3 --userversion $TRAVIS_TAG
}

download_if_not_exist() {
    if [ ! -f $2 ]; then
        curl -L -O $1 > $2
    fi
}

project="slagathor-ld/$GAME_NAME"

# make sure ENV is setup and ./butler is installed
prepare_butler

prepare_and_push $project "$GAME_NAME-windows-$TRAVIS_TAG.zip" "windows" 
prepare_and_push $project "$GAME_NAME-mac-$TRAVIS_TAG.zip" "mac" 
prepare_and_push $project "$GAME_NAME-linux-$TRAVIS_TAG.zip" "linux" 
prepare_and_push $project "$GAME_NAME-html5-$TRAVIS_TAG.zip" "html5" 

echo "Done."
exit 0
