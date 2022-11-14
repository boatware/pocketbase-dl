#!/bin/bash

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

version=$(get_latest_release "pocketbase/pocketbase")
# Remove the 'v' from the version string if present
version=${version#v}

system=$(uname -s | tr '[:upper:]' '[:lower:]')

url="https://github.com/pocketbase/pocketbase/releases/download/v0.7.10/pocketbase_$(echo $version)_$(echo $system)_amd64.zip"

echo "Downloading PocketBase $version for $system from $url"

wget -O pocketbase.zip $url
unzip pocketbase.zip