#!/bin/bash

# Verificar a versão instalada do Node.js
installed_version=$(node -v 2>/dev/null)

if [ -n "$installed_version" ]; then
    echo "Versão do Node.js instalada: $installed_version"
else
    echo "Nenhuma versão do Node.js está instalada."
fi

# Verificar a versão mais recente disponível
latest_version=$(curl -sL https://nodejs.org/dist/latest/SHASUMS256.txt | grep -o 'v[0-9.]*' | tail -n1)

if [ -n "$latest_version" ]; then
    echo "Última versão do Node.js disponível: $latest_version"
else
    echo "Não foi possível verificar a última versão disponível."
fi

# Perguntar se deseja instalar a última versão
read -p "Deseja instalar a última versão do Node.js? (Y/N): " choice

if [ "$choice" == "Y" ] || [ "$choice" == "y" ]; then
    # Instalar a última versão do Node.js
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/nodesource-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/nodesource-archive-keyring.gpg] https://deb.nodesource.com/node_14.x $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/nodesource.list > /dev/null
    echo "deb-src [signed-by=/usr/share/keyrings/nodesource-archive-keyring.gpg] https://deb.nodesource.com/node_14.x $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y nodejs

    echo "Última versão do Node.js instalada."
elif [ "$choice" == "N" ] || [ "$choice" == "n" ]; then
    echo "A instalação da última versão do Node.js foi recusada."
else
    echo "Escolha inválida. Use Y ou N para responder."
fi

