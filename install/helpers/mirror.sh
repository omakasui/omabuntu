# Ensure we have curl available
if ! command -v curl &> /dev/null; then
  omakub-pkg-add curl
fi

# Add Omakasui APT repositories
omakub-refresh-apt "${OMAKUB_CHANNEL:-stable}"
