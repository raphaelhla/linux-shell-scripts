#!/bin/bash

# Verifica se o Go já está instalado
if ! command -v go &>/dev/null; then
    echo "Instalando o Go (Golang)..."
    # Adiciona o repositório PPA para obter uma versão mais recente, se desejado
    # sudo add-apt-repository ppa:longsleep/golang-backports -y

    # Atualiza a lista de pacotes
    sudo apt update

    # Instala o Go
    sudo apt install -y golang-go

    # Define variáveis de ambiente para o Go
    echo 'export PATH="$PATH:/usr/local/go/bin"' >> ~/.bashrc
    echo 'export GOPATH="$HOME/go"' >> ~/.bashrc
    echo 'export PATH="$PATH:$GOPATH/bin"' >> ~/.bashrc
    source ~/.bashrc

    echo "Go (Golang) foi instalado com sucesso!"
else
    echo "Go (Golang) já está instalado."
fi

