echo "Migrate from omakasui-nvim to omakub-nvim"
if omakub-pkg-present omakasui-nvim; then
    omakub-pkg-drop omakasui-nvim
fi
omakub-pkg-add omakub-nvim