#!/bin/bash

get_latest_release() {
  latestRelease=$(curl --silent "https://api.github.com/repos/$1/releases/latest" | 
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/')                                    # Pluck JSON value
echo "$latestRelease"
IFS='/'
read -ra releaseComponents <<< "$1"
curl -LO "https://github.com/$1/releases/download/$latestRelease/${releaseComponents[1]}.zip"
unzip -o "${releaseComponents[1]}.zip" && rm "${releaseComponents[1]}.zip"
}

cd styles || exit
get_latest_release "errata-ai/Microsoft"
get_latest_release "testthedocs/Openly"