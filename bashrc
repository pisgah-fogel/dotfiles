#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\[\e[1m[\w]\]\n\[\e[1m\] \$ > \[\e[0m\]'

if [ -e ~/.bashrc.aliases ] ; then
   source ~/.bashrc.aliases
fi
BROWSER=firefox
EDITO=vim

alias sm="emacsclient -nw -s spacemacs"
alias smgui="emacsclient -nc -s spacemacs"
alias vi="nvim"
alias vim="nvim"
