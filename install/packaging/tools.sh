#!/bin/bash

# Install Alacritty
source ~/.local/share/omakub/applications/install/alacritty.sh

# Install Fastfetch
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
sudo apt update
omakub-pkg-add fastfetch

# Install mise
source ~/.local/share/omakub/applications/install/mise.sh

# Install Zellij
source ~/.local/share/omakub/applications/install/zellij.sh

# Install Docker
source ~/.local/share/omakub/applications/install/docker.sh

# Install GitHub CLI
source ~/.local/share/omakub/applications/install/github-cli.sh

# Install Starship
source ~/.local/share/omakub/applications/install/starship.sh