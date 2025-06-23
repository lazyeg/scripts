# ~/.bashrc: executed by bash(1) for non-login shells.

# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
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
xterm-color | *-256color) color_prompt=yes ;;
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

parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PROMPT_COMMAND=build_prompt

build_prompt() {
  EXIT=$?            # save exit code of last command
  red='\[\e[1;31m\]' # colors
  green='\[\e[1;32m\]'
  cyan='\[\e[0;33m\]'
  an='\[\e[91m\]$(parse_git_branch)\[\e[00m\]'
  reset='\[\e[0m\]'
  PS1='${debian_chroot:+($debian_chroot)}' # begin prompt

  if [ $EXIT != 0 ]; then # add arrow color dependent on exit code
    PS1+="$red"
  else
    PS1+="$green"
  fi

  PS1+="→→→$reset $cyan\w $reset$an\\$ " # construct rest of prompt
}

if [ "$color_prompt" = yes ]; then

  PS1="\[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
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

alias ansible29="source ~/.ansible-2.9-env-py38/bin/activate"
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias k=kubectl
alias g8=~/scripts/gcp.k8.sh
alias ss=~/scripts/ssh-connect.sh
alias kns='kubectl config set-context --current --namespace '
## Setting nats command
alias natsprod='nats --nkey=~/.nkey/racer-user.nkey --server=nats://prod-nats.letron.site:4222'
alias natsuat='nats --nkey=~/.nkey/racer-user.nkey --server=nats://uat-nats.letron.site:4222'

{
  eval "$(ssh-agent -s)"
  ssh-add -A
} &>/dev/null
# Set variables in .bashrc file

# don't forget to change your path correctly!

export GOPATH=$HOME/go
export GOROOT=/usr/local/go/
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH="/usr/local/opt/helm@2/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/Cellar/python@3.8/3.8.19/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
if [ -f ~/.npm.env ]; then
  source ~/.npm.env
fi
if [ -f ~/.ginpm.env ]; then
  source ~/.ginpm.env
fi
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

# 自動補全集群和區域
_k8s_contexts_completions() {
  local cur opts
  cur="${COMP_WORDS[COMP_CWORD]}"
  opts="other-sportcms-kq5L mh-aolong mh-letron mh-letron-uat mh-other-sportcms-bbg mh-vogue sportscms-hb get-contexts list ssh status"
  COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
}

#_k8s_contexts_completions()
#{
#  local cur opts
#  cur="${COMP_WORDS[COMP_CWORD]}"
#  opts="sit uat uat-v2 uat-v2-infra prod prod-infra prod-devops prod-v2 pri-v2 p2sp cdn-uat cdn-prod get-contexts list ssh status"
#  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
#}

# 将补全功能与脚本关联
complete -F _k8s_contexts_completions g8

# 为 kns 启用命名空间自动补全
_kns_complete() {
  local cur prev
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"

  # 使用 kubectl 获取命名空间列表并补全
  if [[ ${prev} == "kns" ]]; then
    COMPREPLY=($(compgen -W "$(kubectl get namespaces -o jsonpath='{.items[*].metadata.name}')" -- ${cur}))
  fi
}

# 绑定 kns 别名的自动补全函数
complete -F _kns_complete kns
