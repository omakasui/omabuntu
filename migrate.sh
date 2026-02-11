#!/bin/bash

set -o pipefail

ascii_art='
 ██████  ███    ███  █████  ██████  ██    ██ ███    ██ ████████ ██    ██
██    ██ ████  ████ ██   ██ ██   ██ ██    ██ ████   ██    ██    ██    ██
██    ██ ██ ████ ██ ███████ ██████  ██    ██ ██ ██  ██    ██    ██    ██
██    ██ ██  ██  ██ ██   ██ ██   ██ ██    ██ ██  ██ ██    ██    ██    ██
 ██████  ██      ██ ██   ██ ██████   ██████  ██   ████    ██     ██████
'
clear
echo -e "\n$ascii_art\n"

sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null


# Define migration variables
export OMAKUB_REPO="${OMAKUB_REPO:-omakasui/omabuntu}"
export OMAKUB_REF="${OMAKUB_REF:-main}"
export OMAKUB_BRAND="${OMAKUB_BRAND:-Omabuntu}"
export OMAKUB_MIGRATE="$HOME/.local/share/omakub/install/migrate"

# Define backup location
export BACKUP_DIR="$HOME/.local/share/omakub-backup-$(date +%Y%m%d_%H%M%S)"

# Check Omakub installation
if [[ ! -d "$HOME/.local/share/omakub" ]]; then
    echo "Error: Omakub not found. Please run the installer instead."
    exit 1
fi

# Upgrade your system
sudo apt-get update >/dev/null
sudo apt-get upgrade -y >/dev/null

# Check for gum
if ! command -v gum &>/dev/null; then
    cd /tmp
    wget -q -O gum.deb "https://github.com/charmbracelet/gum/releases/download/v0.17.0/gum_0.17.0_amd64.deb"
    sudo apt install -y --allow-downgrades ./gum.deb >/dev/null 2>&1
    rm gum.deb
    cd - >/dev/null
fi

gum style --border normal --border-foreground 6 --padding "1 2" \
  "Ready to migrate to Omabuntu?" \
  "" \
  "• This migration cannot be stopped once started!" \
  "• Make sure you're connected to power or have a full battery" \
  "• A backup will be created before proceeding"

echo

# Request confirmation
if ! gum confirm "Continue with migration?"; then
  echo "Migration cancelled"
  exit 1
fi

# Backup
mkdir -p "$BACKUP_DIR"
cp -r ~/.local/share/omakub "$BACKUP_DIR/omakub" 2>/dev/null || true
cp -f ~/.bashrc "$BACKUP_DIR/bashrc.bak" 2>/dev/null || true

# Clone
echo -e "\nCloning $OMAKUB_BRAND from: https://github.com/${OMAKUB_REPO}.git"
rm -rf ~/.local/share/omakub
git clone https://github.com/$OMAKUB_REPO.git ~/.local/share/omakub >/dev/null 2>/dev/null || {
     echo "Clone failed, restoring backup..."
     rm -rf ~/.local/share/omakub
     cp -r "$BACKUP_DIR/omakub" ~/.local/share/omakub
     exit 1
}

# Use custom branch if instructed, otherwise default to main
echo -e "\e[32mUsing branch: $OMAKUB_REF\e[0m"
cd ~/.local/share/omakub
git fetch origin "${OMAKUB_REF}" && git checkout "${OMAKUB_REF}"
cd -

# Migrate
source "$OMAKUB_MIGRATE/all.sh"
source ~/.local/share/omakub/install.sh

