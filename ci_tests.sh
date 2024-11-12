#!/bin/bash
cron_period="$1"
project_dir="$2"

cron_period="${cron_period:-"0 0 * * *"}"  # Default é rodar a cada dia à meia-noite
project_dir="${project_dir:-"$HOME/Documents"}"
log_file="/home/mateus/Documents/acelera/scripts/gradle_tests.log"

if [[ ! -d "$project_dir" ]]; then
    echo "Diretório do projeto não encontrado: $project_dir"
    exit 1
fi

(crontab -l 2>/dev/null; echo "$cron_period $SCRIPTS_DIR/tests.sh $project_dir") | crontab -
echo "Cron Job configurado com sucesso para: $cron_period"
