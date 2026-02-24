#!/bin/bash

# Install all base packages
mapfile -t packages < <(grep -v '^#' "$OMAKUB_INSTALL/omakub-base.packages" | grep -v '^$')
omakub-pkg-add "${packages[@]}"
