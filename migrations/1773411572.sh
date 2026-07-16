echo "Migrate to Walker from Wofi"
omakub-pkg-add omakub-walker
omakub-pkg-drop wofi

# Apply Walker and Elephant changes immediately
mkdir -p ~/.config/walker/
cp -f $OMAKUB_PATH/config/walker/config.toml ~/.config/walker/config.toml

mkdir -p ~/.config/elephant/
cp -f $OMAKUB_PATH/config/elephant/calc.toml ~/.config/elephant/calc.toml
cp -f $OMAKUB_PATH/config/elephant/desktopapplications.toml ~/.config/elephant/desktopapplications.toml
cp -f $OMAKUB_PATH/config/elephant/symbols.toml ~/.config/elephant/symbols.toml

bash $OMAKUB_PATH/install/config/walker-elephant.sh

# Set omakub next background to Super+Shift+Control
omakub-gnome-keybinding-drop 'Omakub Background Next'
omakub-gnome-keybinding-drop 'Omabuntu Background Next'
omakub-gnome-keybinding-add 'Omabuntu Background Next' 'omakub-menu background' '<Super><Control>space'

bash $OMAKUB_PATH/install/first-run/elephant.sh

# Require a logout to apply the new keybinding and menu changes
omakub-state set logout-required