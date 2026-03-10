echo "Fix ctrl+alt+t not opening default terminal"

if dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ | grep -A 3 "binding='<Control><Alt>t'" | grep -q "command='x-terminal-emulator'"; then
  omakub-keybinding-remove 'Default Terminal'
  omakub-keybinding-add 'Default Terminal' "xdg-terminal-exec" '<Control><Alt>t'
fi