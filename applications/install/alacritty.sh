#!/bin/bash

omakub-pkg-add alacritty

# Migrate alacritty config format if needed
alacritty migrate 2>/dev/null || true

# Create custom desktop entry with X-TerminalArg* keys
cp $OMAKUB_PATH/applications/desktop/Alacritty.desktop ~/.local/share/applications/

# Add to xdg-terminals if xdg-terminal-exec is installed (only for noble users)
mkdir -p ~/.local/share/xdg-terminals
cp ~/.local/share/applications/Alacritty.desktop ~/.local/share/xdg-terminals/