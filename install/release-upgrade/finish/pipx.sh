# pipx virtual environments point at the previous release's Python: rebuild them all.
set -e

if omakub-cmd-present pipx; then
  pipx reinstall-all
fi
