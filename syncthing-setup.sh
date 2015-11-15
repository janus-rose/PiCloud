#!/bin/bash
## Add key and repo
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo deb http://apt.syncthing.net/ syncthing release | sudo tee /etc/apt/sources.list.d/syncthing-release.list
## Install Syncthing
sudo apt-get update
sudo apt-get install syncthing xmlstarlet
syncthing -generate="$HOME/.config/syncthing/"
## Add Syncthing startup script
sudo wget -O /etc/init.d/syncthing https://raw.githubusercontent.com/lawfulintercept/PiCloud/master/syncthing-daemon
sudo chmod +x /etc/init.d/syncthing
sudo update-rc.d syncthing defaults
## Configure for remote GUI access + TLS
xmlstarlet ed -L -u "/configuration/gui/@tls" -v true ~/.config/syncthing/config.xml
xmlstarlet ed -L -u "/configuration/gui/address" -v 0.0.0.0:8384 ~/.config/syncthing/config.xml
## Start Syncthing service
sudo service syncthing start
echo ""
echo "***Syncthing is now installed and running on your Pi***"
echo ""
echo "Access the interface by typing "
echo "https://Your.Pi's.IP.Address:8384 into your web browser's"
echo "address bar (ignoring the security warnings)."
echo ""
echo "If you want to start/stop/restart Syncthing, you can type:"
echo ""
echo "sudo service syncthing stop"
echo "sudo service syncthing start"
echo "sudo service syncthing restart"
