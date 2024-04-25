#!/bin/bash
dir=$(tmux display-message -p -t ! '#{pane_current_path}')

if [[ "$dir" == "$PWD" ]]; then
    echo -e "\nAlready in folder $(tput bold)$(basename "$dir")$(tput sgr0)...\n"
else
    echo -e "\nOk, navigating to $(tput bold)$(basename "$dir")$(tput sgr0)...\n"
    cd "$dir"
fi

:<<COMMENT
add the function below to .bashrc
follow() {
    source path/to/scritp/follow.sh
}
run by typing follow 
COMMENT
