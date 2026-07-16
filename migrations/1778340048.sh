echo "Use interactive unlock (Plymouth) selector menu"

mkdir -p ~/.config/elephant/menus
ln -snf $OMAKUB_PATH/default/elephant/omakub_unlocks.lua ~/.config/elephant/menus/omakub_unlocks.lua
omakub-restart-walker