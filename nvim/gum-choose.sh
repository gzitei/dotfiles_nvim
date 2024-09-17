#!/bin/bash

gum_choose_subdir() {
    local parent_dir="$1"
    local subdirs=()
    local chosen_dir

    # Listar subdiretórios
    while IFS= read -r dir; do
        subdirs+=("$dir")
    done < <(find "$parent_dir" -maxdepth 1 -type d -not -path "$parent_dir" -printf "%P\n" | sort)

    # Usar gum para escolher
    chosen_dir=$(printf '%s\n' "${subdirs[@]}" | gum choose --limit 1)

    # Verificar se uma seleção foi feita
    if [ -z "$chosen_dir" ]; then
        echo ""
    else
        echo "$parent_dir/$chosen_dir"
    fi
}

# Verificar se um argumento foi fornecido
if [ $# -eq 0 ]; then
    echo "Por favor, forneça um diretório como argumento."
    exit 1
fi

# Primeira seleção
first_choice=$(gum_choose_subdir "$1")

if [ -z "$first_choice" ]; then
    echo "Nenhuma seleção feita. Saindo."
    exit 1
fi

# Segunda seleção
second_choice=$(gum_choose_subdir "$first_choice")

if [ -z "$second_choice" ]; then
    echo "Nenhuma segunda seleção feita. Saindo."
    exit 1
fi

# Mudar para o diretório escolhido
cd "$second_choice" && nvim -c Alpha .

# Executar um novo shell para manter a mudança de diretório
exec $SHELL
