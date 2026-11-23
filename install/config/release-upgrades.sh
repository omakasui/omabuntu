# Disable Ubuntu release upgrade prompts: do-release-upgrade disables the Omakasui
# repositories and leaves the desktop half-broken, so Omabuntu must drive the switch.
release_upgrades_config=/etc/update-manager/release-upgrades

if [[ -f $release_upgrades_config ]]; then
  if grep -q "^Prompt=" "$release_upgrades_config"; then
    sudo sed -i "s/^Prompt=.*/Prompt=never/" "$release_upgrades_config"
  else
    echo "Prompt=never" | sudo tee -a "$release_upgrades_config" >/dev/null
  fi
fi
