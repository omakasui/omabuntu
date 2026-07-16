echo "Fix Apple Brightness Control Keybinding"

omakub-gnome-keybinding-drop 'Apple Brightness Down (ASDControl)'
omakub-gnome-keybinding-add 'Apple Brightness Down (ASDControl)' "omakub-brightness-apple-display -5000" '<Control>F1'

omakub-gnome-keybinding-drop 'Apple Brightness Up (ASDControl)'
omakub-gnome-keybinding-add 'Apple Brightness Up (ASDControl)' "omakub-brightness-apple-display +5000" '<Control>F2'

omakub-gnome-keybinding-drop 'Apple Brightness Max (ASDControl)'
omakub-gnome-keybinding-add 'Apple Brightness Max (ASDControl)' "omakub-brightness-apple-display +60000" '<Control><Shift>F2'
