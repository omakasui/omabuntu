#!/bin/bash

cd /tmp
wget https://bitwarden.com/download/?app=desktop&platform=linux&variant=deb -O bitwarden.deb
sudo apt install ./bitwarden.deb -y
rm bitwarden.deb
cd -