echo "Update alacritty configs"
omakub-refresh-config alacritty/alacritty.toml

if omakub-cmd-present zellij; then
  echo "Setting up omakub-zellij configuration"
  omakub-setup-zellij
fi