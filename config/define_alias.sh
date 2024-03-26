#!/bin/bash

# Verifica se o número correto de argumentos foi fornecido
if [ $# -lt 2 ]; then
    echo "Uso: $0 <alias> <comando>"
    exit 1
fi

alias_name=$1
command="$2"

# Define o alias no arquivo de perfil ~/.bashrc
echo "alias $alias_name=\"$command\"" >> ~/.bashrc

# Atualiza as configurações do shell atual
source ~/.bashrc

echo "Alias '$alias_name' definido como '$command'."

