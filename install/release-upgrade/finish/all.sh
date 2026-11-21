# Repair Omabuntu after Ubuntu moved to a new release. Safe to run again if interrupted.
set -e

state_dir="$HOME/.local/state/omakub/release-upgrade"
mkdir -p "$state_dir"

export OMAKUB_RELEASE_UPGRADE_FROM=$(omakub-update-release-pending)
export OMAKUB_RELEASE_UPGRADE_STATE="$state_dir"

echo -e "\e[32m\nFinish the upgrade from Ubuntu $OMAKUB_RELEASE_UPGRADE_FROM to $(omakub-version-codename)\e[0m"

# Keep the previous codename and channel: the first step rewrites the sources they are read from.
echo "$OMAKUB_RELEASE_UPGRADE_FROM" >"$state_dir/from"

if [[ ! -f $state_dir/channel ]]; then
  omakub-version-channel >"$state_dir/channel"
fi

bash "$OMAKUB_PATH/install/release-upgrade/finish/sources.sh"
bash "$OMAKUB_PATH/install/release-upgrade/finish/packages.sh"
bash "$OMAKUB_PATH/install/release-upgrade/finish/pipx.sh"
bash "$OMAKUB_PATH/install/packaging/remove-snap.sh"
bash "$OMAKUB_PATH/install/release-upgrade/finish/gnome-extensions.sh"
bash "$OMAKUB_PATH/install/release-upgrade/finish/boot.sh"
bash "$OMAKUB_PATH/install/config/release-upgrades.sh"

rm -f "$HOME/.config/autostart/omakub-release-upgrade.desktop"
rm -rf "$state_dir"
omakub-state set reboot-required

echo -e "\nRuntimes built by mise against system libraries (e.g. Ruby) may need a rebuild: mise install --force"
