#!bin/bash

install_discord() {
    echo "Instalando o Discord..."
    
    if ! snap list discord &> /dev/null; then 
        sudo snap install discord &> /dev/null
    fi
}

install_vlc() {
    echo "Instalando o VLC..."
    
    if ! snap list vlc &> /dev/null; then 
        sudo snap install vlc &> /dev/null
    fi
}

install_slack() {
    echo "Instalando o Slack..."
    
    if ! snap list slack &> /dev/null; then 
        sudo snap install slack &> /dev/null
    fi
}

install_vs_code() {
    echo "Instalando o VS Code..."
    
    if ! snap list code &> /dev/null; then 
        sudo snap install code --classic &> /dev/null
    fi
}

install_mattermost() {
    echo "Instalando o Mattermost..."
    
    if ! snap list mattermost-desktop &> /dev/null; then 
        sudo snap install mattermost-desktop &> /dev/null
    fi
}

install_obs_studio() {
    echo "Instalando o OBS Studio..."
    
    if ! snap list obs-studio &> /dev/null; then 
        sudo snap install obs-studio &> /dev/null
    fi
}

install_gimp() {
    echo "Instalando o GIMP..."
    sudo apt install gimp &> /dev/null
}

install_docker() {
    echo "Instalando o Docker..."

    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg &> /dev/null; done

    sudo apt-get update -y &> /dev/null
    sudo install -m 0755 -d /etc/apt/keyrings &> /dev/null
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc &> /dev/null
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update -y &> /dev/null
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y &> /dev/null

    current_user=$(whoami)
    sudo usermod -aG docker $current_user
}

install_google_chrome() {
    echo "Instalando o Google Chrome..."
    cd ~/Downloads
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &> /dev/null
    sudo dpkg -i google-chrome-stable_current_amd64.deb &> /dev/null
    sudo apt update -y &> /dev/null
    sudo apt-get install -f -y &> /dev/null
}

install_java_jdk17() {
    echo "Instalando o Java JDK 17..."
    sudo apt install openjdk-17-jdk -y &> /dev/null
}


#----------------------------------------------------------------------------------------------------


echo -e "Iniciando script de instalação"

echo -e "\nAtualizando pacotes e repositorios do sistema..."
sudo apt update -y &> /dev/null
sudo apt upgrade -y &> /dev/null

echo -e "\nInstalando utilitários e programas essenciais..."
sudo apt install curl make git vim ca-certificates -y &> /dev/null

echo -e "\nConfigurações do git:"
read -p " * Digite seu user.name do git: " git_user_name
read -p " * Digite seu user.email do git: " git_user_email
git config --global user.name $git_user_name
git config --global user.email $git_user_email
git config --global core.editor vim

echo -e "\nEscolha os programas que deseja instalar (pressione Enter para 's' ou digite (s/n))"

# Discord
while true; do
    read -p " * Deseja instalar o Discord? (s/n): " discord
    discord=$(echo "$discord" | tr '[:upper:]' '[:lower:]')

    if [[ -z "$discord" || "$discord" == "s" || "$discord" == "n" ]]; then
        break 
    else
        echo "Opção inválida. (pressione Enter para 's' ou digite (s/n))"
    fi
done

# VLC
while true; do
    read -p " * Deseja instalar o VLC? (s/n): " vlc
    vlc=$(echo "$vlc" | tr '[:upper:]' '[:lower:]')

    if [[ -z "$vlc" || "$vlc" == "s" || "$vlc" == "n" ]]; then
        break 
    else
        echo "Opção inválida. (pressione Enter para 's' ou digite (s/n))"
    fi
done

# Slack
while true; do
    read -p " * Deseja instalar o Slack? (s/n): " slack
    slack=$(echo "$slack" | tr '[:upper:]' '[:lower:]')

    if [[ -z "$slack" || "$slack" == "s" || "$slack" == "n" ]]; then
        break 
    else
        echo "Opção inválida. (pressione Enter para 's' ou digite (s/n))"
    fi
done

