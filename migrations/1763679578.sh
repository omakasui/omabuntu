echo "Disabling Night Light by default and adding manual schedule settings..."
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 0.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 0.0