#!/bin/bash

# Stream music using https://spotify.com
if [ ! -f /etc/apt/sources.list.d/spotify.list ]; then
  [ -f /etc/apt/trusted.gpg.d/spotify.gpg ] && sudo rm /etc/apt/trusted.gpg.d/spotify.gpg
  curl -sS https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
  echo "deb [signed-by=/etc/apt/trusted.gpg.d/spotify.gpg] https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
fi

sudo apt update
sudo apt install -y spotify-client
