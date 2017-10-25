export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
HISTSIZE=1000000
HISTFILESIZE=2000000

# General tab completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
# git tab completion (homebrew)
if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
    . `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi
# enable autocomplete for g git alias
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \ || complete -o default -o nospace -F _git g

if [[ -f /opt/dev/dev.sh ]]; then source /opt/dev/dev.sh; fi


export MYPS='$(echo -n "${PWD/#$HOME/'"~"'}" | awk -F "/" '"'"'{
if (length($0) > 14 && NF>1) {
  if ((NF>3 || (NF==3 && length($1)>1)) && length($(NF-1)) + length($NF) < 12)
    print "…/" $(NF-1) "/" $NF;
  else if (NF>2 || length($1)>1)
    print "…/" $NF;
  else
    print $0;
}
else print $0;}'"'"')'

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]$(eval "echo ${MYPS}")\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    TERM_TITLE_SET="\[\e]0;\u@\h: \w\a\]"
    PS1="$TERM_TITLE_SET$PS1"
    ;;
*)
    ;;
esac

if [ -d ~/.shellfuncs ]; then
	for FILE in ~/.shellfuncs/*.sh; do
		source $FILE
	done
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi
GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_THEME=Custom


export PATH="$HOME/bin:$PATH"
export PATH="$PATH:$HOME/.pyenv/shims/"
