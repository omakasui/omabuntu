#!/bin/bash

abort() {
  echo -e "\e[$OMAKUB_BRAND install requires: $1\e[0m"
  echo
  gum confirm "Proceed anyway on your own accord and without assistance?" || exit 1
}

# Must be a valid OS
[[ -f /etc/os-release ]] || abort "/etc/os-release"

. /etc/os-release

# Check if running on Ubuntu
SUPPORTED_VERSIONS=("24.04")
[[ $ID != "ubuntu" ]] && abort "Ubuntu LTS"
if [[ ! " ${SUPPORTED_VERSIONS[@]} " =~ " ${VERSION_ID} " ]]; then
  abort "Only Ubuntu LTS versions are supported. Supported versions: ${SUPPORTED_VERSIONS[*]}"
fi

# Must be x86 only to fully work
ARCH=$(uname -m)
if [[ $ARCH != "x86_64" ]] && [[ $ARCH != "i686" ]]; then
  abort "x86_64 CPU"
fi

# Cleared all guards
echo "Guards: OK"
