#!bin/bash

sudo apt update
sudo apt upgrade

# Install git
sudo apt install git -y
# Config git
git config --global user.name raphaelhla
git config --global user.email raphael.agra@ccc.ufcg.edu.br
git config --global core.editor vim

# Install vim
sudo apt install vim -y

# Install chrome
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt update
sudo apt-get install -f

# Install DisplayLink Driver
cd ~/Downloads
wget https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb
sudo apt install ~/Downloads/synaptics-repository-keyring.deb
sudo apt update
sudo apt install displaylink-driver -y

# Install gimp
sudo apt install gimp

# Install VS Code
sudo snap install code --classic

# Install discord
sudo snap install discord

# Install VLC
sudo snap install vlc

# Install Slack
sudo snap install slack

# Install Mattermost
sudo snap install mattermost-desktop

# Install OBS-Studio
sudo snap install obs-studio





# Install DOCKER
sudo apt-get install ca-certificates curl gnupg -y
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
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

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

