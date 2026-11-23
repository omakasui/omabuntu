# Prepare the system for do-release-upgrade and record what the repair needs afterwards.
set -e

state_dir="$HOME/.local/state/omakub/release-upgrade"
mkdir -p "$state_dir"

# Packages installed from non-Ubuntu repositories: do-release-upgrade disables those
# repositories and may remove the packages as obsolete, so the repair reinstalls them.
third_party_packages() {
  local release_file

  for release_file in /var/lib/apt/lists/*_InRelease; do
    if grep -q "^Origin: Ubuntu$" "$release_file"; then
      continue
    fi

    local lists_prefix=${release_file%InRelease}
    cat "$lists_prefix"*_Packages 2>/dev/null | awk '$1 == "Package:" { print $2 }'
  done | sort -u
}

installed_packages() {
  dpkg-query -W -f='${db:Status-Abbrev} ${Package}\n' | awk '$1 == "ii" { print $2 }' | sort -u
}

comm -12 <(third_party_packages) <(installed_packages) >"$state_dir/packages"

# The channel is read from the Omakasui sources, which the repair rewrites.
omakub-version-channel >"$state_dir/channel"
omakub-version-codename >"$state_dir/from"

# A held snapd can keep the upgrader from computing the upgrade; the repair removes snap again.
sudo apt-mark unhold snapd >/dev/null 2>&1 || true

# Open a terminal at the first login on the new release to run the repair.
mkdir -p "$HOME/.config/autostart"
cat >"$HOME/.config/autostart/omakub-release-upgrade.desktop" <<'EOF'
[Desktop Entry]
Type=Application
Name=Finish Omabuntu release upgrade
Exec=bash -c "omakub-update-release-pending >/dev/null && omakub-launch-terminal-with-presentation 'omakub-update -y'"
NoDisplay=true
X-GNOME-Autostart-enabled=true
EOF
