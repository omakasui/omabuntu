#!/bin/bash

if [[ ! -f /etc/apt/sources.list.d/mise.list ]]; then
  [[ -f /etc/apt/keyrings/mise-archive-keyring.gpg ]] && sudo rm /etc/apt/keyrings/mise-archive-keyring.gpg
  curl -fSs https://mise.jdx.dev/gpg-key.pub | sudo tee /etc/apt/keyrings/mise-archive-keyring.asc 1> /dev/null
  echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.asc] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
fi

sudo apt update
omakub-pkg-add mise
