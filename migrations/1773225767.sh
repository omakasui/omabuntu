echo -e "\e[32m\nRefresh Omakasui APT repository with new keyring and source list\e[0m"

if [[ -f /usr/share/keyrings/omakasui-apt.gpg ]]; then
  sudo rm -f /usr/share/keyrings/omakasui-apt.gpg
fi

if [[ -f /etc/apt/sources.list.d/omakasui.list ]]; then
  sudo rm -f /etc/apt/sources.list.d/omakasui.list
fi

curl -fsSL https://keyrings.omakasui.org/omakasui-packages.gpg.key \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/omakasui-packages.gpg > /dev/null

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/omakasui-packages.gpg] \
  https://packages.omakasui.org $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") main" \
  | sudo tee /etc/apt/sources.list.d/omakasui.list > /dev/null

sudo apt update

echo -e "\e[32m\nRefresh Omakasui packages\e[0m"

# Gum
omakub-pkg-add gum

# Lazygit, Lazydocker, Fastfetch
if omakub-pkg-present omakasui-lazygit; then
  omakub-pkg-drop omakasui-lazygit
fi
omakub-pkg-add lazygit

if omakub-pkg-present omakasui-lazydocker; then
  omakub-pkg-drop omakasui-lazydocker
fi
omakub-pkg-add lazydocker

sudo add-apt-repository --remove -y ppa:zhangsongcui3371/fastfetch
if omakub-pkg-present omakasui-fastfetch; then
  omakub-pkg-drop omakasui-fastfetch
fi
omakub-pkg-add fastfetch

# Fonts
if omakub-pkg-present omakasui-fonts-cascadia-mono-nf; then
  omakub-pkg-drop omakasui-fonts-cascadia-mono-nf
  omakub-pkg-add fonts-cascadia-mono-nf
fi

if omakub-pkg-present omakasui-fonts-jetbrains-mono; then
  omakub-pkg-drop omakasui-fonts-jetbrains-mono
  omakub-pkg-add fonts-jetbrains-mono
fi

if omakub-pkg-present omakasui-fonts-ia-writer-mono; then
  omakub-pkg-drop omakasui-fonts-ia-writer-mono
  omakub-pkg-add fonts-ia-writer-mono
fi

# NVim
echo -e "\e[32m\nChange to omakub-nvim package\e[0m"
if omakub-pkg-present omakub-nvim; then
  omakub-pkg-add omakub-nvim
else
  omakub-pkg-add omakub-nvim
  # Will trigger to overwrite configs or not to pickup new hot-reload themes
  omakub-setup-nvim
fi

# Nautilus
echo -e "\e[32m\nNautilus now handles all terminals...\e[0m"
if omakub-pkg-present nautilus-extension-gnome-terminal; then
    omakub-pkg-drop nautilus-extension-gnome-terminal
fi

if omakub-pkg-present omakasui-nautilus-open-any-terminal; then
    omakub-pkg-drop omakasui-nautilus-open-any-terminal
fi
omakub-pkg-add nautilus-open-any-terminal

# Set the default terminal for the nautilus-open-any-terminal extension
DEFAULT_TERMINAL=$(omakub-terminal-current)
DEFAULT_TERMINAL=${DEFAULT_TERMINAL,,}

gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal "${DEFAULT_TERMINAL}"
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal keybindings '<Ctrl><Alt>t'
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal new-tab true
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal flatpak system


