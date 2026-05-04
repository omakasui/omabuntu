#!/bin/bash

# Alt+F4 is very cumbersome
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>w']"

# Make it easy to maximize like you can fill left/right
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>Up']"

# Make it easy to resize undecorated windows
gsettings set org.gnome.desktop.wm.keybindings begin-resize "['<Super>BackSpace']"

# For keyboards that only have a start/stop button for music, like Logitech MX Keys Mini
gsettings set org.gnome.settings-daemon.plugins.media-keys next "['<Shift>AudioPlay']"

# Full-screen with title/navigation bar
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Shift>F11']"

# Remove default app hotkeys, we set our own later
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "[]"
gsettings set org.gnome.settings-daemon.plugins.media-keys home "[]"
gsettings set org.gnome.settings-daemon.plugins.media-keys www "[]"
gsettings set org.gnome.settings-daemon.plugins.media-keys help "[]"

# Cancel input capture with Super+Shift+Escape
gsettings set org.gnome.mutter.keybindings cancel-input-capture "['<Super><Shift>Escape']"

# Open Tactile settings with Super+Control+T
gsettings set org.gnome.shell.extensions.tactile show-settings "['<Super><Control>t']"

# Use alt for pinned apps
gsettings set org.gnome.shell.keybindings switch-to-application-1 "['<Alt>1']"
gsettings set org.gnome.shell.keybindings switch-to-application-2 "['<Alt>2']"
gsettings set org.gnome.shell.keybindings switch-to-application-3 "['<Alt>3']"
gsettings set org.gnome.shell.keybindings switch-to-application-4 "['<Alt>4']"
gsettings set org.gnome.shell.keybindings switch-to-application-5 "['<Alt>5']"
gsettings set org.gnome.shell.keybindings switch-to-application-6 "['<Alt>6']"
gsettings set org.gnome.shell.keybindings switch-to-application-7 "['<Alt>7']"
gsettings set org.gnome.shell.keybindings switch-to-application-8 "['<Alt>8']"
gsettings set org.gnome.shell.keybindings switch-to-application-9 "['<Alt>9']"

# Use super for workspaces
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']"

# Reserve slots for input source switching
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Shift><Super>space']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Shift><Super><Alt>space']"

# Set some utility hotkeys
gsettings set org.gnome.mutter.wayland.keybindings restore-shortcuts "['<Shift><Super>Escape']"

# Empty the custom keybindings to start fresh
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[]"

# Menus
omakub-keybinding-add 'Launch apps' 'omakub-launch-apps' '<Super>space'
omakub-keybinding-add 'Omabuntu menu' 'omakub-menu' '<Alt><Super>space'
omakub-keybinding-add 'System menu' 'omakub-menu system' '<Super>Escape'

# Aesthetics
omakub-keybinding-add 'Theme menu' 'omakub-menu theme' '<Super><Shift><Control>space'
omakub-keybinding-add 'Background menu' 'omakub-menu background' '<Super><Control>space'

# Control panels
omakub-keybinding-add 'Activity' 'omakub-launch-tui btop' '<Super><Shift>t'

# Control Apple Display brightness
omakub-keybinding-add 'Apple Brightness down' "omakub-brightness-apple-display -5000" '<Control>F1'
omakub-keybinding-add 'Apple Brightness up' "omakub-brightness-apple-display +5000" '<Control>F2'
omakub-keybinding-add 'Apple Brightness max' "omakub-brightness-apple-display +60000" '<Control><Shift>F2'

# Toggles
omakub-keybinding-add 'Nightlight toggle' 'omakub-toggle-nightlight' '<Super><Control>n'

# Screenshots
omakub-keybinding-add 'Flameshot' 'sh -c -- "flameshot gui"' '<Control>Print'

# Application bindings
omakub-keybinding-add 'Terminal' 'xdg-terminal-exec' '<Super>Return'
omakub-keybinding-add 'Terminal' 'xdg-terminal-exec' '<Control><Alt>t'
omakub-keybinding-add 'Tmux' 'xdg-terminal-exec bash -c "tmux attach || tmux new -s Work"' '<Super><Alt>Return'
omakub-keybinding-add 'Browser' 'omakub-launch-browser --new-window' '<Shift><Super>b'
omakub-keybinding-add 'Browser' 'omakub-launch-browser --new-window' '<Shift><Super>Return'
omakub-keybinding-add 'Browser (private)' 'omakub-launch-browser --private' '<Shift><Alt><Super>b'
omakub-keybinding-add 'File manager' 'nautilus --new-window' '<Shift><Super>f'
omakub-keybinding-add 'Docker' 'omakub-launch-tui lazydocker' '<Super><Shift>d'
omakub-keybinding-add 'Music' 'spotify' '<Super><Shift>m'
omakub-keybinding-add 'Editor' 'omakub-launch-editor' '<Super><Shift>n'

# Set webapps hotkeys
omakub-keybinding-add 'ChatGPT' 'omakub-launch-webapp "https://chatgpt.com" "ChatGPT"' '<Super><Shift>a'
omakub-keybinding-add 'WhatsApp' 'omakub-launch-webapp "WhatsApp" "https://web.whatsapp.com/" "WhatsApp"' '<Super><Shift><Alt>g'
omakub-keybinding-add 'YouTube' 'omakub-launch-webapp "https://youtube.com/" "YouTube"' '<Super><Shift>y'
omakub-keybinding-add 'GitHub' 'omakub-launch-webapp "https://github.com/" "GitHub"' '<Super><Shift>h'

# Enable Compose key on Caps Lock
gsettings set org.gnome.desktop.input-sources xkb-options "['compose:caps']"
