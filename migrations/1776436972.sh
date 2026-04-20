echo "Generate current nightlight toggle..."

CURRENT_STATE=$(gsettings get org.gnome.settings-daemon.plugins.color night-light-enabled)

if [[ $CURRENT_STATE == "true" ]]; then
  touch "$HOME/.local/state/omakub/toggles/night-light"
else
  rm -f "$HOME/.local/state/omakub/toggles/night-light"
fi