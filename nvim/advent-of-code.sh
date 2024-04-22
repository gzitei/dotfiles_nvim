#!/bin/bash
folder="/mnt/AdditionalDisk/coding/just_studying/advent-of-code/"
array=("year" "day" "part")
for s in "${array[@]}";
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
advent_of_code() {
    mydir=$(source ~/.config/nvim/advent-of-code.sh "$@")
    cd "$mydir"
    nvim .
}

COMMENT
