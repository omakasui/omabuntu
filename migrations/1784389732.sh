echo "Route existing web app launchers through omakub-launch-browser, dropping the omakub-launch-webapp dependency"

APPLICATIONS_DIR="$HOME/.local/share/applications"

find "$APPLICATIONS_DIR" -maxdepth 1 -name "*.desktop" 2>/dev/null | while read -r desktop_file; do
  if ! grep -qE '^Exec=omakub-launch-webapp ' "$desktop_file"; then
    continue
  fi

  url=$(sed -n 's/^Exec=omakub-launch-webapp \([^ ]*\).*/\1/p' "$desktop_file")
  app_name=$(sed -n 's/^Name=//p' "$desktop_file" | head -1)
  app_id=$(echo "$app_name" | sed 's/[^a-zA-Z0-9]//g' | tr '[:upper:]' '[:lower:]')
  webapp_data_dir="$HOME/.config/omakub/webapp/$(echo "$app_name" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')"
  mkdir -p "$webapp_data_dir"

  new_exec="Exec=omakub-launch-browser --user-data-dir=\"$webapp_data_dir\" --window-size=800,600 --app=\"$url\" --class=$app_id --name=\"$app_name\""

  new_content=$(awk -v newexec="$new_exec" '/^Exec=omakub-launch-webapp /{print newexec; next}{print}' "$desktop_file")
  printf '%s\n' "$new_content" > "$desktop_file"
done

update-desktop-database "$APPLICATIONS_DIR"
