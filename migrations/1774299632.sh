echo "Add Tmux as an option with themed styling"

omakub-pkg-add tmux

if [[ ! -f ~/.config/tmux/tmux.conf ]]; then
  mkdir -p ~/.config/tmux
  cp $OMAKUB_PATH/config/tmux/tmux.conf ~/.config/tmux/tmux.conf
  omakub-theme-refresh
fi

echo "Add Tmux binding (Super+Alt+Return)"

omakub-keybinding-add 'Tmux (Alt)' 'xdg-terminal-exec bash -c "tmux attach || tmux new -s Work"' '<Super><Alt>Return'