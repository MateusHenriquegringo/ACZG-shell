#!/bin/bash

path="$1"
name="$2"

mkdir -p "$path/$name" && cd "$path/$name" || { echo "Falha ao acessar o diretório"; exit 1; }

echo "Caminho: $path"
echo "Nome do projeto: $name"

touch README.md
chmod +rw README.md
echo "Projeto $name inicializado..." > README.md || { echo "Erro ao criar o README.md"; exit 1; }

git init || { echo "Erro ao inicializar o repositório Git"; exit 1; }

git add README.md || { echo "Erro ao adicionar o arquivo README.md ao Git"; exit 1; }
git commit -m "First commit - Repositório configurado" || { echo "Erro ao fazer o commit"; exit 1; }

echo "Projeto $name inicializado com sucesso em $path/$name"
