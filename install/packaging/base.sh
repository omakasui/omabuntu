# Install all base packages
mapfile -t packages < <(grep -v '^#' "$OMAKUB_PATH/install/omakub-base.packages" | grep -v '^$')
omakub-pkg-add "${packages[@]}"
