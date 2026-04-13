#!/bin/bash

# Base Apps
apps=(
	"Chromium"
)

# Install optional apps
for app in "${apps[@]}"; do
	if [[ -f $HOME/.local/share/omakub/applications/install/${app,,}.sh ]]; then
		source "$HOME/.local/share/omakub/applications/install/${app,,}.sh"
	else
		echo "Warning: Installation script for $app not found."
	fi
done