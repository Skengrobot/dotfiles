# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# GIT branch display on prompt
# this will print either nothing or "[<branch>]" or "[<branch>](merge pending)"
print_git_branch() {
  # Locate the root of the git repo.  This might be a little slow.
  # If it causes problems, you can change this to set gitroot to ".",
  # but then it will only show info when in the repo root.
  gitroot=`git rev-parse --show-toplevel 2>/dev/null`
  if [ $? -ne 0 ]; then
    # # Not in a git repo.
    return
  fi
  # Check the current branch.
  if [ -f "$gitroot/.git/HEAD" ]; then
    # # The HEAD file is usually "ref: refs/heads/<branch>", although
    # # in a "detached HEAD" state, it is a raw SHA1 hash.
    sed -e 's,^ref: refs/heads/,,' -e 's/^/[/' -e 's/$/]/' "$gitroot/.git/HEAD" | tr -d '\r\n'
  fi
  # # Check for a pending merge.
  if [ -f "$gitroot/.git/MERGE_HEAD" ]; then
    echo -n '(merge pending)'
  fi
}

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# disable flow control so it plays nicely with Vim Command-T
stty -ixon -ixoff

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
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[0;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]`print_git_branch`\$ '
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

# colours
alias ls='ls -G'
alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias list='ls -lh'

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Aliases

# Custom variables
LD_LIBRARY_PATH=/usr/local/lib/
export LD_LIBRARY_PATH

# 256 colout supprt in terminal
export TERM=xterm-256color
<<<<<<< Updated upstream
=======

# Docker aliases
alias dl='docker run -it -v /Users/rudi/QDK:/QDK quay.io/1qb_information_technologies/qdkdev bash' # login and start the container.                                                                                                                          
alias da='docker attach' # list all images                                                                                                                                                                                                                         
alias di='docker images' # list all images                                                                                                                                                                                                                                
alias dm='docker-machine' # shorthand for docker-machine                                                                                                                                                                                                                   
alias dps='docker ps -a' # list all containers                                                                                                                                                                                                                             
alias drm='docker rm' # remove a container                                                                                                                                                                                                                                 
alias drmi='docker rmi' # remove an image

alias cscope_gen='/usr/local/bin/cscope -b -q -icscope.files'

# Because docker cp is being stubborn
# docker - copy files from the host to a container.                                                                                                                                                                                                                         
# usage:                                                                                                                                                                                                                                                                    
# cd into a folder on host, then issue:                                                                                                                                                                                                                                     
# dcp [container_id|container_name] local_path container_path                                                                                                                                                                                                               
# Example:                                                                                                                                                                                                                                                                  
# $ dcp foo_container ~/.ssh /root/.ssh/.                                                                                                                                                                                                                                   
# Copies all the contents of ~/.ssh from the host machine to the /root/.ssh                                                                                                                                                                                                 
# folder within 'foo_container'                                                                                                                                                                                                                                            
function dcp {                                                                                                                                                                                                                                                             
	if [ -d "$2" ]; then cd "$2"; tar -cv * | docker exec -i "$1" tar x -C "$3"; cd - 1>/dev/null                                                                                                                                                                          
	else cd $(dirname "$2"); tar -cv "$(basename "$2")" | docker exec -i "$1" tar x -C "$3"; cd - 1>/dev/null                                                                                                                                                              
	fi                                                                                                                                                                                                                                                                      
}                                                                                                                                                                                                                                                                           
export -f dcp

# Script to cleanly build QDK
function mk {
    pushd .; cd ~/Documents/scripts/ && ./make_qdk.sh "$1" "$2" ; popd >/dev/null
}
 
function mkall {
    pushd .; cd ~/Documents/scripts/ && ./make_qdk.sh all "$1" "$2" ; popd >/dev/null
} 

# 1QBit proxy setup
function wfh(){
 
    if [ -z "$1" ]
    then
        echo "1Qbit Quantum Tunelling!";
        sudo networksetup -setsocksfirewallproxy "Wi-Fi" 127.0.0.1 12817;
        sudo networksetup -setsocksfirewallproxystate "Wi-Fi" on;
        ssh -D 12817 oneqbit@1qb.it;
    elif [ "$1" = "off" ]
    then
        sudo networksetup -setsocksfirewallproxystate "Wi-Fi" off;
        echo "1Qbit Quantum Tunelling Off!";
    fi
}

# Set manpages to vim.
export MANPAGER="col -b | /usr/local/bin/vim -c 'set ft=man ts=8 nomod nolist nonu' -c 'nnoremap i <nop>' -"

# The future is now
alias clang='/usr/local/bin/clang-3.7'
alias clang++='/usr/local/bin/clang++-3.7'
export CC="clang-3.7"
export CXX="clang++-3.7 -stdlib=libc++"
export CMAKE_CXX_FLAGS="$CMAKE_CXX_FLAGS -I/usr/local/opt/llvm37/lib/llvm-3.7/include/c++/v1"
export LDFLAGS="$LDFLAGS -L/usr/local/opt/llvm37/lib/llvm-3.7/lib"

#QDKEXT Python path
export PYTHONPATH=$PYTHONPATH:~/gerrit/QDKEXT/
>>>>>>> Stashed changes
