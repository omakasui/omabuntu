#!/bin/bash

set -o pipefail

ascii_art='
 ▄██████▄    ▄▄▄▄███▄▄▄▄      ▄████████ ▀█████████▄  ███    █▄  ███▄▄▄▄       ███     ███    █▄
███    ███ ▄██▀▀▀███▀▀▀██▄   ███    ███   ███    ███ ███    ███ ███▀▀▀██▄ ▀█████████▄ ███    ███
███    ███ ███   ███   ███   ███    ███   ███    ███ ███    ███ ███   ███    ▀███▀▀██ ███    ███
███    ███ ███   ███   ███   ███    ███  ▄███▄▄▄██▀  ███    ███ ███   ███     ███   ▀ ███    ███
███    ███ ███   ███   ███ ▀███████████ ▀▀███▀▀▀██▄  ███    ███ ███   ███     ███     ███    ███
███    ███ ███   ███   ███   ███    ███   ███    ██▄ ███    ███ ███   ███     ███     ███    ███
███    ███ ███   ███   ███   ███    ███   ███    ███ ███    ███ ███   ███     ███     ███    ███
 ▀██████▀   ▀█   ███   █▀    ███    █▀  ▄█████████▀  ████████▀   ▀█   █▀     ▄████▀   ████████▀
'
clear
echo -e "\n$ascii_art\n"

sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

# Use custom repo if specified, otherwise use default
OMAKUB_REPO="${OMAKUB_REPO:-omakasui/omabuntu}"

# Use custom brand if specified, otherwise use default
OMAKUB_BRAND="${OMAKUB_BRAND:-Omabuntu}"

echo -e "\nCloning $OMAKUB_BRAND from: https://github.com/${OMAKUB_REPO}.git"
rm -rf ~/.local/share/omakub
git clone https://github.com/$OMAKUB_REPO.git ~/.local/share/omakub >/dev/null

# Use custom branch if instructed, otherwise default to main
OMAKUB_REF="${OMAKUB_REF:-main}"
echo -e "\e[32mUsing branch: $OMAKUB_REF\e[0m"
cd ~/.local/share/omakub
git fetch origin "${OMAKUB_REF}" && git checkout "${OMAKUB_REF}"
cd -

# Set channel based on branch (dev branch uses dev channel, everything else uses stable)
if [[ $OMAKUB_REF == "dev" ]]; then
  export OMAKUB_CHANNEL=dev
else
  export OMAKUB_CHANNEL=stable
fi

echo -e "\nInstallation starting..."
source ~/.local/share/omakub/install.sh
