
#!/bin/bash


SCRIPTS_DIR="$HOME/Documents/acelera/scripts"
LOG_FILE="$SCRIPTS_DIR/gradle_tests.log"


mkdir -p "$SCRIPTS_DIR"
chmod -R u+rwx $SCRIPTS_DIR

# Criar o arquivo tests.sh
cat << EOF > "$SCRIPTS_DIR/tests.sh"
#!/bin/bash
project_dir="\$1"

if [[ ! -d "\$project_dir" ]]; then
    echo "Diretório do projeto não encontrado: \$project_dir"
    exit 1
fi

cd "\$project_dir" && gradle test >> "$LOG_FILE" 2>&1

if grep -q "BUILD SUCCESSFUL" "$LOG_FILE"; then
    notify-send "Testes Gradle" "Testes executados com sucesso!"
    echo "Testes realizados com sucesso.PipelineTask3" >> "$LOG_FILE"
else
    notify-send "Testes Gradle" "Falha na execução dos testes!"
    echo "Falha na execução dos testes.PipelineTask3" >> "$LOG_FILE"
fi
EOF

cat << EOF > "$SCRIPTS_DIR/initproject.sh"
#!/bin/bash

path="\$1"
name="\$2"

mkdir -p "\$path/\$name" && cd "\$path/\$name" || { echo "Falha ao acessar o diretório"; exit 1; }

echo "Caminho: \$path"
echo "Nome do projeto: \$name"

touch README.md
chmod +rw README.md
echo "Projeto \$name inicializado..." > README.md || { echo "Erro ao criar o README.md"; exit 1; }

git init || { echo "Erro ao inicializar o repositório Git"; exit 1; }

git add README.md || { echo "Erro ao adicionar o arquivo README.md ao Git"; exit 1; }
git commit -m "First commit - Repositório configurado" || { echo "Erro ao fazer o commit"; exit 1; }

echo "Projeto \$name inicializado com sucesso em \$path/\$name"
EOF
# Criar o arquivo aczginit.sh
cat << EOF > "$SCRIPTS_DIR/aczginit.sh"
#!/bin/bash
name="\$1"

git status
git checkout -b "feat-\$name"
git branch -a
EOF

# Criar o arquivo aczgfinish.sh
cat << EOF > "$SCRIPTS_DIR/aczgfinish.sh"
#!/bin/bash
name="\$1"
featureBranch="feat-\$name"

git checkout master
git merge "\$featureBranch"
git branch -d "\$featureBranch"

git push origin --delete "\$featureBranch"

git branch -a
EOF

# Criar o arquivo ci_tests.sh
cat << EOF > "$SCRIPTS_DIR/ci_tests.sh"
#!/bin/bash
cron_period="\$1"
project_dir="\$2"

cron_period="\${cron_period:-"0 0 * * *"}"  # Default é rodar a cada dia à meia-noite
project_dir="\${project_dir:-"\$HOME/Documents"}"
log_file="$LOG_FILE"

if [[ ! -d "\$project_dir" ]]; then
    echo "Diretório do projeto não encontrado: \$project_dir"
    exit 1
fi

(crontab -l 2>/dev/null; echo "\$cron_period \$SCRIPTS_DIR/tests.sh \$project_dir") | crontab -
echo "Cron Job configurado com sucesso para: \$cron_period"
EOF




ALIAS_INITPROJECT="alias initproject='$SCRIPTS_DIR/initproject.sh'"
ALIAS_ACZGINIT="alias aczginit='$SCRIPTS_DIR/aczginit.sh'"
ALIAS_ACZHFINISH="alias aczgfinish='$SCRIPTS_DIR/aczgfinish.sh'"
ALIAS_LINE="alias tests='$SCRIPTS_DIR/tests.sh'"
CRON_ALIAS_LINE="alias citests='$SCRIPTS_DIR/ci_tests.sh'"
VIEW_LOGS_ALIAS_LINE="alias showgradlelogs='$SCRIPTS_DIR/gradle_tests.sh'"

grep -qxF "$ALIAS_INITPROJECT" "$HOME/.bashrc" || echo "$ALIAS_INITPROJECT" >> "$HOME/.bashrc"
grep -qxF "$ALIAS_ACZGINIT" "$HOME/.bashrc" || echo "$ALIAS_ACZGINIT" >> "$HOME/.bashrc"
grep -qxF "$ALIAS_ACZHFINISH" "$HOME/.bashrc" || echo "$ALIAS_ACZHFINISH" >> "$HOME/.bashrc"
grep -qxF "$ALIAS_LINE" "$HOME/.bashrc" || echo "$ALIAS_LINE" >> "$HOME/.bashrc"
grep -qxF "$CRON_ALIAS_LINE" "$HOME/.bashrc" || echo "$CRON_ALIAS_LINE" >> "$HOME/.bashrc"
grep -qxF "$VIEW_LOGS_ALIAS_LINE" "$HOME/.bashrc" || echo "$VIEW_LOGS_ALIAS_LINE" >> "$HOME/.bashrc"

mkdir -p "$(dirname "$LOG_FILE")"
touch "$LOG_FILE"
chmod 666 "$LOG_FILE"

chmod -R u+wx "$SCRIPTS_DIR"

source "$HOME/.bashrc"

echo "Configuração do ambiente concluída! Aliases e scripts prontos para uso."

