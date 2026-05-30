# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias vol='pactl set-sink-volume @DEFAULT_SINK@'
alias ls='ls --color=auto'

PS1=' \$ '

PATH="$PATH:$HOME/.local/bin"

export EDITOR="hx"
