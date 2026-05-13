# Use Wayland by default
sudo sed -i 's/^#WaylandEnable=false/WaylandEnable=true/' /etc/gdm3/custom.conf

# Enable GDM3 service
sudo systemctl enable gdm3

# Copy the default Omabuntu logo and background to the system pixmaps directory.
sudo mkdir -p /usr/share/pixmaps/omakub/
sudo cp "$OMAKUB_PATH/default/gdm/logo.png" /usr/share/pixmaps/omakub/gdm-logo.png
sudo cp "$OMAKUB_PATH/default/gdm/background.png" /usr/share/pixmaps/omakub/gdm-background.png

# Write initial GDM theme to /etc/dconf/db/gdm.d/96-omakub-theme.
# On Ubuntu 24.04+ the dconf profile uses system-db:gdm (compiled from gdm.d/),
# so greeter.dconf-defaults is not read directly.
sudo tee /etc/dconf/db/gdm.d/96-omakub-theme > /dev/null << 'EOF'
[org/gnome/login-screen]
logo='/usr/share/pixmaps/omakub/gdm-logo.png'

[com/ubuntu/login-screen]
background-picture-uri='file:///usr/share/pixmaps/omakub/gdm-background.png'
background-picture-uri-dark='file:///usr/share/pixmaps/omakub/gdm-background.png'
background-size='zoom'
EOF

sudo dconf update
