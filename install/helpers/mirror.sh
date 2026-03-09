#!/bin/bash

# Add Omakasui APT repository
curl -fsSL https://packages.omakasui.org/omakasui.gpg.key \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/omakasui-apt.gpg > /dev/null

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/omakasui-apt.gpg] \
  https://packages.omakasui.org $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") main" \
  | sudo tee /etc/apt/sources.list.d/omakasui.list

sudo apt update