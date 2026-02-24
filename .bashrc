# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias vol='pactl set-sink-volume @DEFAULT_SINK@'
alias ls='ls --color=auto'

PS1=' • \u \W \$ '

PATH="$PATH:$HOME/.local/bin"
