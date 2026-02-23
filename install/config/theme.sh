#!/bin/bash

# Setup user theme folder
if [[ -d ~/.config/omakub/themes ]]; then
  rm -rf ~/.config/omakub/themes
fi
mkdir -p ~/.config/omakub/themes

# Set initial theme
omakub-theme-set "Tokyo Night"

# Set specific app links for current theme
ln -snf ~/.config/omakub/current/theme/neovim.lua ~/.config/nvim/lua/plugins/theme.lua

mkdir -p ~/.config/btop/themes
ln -snf ~/.config/omakub/current/theme/btop.theme ~/.config/btop/themes/current.theme

mkdir -p ~/.config/zellij/themes
ln -snf ~/.config/omakub/current/theme/zellij.kdl ~/.config/zellij/themes/current.kdl