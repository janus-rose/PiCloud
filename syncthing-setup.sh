#!/bin/bash
## Add key and repo
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo deb http://apt.syncthing.net/ syncthing release | sudo tee /etc/apt/sources.list.d/syncthing-release.list
## Install and start Syncthing
apt-get update
apt-get install syncthing xmlstarlet
syncthing -generate=\$HOME/.config/syncthing/
## Change config file for remote access + TLS
xmlstarlet ed -L -u "/configuration/gui/@tls" -v true $HOME/.config/syncthing/config.xml
xmlstarlet ed -L -u "/configuration/gui/address" -v 0.0.0.0:8384 $HOME/.config/syncthing/config.xml
## To do: add something here to auto generate a startup script
syncthing

