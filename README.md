# Acelera - Scripts de Automação para Projetos de Software

Este projeto contém um conjunto de scripts para automatizar tarefas comuns em projetos de software, como inicialização de projetos, gerenciamento de branches no Git, execução de testes Gradle e configuração de cron jobs para execução automatizada de testes.

## `configure_dependencies.sh` - Script de Configuração Automatizada

O `configure_dependencies.sh` é um script de configuração automatizada para preparar o ambiente de desenvolvimento de maneira rápida e eficiente. Sua principal função é criar uma estrutura de diretórios, gerar scripts utilitários e configurar aliases no terminal, facilitando a execução de tarefas rotineiras durante o desenvolvimento de software, como a inicialização de novos projetos, o gerenciamento de branches no Git, a execução de testes Gradle e a automação de tarefas através de cron jobs.

### O que o `configure_dependencies.sh` faz:

#### 1. Criação do Diretório de Scripts
O script cria um diretório para armazenar todos os scripts utilitários (no caminho `$HOME/Documents/acelera/scripts`), garantindo que esse diretório tenha as permissões adequadas para leitura, gravação e execução.

#### 2. Criação dos Scripts
O script gera vários arquivos de scripts utilitários em Bash. Cada um desses scripts automatiza tarefas comuns no processo de desenvolvimento:

- **`initproject.sh`**: Inicializa um novo projeto criando um diretório com o nome do projeto, configurando um repositório Git e criando um arquivo `README.md`.
- **`aczginit.sh`**: Cria um novo branch de feature no Git e faz o checkout para esse branch.
- **`aczgfinish.sh`**: Realiza o merge de um branch de feature com o `master`, deleta o branch localmente e remotamente.
- **`tests.sh`**: Executa os testes Gradle em um projeto, registrando os resultados em um arquivo de log e notificando sobre o sucesso ou falha dos testes.
- **`ci_tests.sh`**: Configura um cron job para rodar o script de testes Gradle periodicamente, permitindo a execução automatizada de testes em horários programados.

#### 3. Configuração dos Aliases
O script adiciona aliases no arquivo `.bashrc` do usuário, permitindo que esses scripts sejam executados de maneira simples diretamente no terminal, usando comandos curtos. Os aliases incluem:

- **`initproject`**: Para inicializar um novo projeto.
- **`aczginit`**: Para criar um novo branch de feature.
- **`aczgfinish`**: Para finalizar o branch de feature.
- **`tests`**: Para executar os testes Gradle.
- **`citests`**: Para configurar um cron job para rodar os testes automaticamente.
- **`showgradlelogs`**: Para exibir os logs dos testes Gradle.

#### 4. Configuração do Arquivo de Log
O script cria o arquivo de log para armazenar os resultados dos testes Gradle (`gradle_tests.log`) e define permissões para que o arquivo possa ser acessado e modificado conforme necessário.

#### 5. Recarregamento do `.bashrc`
Após adicionar os aliases, o script recarrega o arquivo `.bashrc` para garantir que os aliases estejam disponíveis na sessão do terminal imediatamente, sem a necessidade de reiniciar o terminal.

### Funcionalidades

1. **`initproject`**: Cria e inicializa um novo projeto com repositório Git e um arquivo `README.md`.
2. **`aczginit`**: Cria um novo branch de feature no Git e realiza checkout para ele.
3. **`aczgfinish`**: Finaliza o branch de feature, fazendo merge com o `master` e removendo o branch.
4. **`tests`**: Executa testes Gradle em um projeto e notifica sobre o sucesso ou falha.
5. **`citests`**: Configura um cron job para rodar testes Gradle (utilizando o tests) periodicamente (por padrão, a cada meia-noite).
6. **`showgradlelogs`**: Exibe os logs dos testes Gradle.


### Usando os Scripts

#### Criar um novo branch de feature

```bash 
aczginit nome_da_feature
```
Este script cria um novo branch de feature (por exemplo, feat-nome_da_feature) e realiza o checkout para ele. Ideal para iniciar novas funcionalidades em um projeto.

#### Finalizar o branch de feature

```bash
aczgfinish nome_da_feature
```
Este script realiza o merge do branch de feature com a branch master, deleta o branch de feature localmente e remotamente do repositório. Ideal para finalizar o trabalho em uma feature e integrá-la ao branch principal.


#### Executar os testes Gradle

```bash 
tests /caminho/do/projeto
```

Este script executa os testes Gradle no diretório do projeto especificado. Após a execução, ele notifica o usuário sobre o sucesso ou falha dos testes, e os resultados são registrados no arquivo de log.
Configurar um cron job para rodar os testes automaticamente

```bash 
citests "0 0 * * *" /caminho/do/projeto
```
Este script configura um cron job para executar os testes automaticamente em um horário determinado. O formato padrão é 0 0 * * *, que executa os testes todos os dias à meia-noite. Você pode alterar o horário conforme necessário.

#### Exibir os logs dos testes 

```bash
showgradlelogs
```
Este script exibe os logs gerados durante a execução dos testes Gradle, permitindo que você veja os detalhes e resultados dos testes que foram realizados.