# VS Code
while true; do
    read -p " * Deseja instalar o VS Code? (s/n): " vs_code
    vs_code=$(echo "$vs_code" | tr '[:upper:]' '[:lower:]')

    if [[ -z "$vs_code" || "$vs_code" == "s" || "$vs_code" == "n" ]]; then
        break 
    else
        echo "Opção inválida. (pressione Enter para 's' ou digite (s/n))"
    fi
done

# Mattermost
while true; do
    read -p " * Deseja instalar o Mattermost? (s/n): " mattermost
    mattermost=$(echo "$mattermost" | tr '[:upper:]' '[:lower:]')

    if [[ -z "$mattermost" || "$mattermost" == "s" || "$mattermost" == "n" ]]; then
        break 
    else
        echo "Opção inválida. (pressione Enter para 's' ou digite (s/n))"
    fi
done

# OBS Studio
while true; do
    read -p " * Deseja instalar o OBS Studio? (s/n): " obs_studio
    obs_studio=$(echo "$obs_studio" | tr '[:upper:]' '[:lower:]')

    if [[ -z "$obs_studio" || "$obs_studio" == "s" || "$obs_studio" == "n" ]]; then
        break 
    else
        echo "Opção inválida. (pressione Enter para 's' ou digite (s/n))"
    fi
done

# GIMP
while true; do
    read -p " * Deseja instalar o GIMP? (s/n): " gimp
    gimp=$(echo "$gimp" | tr '[:upper:]' '[:lower:]')

    if [[ -z "$gimp" || "$gimp" == "s" || "$gimp" == "n" ]]; then
        break 
    else
        echo "Opção inválida. (pressione Enter para 's' ou digite (s/n))"
    fi
done

# Docker
while true; do
    read -p " * Deseja instalar o Docker? (s/n): " docker
    docker=$(echo "$docker" | tr '[:upper:]' '[:lower:]')

    if [[ -z "$docker" || "$docker" == "s" || "$docker" == "n" ]]; then
        break 
    else
        echo "Opção inválida. (pressione Enter para 's' ou digite (s/n))"
    fi
done

# Google Chrome
while true; do
    read -p " * Deseja instalar o Google Chrome? (s/n): " google_chrome
    google_chrome=$(echo "$google_chrome" | tr '[:upper:]' '[:lower:]')

    if [[ -z "$google_chrome" || "$google_chrome" == "s" || "$google_chrome" == "n" ]]; then
        break 
    else
        echo "Opção inválida. (pressione Enter para 's' ou digite (s/n))"
    fi
done

# Java JDK 17
while true; do
    read -p " * Deseja instalar o Java JDK 17? (s/n): " java_jdk17
    java_jdk17=$(echo "$java_jdk17" | tr '[:upper:]' '[:lower:]')

    if [[ -z "$java_jdk17" || "$java_jdk17" == "s" || "$java_jdk17" == "n" ]]; then
        break 
    else
        echo "Opção inválida. (pressione Enter para 's' ou digite (s/n))"
    fi
done




#----------------------------------------------------------------------------------------------------
echo





# Discord
if [[ -z "$discord" || "$discord" == "s" ]]; then
    install_discord 
fi

# VLC
if [[ -z "$vlc" || "$vlc" == "s" ]]; then
    install_vlc 
fi

# Slack
if [[ -z "$slack" || "$slack" == "s" ]]; then
    install_slack 
fi

# VS Code
if [[ -z "$vs_code" || "$vs_code" == "s" ]]; then
    install_vs_code
fi

# Mattermost
if [[ -z "$mattermost" || "$mattermost" == "s" ]]; then
    install_mattermost
fi

# OBS Studio
if [[ -z "$obs_studio" || "$obs_studio" == "s" ]]; then
    install_obs_studio
fi

# GIMP
if [[ -z "$gimp" || "$gimp" == "s" ]]; then
    install_gimp
fi

# Docker
if [[ -z "$docker" || "$docker" == "s" ]]; then
    install_docker
fi

# Google Chrome
if [[ -z "$google_chrome" || "$google_chrome" == "s" ]]; then
    install_google_chrome
fi

# Java JDK 17
if [[ -z "$java_jdk17" || "$java_jdk17" == "s" ]]; then
    install_java_jdk17
fi

echo -e "\nInstalação finalizada."
echo "Você precisará fazer logout e login novamente para que todas as alterações tenham efeito."
