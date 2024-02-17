#!/bin/bash

set -x

cd /data



if ! [[ "$EULA" = "false" ]]; then
  echo "eula=true" > eula.txt
else
  echo "You must accept the EULA to install"
  exit 99
fi

if ! [[ -f "Server-Files-$PROJECT_VERSION.zip" ]]; then
  rm -fr rm -fr config defaultconfigs kubejs scripts mods packmenu Simple.zip forge*
  fileName=$(jq -r '.fileName' server-file-info.json)
  serverPackFileId=$(jq -r '.serverPackFileId' server-file-info.json)
  curl -Lo "Server-Files-$PROJECT_VERSION.zip" "https://edge.forgecdn.net/files/${serverPackFileId:0:4}/${serverPackFileId:4}/${fileName// /%20}" || exit 9
  unzip -u -o "Server-Files-$PROJECT_VERSION.zip" -d /data
  FORGE_INSTALLER=$(find . -name "forge-*-installer.jar")
  java -jar "${FORGE_INSTALLER}" --installServer
fi

chmod 755 run.sh

./run.sh