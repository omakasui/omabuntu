# Check if we're on the dev branch and refresh APT references if so
if [[ "$(omakub-version-branch)" == "dev" ]]; then
    echo "Updating APT repository references for dev branch..."
    omakub-refresh-apt "dev"
fi