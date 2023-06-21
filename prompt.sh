#!/bin/bash

# Prompt configuration
c_red='0;31m'
c_green='0;32m'
c_blue='0;34m'
c_lt_grey='0;37m'
c_reset='0m'

__prompt_color()
{
  # Use git colors if we have a .git directory
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    if git diff --quiet 2>/dev/null >&2
    then
      echo $c_green
    else
      echo $c_red
    fi
    return 0
  fi

  # Use svn colors if we have a .svn directory
  if [ -d .svn ]
  then
    svnstatusoutput="`svn status 2>/dev/null | grep -v '^\?'`"
    if [ -z "$svnstatusoutput" ]
    then
      echo $c_green
    else
      echo $c_red
    fi
    return 0
  fi

  echo $c_reset
  return 0
}

__prompt_info()
{
  # Emit the git branch if we have a .git directory
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    gitver="$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')"
    echo -e "[${gitver}] "
    return 0
  fi

  # Emit the svn revision if we have a .svn directory
  if [ -d .svn ]
  then
    svnrev=$(svn info 2>/dev/null | grep '^Revision' | sed -e 's/^[^:]*: *//g')
    if [ -n "$svnrev" ]
    then
      echo -e "(r${svnrev}) "
    fi
    return 0
  fi

}

if [ "`type __drush_ps1 2> /dev/null`" == "" ] ; then
  __drush_ps1() {
    return 0
  }
fi

if [ "x$TERM" != "xcygwin" ] ; then
  HOSTNAME=$(hostname -s)
  if [ "$HOSTNAME" == "vps" ] || [ "$HOSTNAME" == "server" ] ; then
    HOSTNAME=$(hostname -f | sed -e 's/^[^.]*\.//' -e 's/\..*//')
  fi
  PROMPT_COMMAND='_p=$(__prompt_info)'
  PS1='${_p:0:1}\[\e[$(__prompt_color)\]${_p:1:$((${#_p}-3))}\[\e[$c_reset\]${_p#"${_p%??}"}\[\e[$c_blue\]\u@'"$HOSTNAME"':\w\[\e[$c_reset\]\[\e[$c_green\]$(__drush_ps1)\[\e[$c_reset\]$ '
fi
