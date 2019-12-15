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


project="bryantfhayes/dunkel"

# make sure ENV is setup and ./butler is installed
prepare_butler

prepare_and_push $project "dunkel-windows.zip" "windows" 
prepare_and_push $project "dunkel-mac.zip" "mac" 
prepare_and_push $project "dunkel-linux.zip" "linux" 
prepare_and_push $project "dunkel-html5.zip" "html5" 

echo "Done."
exit 0
