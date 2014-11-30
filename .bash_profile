umask 022

PS1="\[\033[01;32m\]\u@\h \[\033[00m\]\[\033[01;34m\]\w\$\[\033[00m\] "
CLICOLOR=true
PAGER=less
EDITOR=vim
LESS="-Rsi"
RBENV_ROOT=/usr/local/var/rbenv
export PS1 CLICOLOR PAGER EDITOR LESS RBENV_ROOT

alias ls="ls -FA"
MANPATH=

alias pcpu='ps -eo pid,uid,pcpu,command | sort -rk 3'
alias hostkey='ssh-keygen -l -f /etc/ssh_host_rsa_key'

# Creates a branch-specific git working directory in the same directory as the
# original repository.
git-new-workdir() {
  if test $# -ne 2; then
    echo "Usage: $FUNCNAME <git repo> <branch name>"
    return 1
  elif test ! -d $1; then
    echo "$1 does not exist"
    return 1
  fi

  pushd $1 > /dev/null
  parent_branch="$(git branch | grep '^\*' | sed 's/^..//')"
  if ! $(git branch | sed 's/^..//' | grep -q "^${2}$"); then
    echo "Creating branch \"${2}\" from \"${parent_branch}\""
    git branch "${2}" "${parent_branch}"
  fi
  popd > /dev/null

  new_workdir=$1-${2}
  if /usr/local/share/git-core/contrib/workdir/git-new-workdir\
    $1 $new_workdir ${2}; then
    echo "Created $new_workdir"
  else
    return 1
  fi
}

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
