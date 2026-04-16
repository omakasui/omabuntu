echo "Install asdcontrol via package and setup sudo-less brightness controls"

omakub-pkg-add asdcontrol

# Remove old hand-crafted udev rules (now shipped inside the package)
sudo rm -f /etc/udev/rules.d/50-apple-xdr.rules /etc/udev/rules.d/50-apple-studio.rules

# Apply sudo-less sudoers entry (idempotent)
source $OMAKUB_PATH/install/config/sudoless-asdcontrol.sh
