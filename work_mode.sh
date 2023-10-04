#!/bin/bash

# Verifica se o Google Chrome está instalado
if ! command -v google-chrome &>/dev/null; then
    echo "Google Chrome não está instalado. Por favor, instale-o primeiro."
    exit 1
fi

# Abre o Spotify
spotify &

# Espera um pouco para dar tempo ao Spotify de abrir
sleep 5

# Abre o Google Chrome com duas abas, sendo uma delas o seu email
google-chrome &
google-chrome "https://mail.google.com" &

