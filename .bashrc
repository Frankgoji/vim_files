# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


##### PERSONAL CHANGES #####

# Make it so that the directory colors are readable
eval `dircolors ~/.dircolors`

# Add the dv and sshf script to the path
PATH=$PATH:~/Documents/personal_projects/bookmarklets/vid:~/Documents/personal_projects/sshf

# Add the queue environment variable
export QUEUE="https://www.youtube.com/playlist?list=PLQMsPtgISEJomjGvkY8DbAV-TILxE7rUc"

# maps xdg-open to open. Makes things more convenient.
function open {
    xdg-open $@
}

# does a quick git commit with the timestamp
function git_time {
    git commit -am "Commit on $(date)"
}

# minimalistic error function. Prints an error message before exiting with
# status 1.
function error {
    echo "$@" 1>&2
    exit 1
}

# renames filename(s) to get rid of spaces
function nospace {
    exit 0
}

# tests nospace
function testnospace {
    exit 0
}

# My personal Bash prompt
function prompt_command {
    prev=$?
    PS1="\[\033[1;33m\][\t] \[\033[1;32m\]\u\[\033[0m\]@\[\033[1;34m\]\h:\[\033[0;33m\]\w\[\033[0m\]\n"
    PS1+="$(git_prompt)"
    if [[ prev -eq 0 ]]; then
        PS1+="\[\033[1;32m\]:)"
    else
        PS1+="\[\033[0;31m\]:("
    fi
    PS1+=" \[\033[0m\]\$ "
}

# returns git prompt
function git_prompt {
    gitstat=$(git status 2>&1)
    if [[ $(echo $gitstat | grep "fatal: Not a git repository") ]]; then
        echo ""
    else
        gitmessage=""
        gitmessage+="\[\033[1;37m\][GIT:"
        branch=$(echo $gitstat | sed "s/On branch //" | sed "s/ .*//")
        gitmessage+="$branch "
        if [[ $(echo $gitstat | grep "Untracked files:") ]]; then
            gitmessage+="\[\033[1;31m\]❌ (untracked files)"
        elif [[ $(echo $gitstat | grep "Changes to be committed:") ]]; then
            gitmessage+="\[\033[1;31m\]❌ (commit changes)"
        elif [[ $(echo $gitstat| grep "Changes not staged for commit:") ]]; then
            gitmessage+="\[\033[1;31m\]❌ (commit changes)"
        else
            gitmessage+="\[\033[0;32m\]✓"
        fi
        gitmessage+="\[\033[1;37m\]] "
        echo "$gitmessage"
    fi
}

PROMPT_COMMAND=prompt_command

export TERM=xterm-256color

# added by Anaconda3 4.1.1 installer
export PATH="/home/franklin/anaconda3/bin:$PATH"
