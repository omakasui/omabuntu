if [ ! -f "$HOME/.config/omakub/current/theme/walker.css" ]; then
    echo "Reapply current theme to update it with the new walker.css file"
    omakub-theme-set "$(omakub-theme-current)"
fi