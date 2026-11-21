# Bring the GNOME extensions to versions built for the new GNOME Shell.
set -e

extensions_dir="$HOME/.local/share/gnome-shell/extensions"
system_schemas_dir=/usr/share/glib-2.0/schemas

gum confirm "Updating GNOME extensions for the new GNOME Shell needs some confirmations. Ready?" || true

# Quick Settings Tweaks has no release for the GNOME Shell shipped with resolute.
if [[ $(omakub-version-codename) == "resolute" && -d $extensions_dir/quick-settings-tweaks@qwreey ]]; then
  gext uninstall quick-settings-tweaks@qwreey
  sudo rm -f "$system_schemas_dir/org.gnome.shell.extensions.quick-settings-tweaks.gschema.xml"
fi

gext update --yes

# Updated extensions may ship new settings keys: refresh the schema copies used by gsettings.
for schema in "$extensions_dir"/*/schemas/*.gschema.xml; do
  if [[ -f $schema ]]; then
    sudo cp "$schema" "$system_schemas_dir/"
  fi
done

sudo glib-compile-schemas "$system_schemas_dir/"
