autoload -U compinit
compinit

# Parses the ssh known_hosts file for previously visited hosts, then offers
# them for completions in ssh, scp and sftp commands.

local knownhosts
knownhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} ) 
zstyle ':completion:*:(ssh|scp|sftp):*' hosts $knownhosts
git_diff_color() {
  changes=$(git status)
  case $changes in
    *Untracked*)
      echo "%{$fg[red]%}"
      return
    ;;;
    
    *updated*)
      echo "%{$fg[red]%}"
      return
    ;;;
    
    *committed*)
      echo "%{$fg[green]%}"
      return
    ;;;
  esac
}

git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "($(git_diff_color)${ref#refs/heads/}$(host_prompt_color))"
}

autoload -U colors
colors

setopt prompt_subst

# If we're running in an ssh session, use a different colour 
# than if we're on a local machine

host_prompt_color() {
  case ${SSH_CLIENT} in 
    [0-9]*)
      echo "%{$fg[yellow]%}"
    ;;;
    
    *)
      echo "%{$fg[blue]%}"
    ;;;
  esac
}

export PROMPT=$'$(host_prompt_color)%n@%m:%~$(git_prompt_info)$ %{$fg[white]%}'