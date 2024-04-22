#!/bin/bash
args="$@"
folder="$1"
shift
for s in "$@";
do
    echo ">> Which $s?"
    read value
    if ! [ -z "$value" ]; then
        folder+="$s-$value/"
    else
        break
    fi
done

if ! [ -d "$folder" ]; then
    mkdir -p "$folder"
    echo ">> Folder created"
fi

cd "$folder"
echo ">> Current directory: $(pwd)"
echo "$pwd"

: << 'COMMENT'

# adicionar esta função ao arquiv ~/.bashrc
name() {
    source ~/.config/nvim/create-subdir.sh /path/to/your/folder/ subfolder1 subfolder2 ... subfolderN
    nvim .
}

COMMENT
