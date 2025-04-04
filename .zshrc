############################
# My functions and aliases #
############################

fpath=(~/.shellfuncs $fpath)
autoload -Uz ~/.shellfuncs/*(N)
[[ -f ~/.shell_aliases ]] && source ~/.shell_aliases

####################################################
# Load tools rx will load for when I don't have rx #
####################################################

[[ -v HOMEBREW_PREFIX ]] || { [[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv) }
(( $+functions[rbenv] )) || { command -v rbenv &>/dev/null && eval "$(rbenv init -)" }

###########
# Plugins #
###########

[[ -f ~/nerdfont/i_all.sh ]] && source ~/nerdfont/i_all.sh
source ~/src/github.com/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/src/github.com/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export RIPGREP_CONFIG_PATH=~/.config/rg/config
eval "$(shadowenv init zsh)"
source <(fzf --zsh)
source ~/src/github.com/junegunn/fzf-git.sh/fzf-git.sh
eval "$(atuin init zsh --disable-up-arrow)" # After fzf --zsh to override Ctrl-R

################################
# Vim mode, with cursor change #
################################

function use-block-cursor {
  echo -n '\e[1 q'
}
function use-line-cursor {
  echo -n '\e[5 q'
}
function use-mode-cursor {
  case $KEYMAP in
    vicmd)
      use-block-cursor
      ;;
    *)
      use-line-cursor
      ;;
  esac

  zle reset-prompt
  zle -R
}
bindkey -v
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
    use-mode-cursor
  }
  function zle-line-finish() {
    echoti rmkx
    use-block-cursor
  }
  zle -N zle-line-init
  zle -N zle-line-finish
  zle -N zle-keymap-select use-mode-cursor
fi

################
# Key Bindings #
################

[[ "${terminfo[khome]}" != "" ]] && bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
[[ "${terminfo[kend]}" != "" ]]  && bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line
[[ "${terminfo[kcbt]}" != "" ]]  && bindkey "${terminfo[kcbt]}"  reverse-menu-complete  # [Shift-Tab] - move through the completion menu backwards
[[ "${terminfo[kdch1]}" != "" ]] && bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward

bindkey '^?' backward-delete-char             # [Backspace] - delete backward
bindkey "µ" copy-prev-shell-word              # Alt-m file rename magic
bindkey "˚" history-beginning-search-backward # Alt-K
bindkey "∆" history-beginning-search-forward  # Alt-J

##############################
# Open git remote in browser #
##############################

zle-open-git-remote() {
  local remote="$(git remote -v 2> /dev/null | grep '(fetch)$' | grep -m1 "\thttps://" | awk '{print $2}')";
  if [[ -n "$remote" ]]; then
    open "$remote"
  fi
}
zle -N zle-open-git-remote
bindkey '©' zle-open-git-remote # Alt-G ABC Extended & Canadian English

######################
# Progressive Prompt #
######################

TRAPALRM() {
  if [[ -n "$WIDGET" ]]; then
    zle reset-prompt
  fi
}
function __progressive_prompt_exec_incr() {
  __progressive_prompt_exec_no=$((__progressive_prompt_exec_no+1))
}
precmd_functions+=(__progressive_prompt_exec_incr)
setopt PROMPT_SUBST
PROMPT='$(progressive_prompt $$ $__progressive_prompt_exec_no "╭─
╰─🐙 " prompt)'

#######################
# Completion settings #
#######################

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._- ]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache on
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$(brew --prefix)/share/zsh-completions:$FPATH
fi
autoload -Uz compinit
# The globbing is a little complicated here:
# - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
# - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.
() {
  if [[ $# -gt 0 ]]; then
    compinit
  else
    compinit -C
  fi
} ${ZDOTDIR:-$HOME}/.zcompdump(Nmh+24)

####################################
# Inline eval $(thefuck --alias f) #
####################################

f () {
  TF_PYTHONIOENCODING=$PYTHONIOENCODING;
  export TF_SHELL=zsh;
  export TF_ALIAS=f;
  TF_SHELL_ALIASES=$(alias);
  export TF_SHELL_ALIASES;
  TF_HISTORY="$(fc -ln -10)";
  export TF_HISTORY;
  export PYTHONIOENCODING=utf-8;
  TF_CMD=$(
  thefuck THEFUCK_ARGUMENT_PLACEHOLDER $@
  ) && eval $TF_CMD;
  unset TF_HISTORY;
  export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
  test -n "$TF_CMD" && print -s $TF_CMD
}
