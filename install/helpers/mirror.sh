# Ensure we have curl available
if ! command -v curl &> /dev/null; then
  omakub-pkg-add curl
fi

# Add Omakasui APT repositories
curl -fsSL https://keyrings.omakasui.org/omakasui-core.gpg.key \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/omakasui-core.gpg > /dev/null

curl -fsSL https://keyrings.omakasui.org/omakasui-packages.gpg.key \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/omakasui-packages.gpg > /dev/null

codename=$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")

if [[ ${OMAKUB_CHANNEL:-stable} == "dev" ]]; then
  suite="${codename}-dev"
else
  suite="$codename"
fi

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/omakasui-core.gpg] \
  https://core.omakasui.org $suite main" \
  | sudo tee /etc/apt/sources.list.d/omakasui-core.list

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/omakasui-packages.gpg] \
  https://packages.omakasui.org $suite main" \
  | sudo tee /etc/apt/sources.list.d/omakasui.list

sudo apt-get update