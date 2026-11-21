# Keep the Omabuntu boot splash and login screen after the boot and GDM packages changed.
set -e

plymouth_theme=/usr/share/plymouth/themes/omakub/omakub.plymouth

# Older installs listed plymouth, which is not a kernel module, among the initramfs modules.
if [[ -f /etc/initramfs-tools/modules ]]; then
  sudo sed -i "/^plymouth$/d" /etc/initramfs-tools/modules
fi

if [[ -f $plymouth_theme ]]; then
  sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth "$plymouth_theme" 100
  sudo update-alternatives --set default.plymouth "$plymouth_theme"
  sudo update-initramfs -u
fi

# A new GDM package can replace its dconf profile and drop the Omabuntu greeter settings.
if [[ -f /etc/dconf/profile/gdm ]] && ! grep -q "^system-db:gdm" /etc/dconf/profile/gdm; then
  sudo sed -i "/^user-db:user/a system-db:gdm" /etc/dconf/profile/gdm
fi

sudo dconf update
