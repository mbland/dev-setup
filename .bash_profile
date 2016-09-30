umask 022

PS1="\[\033[01;32m\]\u@\h \[\033[00m\]\[\033[01;34m\]\w\$\[\033[00m\] "
CLICOLOR=true
PAGER=less
EDITOR=vim
LESS="-Rsi"
PATH=$HOME/bin:/usr/local/mbland/bin:/usr/local/bin:$PATH
MANPATH=/usr/local/mbland/share/man:/usr/local/share/man:$MANPATH
export PS1 CLICOLOR PAGER EDITOR LESS PATH MANPATH

alias ls="ls -FA"
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

  new_workdir="$1-$2"
  if /usr/local/share/git-core/contrib/workdir/git-new-workdir\
    "$1" "$new_workdir" "$2"; then
    echo "Created $new_workdir"
  else
    return 1
  fi
}

git-changelog() {
  local last_release_tag="$1"
  local current_release_tag="$2"
  git log --pretty=format:'%h %an <%ae>%n        %s%n' \
    "${last_release_tag}..${current_release_tag}^"
}

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
eval "$(~/src/mbland/mbland-dotfiles/go env dots)"

if [[ -x '~/src/mbland/mbland-dotfiles/go' ]]; then
  eval "$(~/src/mbland/mbland-dotfiles/go env dots)"
fi

if [[ -x '~/src/mike-bland.com/go' ]]; then
  eval "$(~/src/mike-bland.com/go env blog)"
fi

if [[ -r "$HOME/.bash_profile_local" ]]; then
  . "$HOME/.bash_profile_local"
fi
