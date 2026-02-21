#!/bin/bash

omakub-pkg-add openjdk-8-jdk

cd /tmp
wget https://launcher.mojang.com/download/Minecraft.deb
sudo apt install -y ./Minecraft.deb
rm Minecraft.deb
cd -
