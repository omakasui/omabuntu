echo "Migrate to Walker from Wofi"
omakub-pkg-add omakasui-walker
omakub-pkg-drop wofi

# Set omakub next background to Super+Shift+Control
omakub-keybinding-remove 'Omakub Background Next'
omakub-keybinding-remove 'Omabuntu Background Next'
omakub-keybinding-add 'Omabuntu Background Next' 'omakub-menu background' '<Super><Control>space'

# Require a logout to apply the new keybinding and menu changes
omakub-state set logout-required