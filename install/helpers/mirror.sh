# Ensure we have curl available
if ! command -v curl &> /dev/null; then
  omakub-pkg-add curl
fi

# Add Omakasui APT repositories: the keyring packages install the signing keys
# and the sources, then the channel is selected.
omakub-refresh-apt "${OMAKUB_CHANNEL:-stable}"
