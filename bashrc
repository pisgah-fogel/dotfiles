#
# ~/.bashrc
#

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth # No duplicate and no line starting by ' ' in history


shopt -s histappend # Append to history, no overwrite

shopt -s autocd # cd to a directory

shopt -s cdspell # cd to a directory even if the spelling is wrong

shopt -s checkjobs # Do not exit is a job is running

shopt -s dirspell # Allow missplelling in directory autocompletion

shopt -s histverify # Edit history search before running

shopt -s no_empty_cmd_completion # Do not attempt completion on empty lines

shopt -s nocaseglob # case-insensitive Filename completion

shopt -s checkwinsize # Check window size and update LINES and Columns

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
else
	color_prompt=
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Bash completion if not already enabled
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\[\e[1m[\w]\]\n\[\e[1m\] \$ > \[\e[0m\]'

if [ -e ~/.bashrc.aliases ] ; then
   source ~/.bashrc.aliases
fi
BROWSER=vivaldi
EDITO=vim

alias sm="emacsclient -nw -s spacemacs"
alias smgui="emacsclient -nc -s spacemacs"
alias vi="vim"

if [ -e "$HOME/.local/bin" ]
then
	export PATH="$PATH:$HOME/.local/bin"
	. "$HOME/.cargo/env"
fi
