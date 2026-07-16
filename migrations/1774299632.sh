echo "Add Tmux as an option with themed styling"

omakub-pkg-add tmux

if [[ ! -f ~/.config/tmux/tmux.conf ]]; then
  mkdir -p ~/.config/tmux
  cp $OMAKUB_PATH/config/tmux/tmux.conf ~/.config/tmux/tmux.conf
  omakub-restart-tmux
fi

echo "Add Tmux binding (Super+Alt+Return)"
omakub-gnome-keybinding-add 'Terminal (Tmux)' 'xdg-terminal-exec bash -c "tmux attach || tmux new -s Work"' '<Super><Alt>Return'