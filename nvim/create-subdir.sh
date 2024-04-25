#!/bin/bash
args="$@"
folder="$1"
shift

italic="\033[3m"
normal="\033[0m"
bold="\033[1m"
basef="$(basename "$folder")"
move_cursor() {
    echo -en "\t"
}
echo -e "Let's navigate to ${bold}$basef${normal}"
echo "You may choose an existing folder or create a new one"
echo -e "$(tput dim)${italic}Use ${bold}-i${normal}${italic}$(tput dim) flag to hide variable in folder name.${normal}"
sub=""
for s in "$@";
do
    echo -e "\n>> Which $s?"
    echo -e "$(tput dim)${italic}Leave empty to go to ${bold}$(basename $folder).${normal}\n"
    move_cursor
    read value flag
    if ! [ -z "$value" ]; then
        if ! [ "$flag" == "-i" ]; then
            sub="$s-$value"
            folder+="$s-$value/"
        else
            sub="$value"
            folder+="$value/"
        fi

        if [ -d "$folder" ]; then
            echo -e "\n$(tput dim)${italic}You chose ${bold}$sub${normal}${italic}$(tput dim), the folder exists.${normal}"
        else
            echo -e "\n$(tput dim)${italic}You chose ${bold}$sub${normal}${italic}$(tput dim), it will be created.${normal}"
        fi
    else
        break
    fi
done
echo -e "\n${italic}Ok, navigating to ${bold}$folder${italic}${normal}...${normal}"

if ! [ -d "$folder" ]; then
    mkdir -p "$folder"
    echo -e "$(tput dim)>> Folder created${normal}"
fi

cd "$folder"
echo -e "$(tput dim)>> Current directory: $(pwd)${normal}"

: << 'COMMENT'

# adicionar esta função ao arquiv ~/.bashrc
name() {
    source /path/to/script/create-subdir.sh /path/to/your/folder/ subfolder1 subfolder2 ... subfolderN
    nvim .
}

COMMENT
