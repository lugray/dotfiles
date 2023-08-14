###########
# History #
###########

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt appendhistory autocd
setopt HIST_IGNORE_SPACE
HIST_STAMPS="yyyy-mm-dd"

############################
# My functions and aliases #
############################

for FILE in ~/.shellfuncs/*.sh(N); do source $FILE; done
[[ -f ~/.shell_aliases ]] && source ~/.shell_aliases

###########
# Plugins #
###########

[[ -f ~/nerdfont/i_all.sh ]] && source ~/nerdfont/i_all.sh
source ~/src/github.com/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/src/github.com/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
PROMPT='$(progressive_prompt $$ $__progressive_prompt_exec_no "" prompt)'

####################################################
# Load tools rx will load for when I don't have rx #
####################################################

[[ -v HOMEBREW_PREFIX ]] || { [[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv) }
(( $+functions[rbenv] )) || { command -v rbenv &>/dev/null && eval "$(rbenv init -)" }

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
compinit
