#!/bin/bash
# Recebe dois argumentos da linha de comando
args=("$@")

# Define um caminho base para um diretório
folder="/mnt/AdditionalDisk/coding/just_studying/advent-of-code/"

# Para cada argumento recebido, adiciona-o ao caminho base como um subdiretório
for arg in "${args[@]}"
do
    if ! [ "$arg" == "" ]; then
        folder+="$arg/"
        # Verifica se o diretório resultante existe. Se não existir, cria o diretório.
        if [ ! -d "$folder" ]; then
            mkdir -p "$folder"
        fi
    fi
done

# Muda para o diretório resultante
echo "$folder"

: << 'COMMENT'

# adicionar esta função ao arquiv ~/.bashrc
advent_of_code() {
    mydir=$(source ~/.config/nvim/advent-of-code.sh "$@")
    cd "$mydir"
    nvim .
}

COMMENT
