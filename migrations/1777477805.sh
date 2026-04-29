echo "Add core packages repository..."

codename=$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
branch=$(omakub-version-branch)

if [[ ${branch:-stable} == "dev" ]]; then
  suite="${codename}-dev"
else
  suite="$codename"
fi

curl -fsSL https://keyrings.omakasui.org/omakasui-core.gpg.key \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/omakasui-core.gpg > /dev/null

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/omakasui-core.gpg] \
  https://core.omakasui.org $suite main" \
  | sudo tee /etc/apt/sources.list.d/omakasui-core.list > /dev/null

sudo apt update
