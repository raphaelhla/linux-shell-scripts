#!/bin/bash

# Verifica se o Node já está instalado
if ! command -v node &>/dev/null; then
    echo "Instalando o NodeJs e o NPM..."
    
    sudo apt install -y nodejs npm

    echo "Node.js foi instalado com sucesso!"
else
    echo "Node.js e NPM já estão instalados."
fi

