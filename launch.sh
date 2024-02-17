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
  # TODO: Automatically get FileId and FileName to make it generic
  curl -Lo "Server-Files-$PROJECT_VERSION.zip" "https://edge.forgecdn.net/files/5113/792/Craft%20to%20Exile%202%20SERVER-$PROJECT_VERSION.zip" || exit 9
  unzip -u -o "Server-Files-$PROJECT_VERSION.zip" -d /data
  FORGE_INSTALLER=$(find . -name "forge-*-installer.jar")
  java -jar "${FORGE_INSTALLER}" --installServer
fi

sed -i 's/server-port.*/server-port=25565/g' server.properties
chmod 755 run.sh

./run.sh