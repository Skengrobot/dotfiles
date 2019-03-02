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

# Set manpages to vim.
export MANPAGER="col -b | /usr/local/bin/vim -c 'set ft=man ts=8 nomod nolist nonu' -c 'nnoremap i <nop>' -"

# The future is now
alias clang='/usr/local/bin/clang-3.7'
alias clang++='/usr/local/bin/clang++-3.7'
export CC="clang-3.7"
export CXX="clang++-3.7 -stdlib=libc++"
export CMAKE_CXX_FLAGS="$CMAKE_CXX_FLAGS -I/usr/local/opt/llvm37/lib/llvm-3.7/include/c++/v1"
export LDFLAGS="$LDFLAGS -L/usr/local/opt/llvm37/lib/llvm-3.7/lib"

alias python=/usr/local/bin/python2
#QDKEXT Python path
export PYTHONPATH=$PYTHONPATH:~/gerrit/QDKEXT/:/usr/local/opt/qdk_python/

# Add the swig fork to path
export PATH=/usr/local/opt/python@2/bin:$PATH
export PATH=$PATH:~/gerrit/swig/swig_installation/bin

# Add valgrind to the path
export PATH=/Users/rudi/bin/bin:$PATH

# Run gpg-agent
[ -f ~/.gnupg/gpg-agent.env ] && source ~/.gnupg/gpg-agent.env
if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
  export GPG_AGENT_INFO
else
  eval $(gpg-agent --daemon -q --log-file /tmp/gpg.log ~/.gnupg/gpg-agent.env --pinentry-program /usr/local/bin/pinentry-mac)
fi

export INTEL_NO_CONNECTION_CHECK=1
