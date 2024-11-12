#!/bin/bash
project_dir="$1"

if [[ ! -d "$project_dir" ]]; then
    echo "Diretório do projeto não encontrado: $project_dir"
    exit 1
fi

cd "$project_dir" && gradle test >> "/home/mateus/Documents/acelera/scripts/gradle_tests.log" 2>&1

if grep -q "BUILD SUCCESSFUL" "/home/mateus/Documents/acelera/scripts/gradle_tests.log"; then
    notify-send "Testes Gradle" "Testes executados com sucesso!"
    echo "Testes realizados com sucesso.PipelineTask3" >> "/home/mateus/Documents/acelera/scripts/gradle_tests.log"
else
    notify-send "Testes Gradle" "Falha na execução dos testes!"
    echo "Falha na execução dos testes.PipelineTask3" >> "/home/mateus/Documents/acelera/scripts/gradle_tests.log"
fi
