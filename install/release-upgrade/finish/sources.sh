# Point the APT sources disabled by do-release-upgrade at the new release and re-enable them.
set -e

from_codename=$OMAKUB_RELEASE_UPGRADE_FROM
to_codename=$(omakub-version-codename)
channel=$(<"$OMAKUB_RELEASE_UPGRADE_STATE/channel")
sources_dir=/etc/apt/sources.list.d

if [[ $channel != "dev" ]]; then
  channel="stable"
fi

# Omakasui first, alone: omakub-refresh-apt fails if any enabled source is broken.
omakub-update-keyring --force

for omakasui_sources in "$sources_dir/omakasui.sources" "$sources_dir/omakasui-core.sources"; do
  if [[ -f $omakasui_sources ]]; then
    sudo sed -i "/^Enabled: *no$/d" "$omakasui_sources"
  fi
done

omakub-refresh-apt "$channel"

# Third-party sources: rewrite the codename (docker, tailscale, PPAs) and undo the
# upgrader's disabling. Sources without a codename (mise, vscode, ...) are only re-enabled.
for source_file in "$sources_dir"/*.sources "$sources_dir"/*.list; do
  source_name=$(basename "$source_file")

  if [[ ! -f $source_file || $source_name == omakasui*.sources ]]; then
    continue
  fi

  if [[ $source_file == *.sources ]]; then
    sudo sed -i -E \
      -e "/^Enabled: *no$/d" \
      -e "/^Suites:/ s/\b$from_codename\b/$to_codename/g" \
      "$source_file"
  else
    sudo sed -i -E \
      -e "s/^# (deb(-src)? .*) # disabled on upgrade to .*$/\1/" \
      -e "/^deb(-src)? / s/\b$from_codename\b/$to_codename/g" \
      "$source_file"
  fi
done

# A third-party repository without packages for the new release should not stop the repair.
if ! sudo apt-get update; then
  echo -e "\e[33mSome repositories failed to update: check $sources_dir for releases they do not provide yet.\e[0m"
fi
