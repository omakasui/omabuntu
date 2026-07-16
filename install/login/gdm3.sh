# Use Wayland by default
sudo sed -i 's/^#WaylandEnable=false/WaylandEnable=true/' /etc/gdm3/custom.conf

# Enable GDM3 service
sudo systemctl enable gdm3

# Copy the default Omabuntu logo and background to the system pixmaps directory.
sudo mkdir -p /usr/share/pixmaps/omakub/
sudo cp "$OMAKUB_PATH/default/gdm/logo.png" /usr/share/pixmaps/omakub/gdm-logo.png
sudo cp "$OMAKUB_PATH/default/gdm/background.png" /usr/share/pixmaps/omakub/gdm-background.png

# Apply GDM theme via dconf system-db (higher priority than file-db)
sudo mkdir -p /etc/dconf/db/gdm.d/locks
sudo cp "$OMAKUB_PATH/default/gdm/greeter.dconf-defaults" /etc/dconf/db/gdm.d/96-omakub-theme

sudo tee /etc/dconf/db/gdm.d/locks/96-omakub-theme > /dev/null << 'EOF'
/org/gnome/login-screen/logo
/com/ubuntu/login-screen/background-picture-uri
/com/ubuntu/login-screen/background-picture-uri-dark
/com/ubuntu/login-screen/background-size
EOF

# Also copy the same settings to the GDM file-db as a fallback (GDM compiles this into the file-db on startup)
sudo cp "$OMAKUB_PATH/default/gdm/greeter.dconf-defaults" /etc/gdm3/greeter.dconf-defaults

# Ensure the GDM dconf profile includes system-db:gdm
if [[ -f /etc/dconf/profile/gdm ]] && ! grep -q "^system-db:gdm" /etc/dconf/profile/gdm; then
  sudo sed -i '/^user-db:user/a system-db:gdm' /etc/dconf/profile/gdm
fi

sudo dconf update
