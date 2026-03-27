echo "Update alacritty configs"
omakub-refresh-config alacritty/alacritty.toml

if omakub-cmd-present zellij; then
  echo "Setting up omakub-zellij configuration"
  if omakub-pkg-present omakasui-zellij; then
    omakub-pkg-drop omakasui-zellij
  fi
  omakub-pkg-add zellij omakub-zellij
  # Set up the configuration for zellij
  omakub-setup-zellij
fi