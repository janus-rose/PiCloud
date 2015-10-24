#!/bin/bash
## Add key and repo
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo deb http://apt.syncthing.net/ syncthing release | sudo tee /etc/apt/sources.list.d/syncthing-release.list
## Install and start Syncthing
apt-get update
apt-get install syncthing
syncthing &

## To do: add something here to auto change the config file for remote access

## To do: add something here to auto generate a startup script


