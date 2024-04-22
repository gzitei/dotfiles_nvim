#!/bin/bash

dir_path="/mnt/AdditionalDisk/coding/projects/"
folder=""
# Lista os subdiretórios na pasta especificada
echo ">> Your projects:"
echo -e "\t0. Create new project"
i=1
subdirs=()
for subdir in "$dir_path"*/; do
    if [ -d "$subdir" ]; then
        echo -e "\t$i. $(basename "$subdir")"
        subdirs+=("$subdir")
        ((i++))
    fi
done

# Solicita ao usuário que escolha um projeto
echo ">> Choose your project number:"
read selection

# Verifica se o usuário escolheu criar um novo projeto
if [ "$selection" -eq 0 ]; then
    # Solicita um nome para o novo projeto
    echo ">> Name your project:"
    read name
    # Cria um novo diretório para o projeto
    mkdir "$dir_path$name"
    echo ">> Project folder created"
    # Acessa o diretório do novo projeto
    folder="$dir_path$name"
    # Inicializa o repositório Git
    git init
    git config init.defaultBranch main
    git checkout -b dev
    touch .gitignore
    git add .
    git commit -m 'batman'
else
    # Calcula o índice do diretório escolhido
    ((index=selection-1))
    # Acessa o diretório escolhido
    folder="${subdirs[$index]}"
fi

echo ">> Current directory: $(pwd)"
# Retorna o diretório atual para o shell
cd "$folder"
echo "$pwd"

:<< COMMENT
add this to ~/.bashrc
coding() {
    source ~/.config/nvim/proj.sh || exit
}
COMMENT
