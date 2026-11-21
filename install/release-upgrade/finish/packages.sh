# Move packages to the builds for the new release and reinstall what the upgrade removed.
set -e

saved_packages="$OMAKUB_RELEASE_UPGRADE_STATE/packages"

# Omakasui builds carry the codename in their version (+noble < +resolute), so they upgrade here.
sudo apt-get -y -o Dpkg::Options::=--force-confold dist-upgrade

bash "$OMAKUB_PATH/install/packaging/base.sh"

# Third-party packages recorded before the upgrade: only present when it went through omakub-update-release.
if [[ -f $saved_packages ]]; then
  unavailable=()

  while read -r package; do
    if ! omakub-pkg-missing "$package"; then
      continue
    fi

    candidate=$(apt-cache policy "$package" | awk '$1 == "Candidate:" { print $2 }')

    if [[ -z $candidate || $candidate == "(none)" ]]; then
      unavailable+=("$package")
    else
      sudo apt-get -y install "$package"
    fi
  done <"$saved_packages"

  if (( ${#unavailable[@]} > 0 )); then
    echo -e "\e[33mNot available for the new release, not reinstalled: ${unavailable[*]}\e[0m"
  fi
fi

# Packages no repository provides anymore are still the builds for the previous release.
leftovers=$(apt list --installed 2>/dev/null | awk -F/ '/,local\]/ { print $1 }' | xargs)

if [[ -n $leftovers ]]; then
  echo -e "\e[33mInstalled packages without a repository (still built for the previous release): $leftovers\e[0m"
fi
