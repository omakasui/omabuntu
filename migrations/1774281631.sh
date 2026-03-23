echo "Update alacritty configs"
omakub-refresh-config alacritty/alacritty.toml

echo "Setting up omakub-zellij configuration"
omakub-pkg-add omakub-zellij
omakub-setup-zellij