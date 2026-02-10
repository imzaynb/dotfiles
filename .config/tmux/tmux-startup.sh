#!/bin/bash

SESSION="home"

if [[ ! "$TMUX" ]]; then
	tmux has-session -t $SESSION 2>/dev/null

	if [ $? != 0 ]; then
		tmux new-session -d -s $SESSION -n "todo"
		tmux send-keys -t $SESSION:0 "nvim ~/documents/life/todo.txt" C-m
	fi
fi

