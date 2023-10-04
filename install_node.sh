#!/bin/bash

# Verifica se o NVM já está instalado
if ! command -v nvm &>/dev/null; then
    echo "Instalando o Node Version Manager (NVM)..."
    
    # Baixa e instala o NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
    
    # Carrega o NVM no ambiente atual
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # Carrega o NVM no ambiente do shell ao iniciar
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
    
    # Atualiza o ambiente para usar a versão LTS mais recente do Node.js
    nvm install --lts

    echo "Node.js foi instalado com sucesso!"
else
    echo "Node.js e NVM já estão instalados."
fi

