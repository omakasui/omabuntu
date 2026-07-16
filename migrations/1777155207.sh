echo "Install Rounded Window Corsers Reborn extension..."

# Install extension
gext install rounded-window-corners@fxgn

sudo cp ~/.local/share/gnome-shell/extensions/rounded-window-corners\@fxgn/schemas/org.gnome.shell.extensions.rounded-window-corners-reborn.gschema.xml /usr/share/glib-2.0/schemas/
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/

# Configure extension
gsettings set org.gnome.shell.extensions.rounded-window-corners-reborn border-width 2
gsettings set org.gnome.shell.extensions.rounded-window-corners-reborn skip-libadwaita-app false
gsettings set org.gnome.shell.extensions.rounded-window-corners-reborn skip-libhandy-app false
gsettings set org.gnome.shell.extensions.rounded-window-corners-reborn tweak-kitty-terminal true
gsettings set org.gnome.shell.extensions.rounded-window-corners-reborn blacklist "['dev.benz.walker']"

# Reapply theme
omakub-theme-set "$(omakub-theme-current)"