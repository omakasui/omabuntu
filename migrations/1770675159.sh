
echo "Fix Apple Brightness Control Keybinding"

omakub-keybinding-remove 'Apple Brightness Down (ASDControl)'
omakub-keybinding-add 'Apple Brightness Down (ASDControl)' "omakub-brightness-apple-display -5000" '<Control>F1'

omakub-keybinding-remove 'Apple Brightness Up (ASDControl)'
omakub-keybinding-add 'Apple Brightness Up (ASDControl)' "omakub-brightness-apple-display +5000" '<Control>F2'

omakub-keybinding-remove 'Apple Brightness Max (ASDControl)'
omakub-keybinding-add 'Apple Brightness Max (ASDControl)' "omakub-brightness-apple-display +60000" '<Control><Shift>F2'
