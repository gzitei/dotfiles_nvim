#!/bin/bash
args="$@"
dir_path="$1"
folder=""
# Lista os subdiretórios na pasta especificada
echo ">> Your folders:"
echo -e "\t0. Create new folder"
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
echo ">> Choose your folder number:"
read selection

# Verifica se o usuário escolheu criar um novo projeto
if [ "$selection" -eq 0 ]; then
    # Solicita um nome para o novo projeto
    echo ">> Name your folder:"
    read name
    # Cria um novo diretório para o projeto
    mkdir "$dir_path$name"
    echo ">> Folder created"
    # Acessa o diretório do novo projeto
    cd "$dir_path$name"
else
    # Calcula o índice do diretório escolhido
    ((index=selection-1))
    # Acessa o diretório escolhido
    cd "${subdirs[$index]}"
fi

# Retorna o diretório atual para o shell
echo ">> Current directory: $(pwd)"
echo "$pwd"

:<< COMMENT
add this to ~/.bashrc
name() {
    source ~/.config/nvim/folder-nav.sh /path/to/desired/folder/ || exit
}
COMMENT
