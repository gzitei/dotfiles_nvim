#!/bin/bash
arg="$1"
if ! [[ "$arg" == "me" ]]; then
    dir=$(tmux display-message -p -t -1 '#{pane_current_path}')
    if [[ "$dir" == "$PWD" ]]; then
        echo -e "\nAlready in folder $(tput bold)$(basename "$dir")$(tput sgr0)...\n"
    else
        echo -e "\nOk, navigating to $(tput bold)$(basename "$dir")$(tput sgr0)...\n"
        tmux select-pane -t -1 
        cd "$dir"
        tmux select-pane -t -1 
    fi
else
    if ! [ $(tmux list-window | awk -F'[()]' '{print $2}' | tr -d ' panes') -gt 1 ]; then
        tmux split-window -v -p 25
        tmux select-pane -t !
    else
        tmux send-keys -t -1 "cd $(tmux display-message -p '#{pane_current_path}') && clear" Enter
    fi
fi

:<<COMMENT
add the function below to .bashrc
follow() {
    args="$@"
    flag="$1"
    source ~/.config/nvim/follow.sh "$flag" || return 2
}
run by typing follow or follow me
COMMENT
