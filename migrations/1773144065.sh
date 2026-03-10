echo "Change to omakasui packages for Fastfetch, Lazygit, Lazydocker and Zellij"
omakub-pkg-add omakasui-lazygit
omakub-pkg-add omakasui-lazydocker
omakub-pkg-add omakasui-zellij

sudo add-apt-repository --remove -y ppa:zhangsongcui3371/fastfetch
omakub-pkg-add omakasui-fastfetch