if [[ ! -f /etc/apt/sources.list.d/docker.list ]]; then
    [[ -f /etc/apt/keyrings/docker.asc ]] && sudo rm /etc/apt/keyrings/docker.asc
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo wget -qO /etc/apt/keyrings/docker.asc https://download.docker.com/linux/ubuntu/gpg
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
fi

sudo apt-get update
omakub-pkg-add docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras