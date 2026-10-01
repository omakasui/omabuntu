echo "Upgrade Omakasui mirrors and keyring packages"

# Switch to the omadeb product path, keeping the current suite (stable or dev).
core_list=/etc/apt/sources.list.d/omakasui-core.list

if [[ -f $core_list ]]; then
  sudo sed -i -E 's#https://core\.omakasui\.org[[:space:]]+#https://core.omakasui.org/omabuntu #' "$core_list"
else
  # Missing core source: follow the channel of packages.omakasui.org.
  if grep -qP 'https://packages\.omakasui\.org\s+\S+-dev\s' /etc/apt/sources.list.d/omakasui.list 2>/dev/null; then
    omakub-refresh-apt dev
  else
    omakub-refresh-apt stable
  fi
fi

sudo apt-get update

# The keyring packages take ownership of the keys in /usr/share/keyrings
# and keep them up to date through apt.
omakub-pkg-add omakasui-archive-keyring omakasui-core-archive-keyring
