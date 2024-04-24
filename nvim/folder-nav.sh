#!/bin/bash
args="$@"
dir_path="$1"
folder="$dir_path"
italic="\033[3m"
normal="\033[0m"
bold="\033[1m"
basef="$(basename "$dir_path")"
move_cursor() {
    echo -en "\t"
}
# Lista os subdiretórios na pasta especificada
echo -e ">> Your options in ${bold}$basef${normal}:\n"
echo -e "\t${bold}0${normal}. Create new folder"
i=1
subdirs=()
for subdir in "$dir_path"*/; do
    if [ -d "$subdir" ]; then
        echo -e "\t${bold}$i${normal}. $(basename "$subdir")"
        subdirs+=("$subdir")
        ((i++))
    fi
done

# Solicita ao usuário que escolha um projeto
echo -e "\n>> Choose your folder number:"
echo -e "${italic}$(tput dim)Leave it blank to go to main folder.${normal}\n"
move_cursor
read selection

if ! [[ "$selection" =~ ^[0-9]+$ ]]; then
    echo -e "\n>> Invalid selection!\n"
    return 2
fi
# Verifica se o usuário escolheu criar um novo projeto
if [ "$selection" -eq 0 ]; then
    # Solicita um nome para o novo projeto
    echo -e "\n>> Name your folder:\n"
    read name
    folder="$dir_path$name"
    # Cria um novo diretório para o projeto
    mkdir "$folder"
    echo -e "\n$(tput dim)>> Folder created${normal}\n"
    # Acessa o diretório do novo projeto
    cd "$folder"
elif ! [ -z "$selection" ]; then
    # Calcula o índice do diretório escolhido
    ((index=selection-1))
    # Acessa o diretório escolhido
    folder="${subdirs[$index]}"
    cd "$folder"
else
    cd "$folder"
fi
echo ""
echo -e "${italic}Ok, navigating to ${bold}$folder${italic}${normal}...${normal}"
# Retorna o diretório atual para o shell
echo ""
echo -e "$(tput dim)>> Current directory: $(pwd)${normal}"
echo "$pwd"

:<< COMMENT
add this to ~/.bashrc
name() {
    source ~/.config/nvim/folder-nav.sh /path/to/desired/folder/ || exit
}
COMMENT
