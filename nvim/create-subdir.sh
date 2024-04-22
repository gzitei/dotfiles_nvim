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
fi

cd "$folder"
echo "$pwd"

: << 'COMMENT'

# adicionar esta função ao arquiv ~/.bashrc
name() {
    source ~/.config/nvim/advent-of-code.sh /path/to/your/folder subfolder1 subfolder2 ... subfoldern
    nvim .
}

COMMENT
