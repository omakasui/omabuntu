echo "Migrate from omakasui-zellij to omakub-zellij"
if omakub-cmd-present zellij; then
  if omakub-pkg-present omakasui-zellij; then
    omakub-pkg-drop omakasui-zellij
  fi
  omakub-pkg-add zellij omakub-zellij
fi