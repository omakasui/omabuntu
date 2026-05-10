# Ensure Walker service is started automatically on boot
mkdir -p ~/.config/autostart/
cp $OMAKUB_PATH/default/walker/walker.desktop ~/.config/autostart/

# And is restarted if it crashes or is killed
mkdir -p ~/.config/systemd/user/app-walker@autostart.service.d/
cp $OMAKUB_PATH/default/walker/restart.conf ~/.config/systemd/user/app-walker@autostart.service.d/restart.conf

# Create apt hook to restart walker after updates
sudo mkdir -p /etc/apt/apt.conf.d
sudo tee /etc/apt/apt.conf.d/99restart-walker << EOF
DPkg::Post-Invoke {
    "if dpkg -l walker 2>/dev/null | grep -q '^ii'; then $OMAKUB_PATH/bin/omakub-restart-walker; fi";
};
EOF

# Link the visual theme menu config
mkdir -p ~/.config/elephant/menus
ln -snf $OMAKUB_PATH/default/elephant/omakub_themes.lua ~/.config/elephant/menus/omakub_themes.lua
ln -snf $OMAKUB_PATH/default/elephant/omakub_background_selector.lua ~/.config/elephant/menus/omakub_background_selector.lua
ln -snf $OMAKUB_PATH/default/elephant/omakub_unlocks.lua ~/.config/elephant/menus/omakub_unlocks.lua
