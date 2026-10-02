echo "Move the Omakasui APT sources to the keyring packages"

if [[ $(omakub-version-branch) == "dev" ]]; then
  omakub-refresh-apt dev
else
  omakub-refresh-apt stable
fi
