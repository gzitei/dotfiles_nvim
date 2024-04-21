#!/bin/bash

dir_path="/mnt/AdditionalDisk/coding/projects/"

# Lista os subdiretórios na pasta especificada
echo "Projetos:"
echo "0. Criar novo projeto"
i=1
subdirs=()
for subdir in "$dir_path"*/; do
    if [ -d "$subdir" ]; then
        echo "$i. $(basename "$subdir")"
        subdirs+=("$subdir")
        ((i++))
    fi
done

# Solicita ao usuário que escolha um projeto
echo "Escolha o projeto:"
read selection

# Verifica se o usuário escolheu criar um novo projeto
if [ "$selection" -eq 0 ]; then
    # Solicita um nome para o novo projeto
    echo "Nome do projeto:"
    read name
    # Cria um novo diretório para o projeto
    mkdir "$dir_path$name"
    # Acessa o diretório do novo projeto
    cd "$dir_path$name"
    # Inicializa o repositório Git
    git init
    git config init.defaultBranch main
    git checkout -b dev
    touch .gitignore
    git add .
else
    # Calcula o índice do diretório escolhido
    ((index=selection-1))
    # Acessa o diretório escolhido
    cd "${subdirs[$index]}"
fi

# Retorna o diretório atual para o shell
echo "$(pwd)"

:<< COMMENT
add this to ~/.bashrc
coding() {
    source ~/.config/nvim/proj.sh || exit
}
COMMENT
