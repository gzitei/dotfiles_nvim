#!/bin/bash
OLD_IFS=$IFS
IFS=$'\n'
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
echo -e ">> Your options in ${bold}$basef${normal}:\n"
echo -e "\t${bold}0${normal}. Create new folder"
subdirs=()
i=1
for subdir in $(find "$dir_path" -maxdepth 1 -type d | sort); do
    if [[ -d "$subdir" ]] && ! [[ "$(basename "$subdir")" == "$basef" ]]; then
        echo -e "\t${bold}$i${normal}. $(basename "$subdir")"
        ((i++))
        subdirs+=("$subdir")
    fi
done
IFS=$OLD_IFS
echo -e "\n>> Choose your folder number:"
echo -e "${italic}$(tput dim)Leave it blank to go to main folder.${normal}\n"
move_cursor
read selection

# Verifica se o usuário escolheu criar um novo projeto
if [[ -z "$selection" ]]; then
    cd "$folder"
elif ! [[ "$selection" =~ ^[0-9]+$ ]]; then
    echo -e "\n>> Invalid selection!\n"
    return 2
elif [ "$selection" -eq 0 ]; then
    # Solicita um nome para o novo projeto
    echo -e "\n>> Name your folder:\n"
    move_cursor
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
fi
echo ""
echo -e "${italic}Ok, navigating to ${bold}$folder${italic}${normal}...${normal}"
# Retorna o diretório atual para o shell
echo ""
echo -e "$(tput dim)>> Current directory: $(pwd)${normal}\n"

:<< COMMENT
add this to ~/.bashrc
name() {
    source ~/.config/nvim/folder-nav.sh /path/to/desired/folder/ || exit
}
run this by typing the funciton name in terminal
COMMENT
