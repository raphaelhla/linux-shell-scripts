#!/bin/bash

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# To install the latest version, run:
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

current_user=$(whoami)

# Verifica se o usuário já está no grupo do Docker
if groups $current_user | grep &>/dev/null '\bdocker\b'; then
    echo "O usuário $current_user já está no grupo do Docker."
else
    # Adiciona o usuário ao grupo do Docker
    sudo usermod -aG docker $current_user
    echo "O usuário $current_user foi adicionado ao grupo do Docker."
    echo "Você precisará fazer logout e login novamente para que as alterações tenham efeito."
fi

