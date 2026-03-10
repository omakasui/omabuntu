echo "Change to omakasui packages for Fastfetch, Lazygit, Lazydocker and Zellij"
omakub-pkg-add omakasui-lazygit
omakub-pkg-add omakasui-lazydocker
omakub-pkg-add omakasui-zellij

if [[ -f /etc/apt/sources.list.d/zhangsongcui3371-fastfetch.list ]]; then
    sudo rm /etc/apt/sources.list.d/zhangsongcui3371-fastfetch.list
    sudo apt update
fi
omakub-pkg-add omakasui-fastfetch