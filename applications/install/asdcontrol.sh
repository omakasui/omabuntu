#!/bin/bash

# Install asdcontrol (Apple Display Brightness Control)
omakub-pkg-add asdcontrol

# Setup sudo-less controls
source $OMAKUB_PATH/install/config/sudoless-asdcontrol.sh

# Reboot to pickup changes
gum confirm "Ready to reboot for brightness controls to be available?" && sudo reboot
