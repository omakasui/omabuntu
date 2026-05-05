# Check if the XTraDeb PPA is already added
if ! grep -q "xtradeb/apps" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  sudo add-apt-repository -y ppa:xtradeb/apps
fi

# Create or update the APT preferences file to prioritize XTraDeb package
if [[ ! -f /etc/apt/preferences.d/chromium-xtradeb ]]; then
  sudo tee /etc/apt/preferences.d/chromium-xtradeb > /dev/null <<EOF
Package: *
Pin: release o=LP-PPA-xtradeb-apps
Pin-Priority: 100

Package: chromium*
Pin: release o=LP-PPA-xtradeb-apps
Pin-Priority: 700
EOF
fi

sudo apt-get update
omakub-pkg-add chromium