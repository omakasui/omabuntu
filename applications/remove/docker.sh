#!/bin/bash

omakub-pkg-drop docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
sudo groupdel docker
