zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._- ]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle :compinstall filename '/Users/lisaugray/.zshrc'
autoload -Uz compinit
compinit
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt appendhistory autocd
setopt HIST_IGNORE_SPACE
HIST_STAMPS="yyyy-mm-dd"

if [ -d ~/.shellfuncs ]; then
  for FILE in ~/.shellfuncs/*.sh; do
    source $FILE
  done
fi

if [ -f ~/nerdfont/i_all.sh ]; then
  source ~/nerdfont/i_all.sh
fi

if [ -f ~/.shell_aliases ]; then
    . ~/.shell_aliases
fi

# Load dev if it exists
if [[ -f "$HOME/src/github.com/Shopify/dev/dev.sh" ]]; then
  source "$HOME/src/github.com/Shopify/dev/dev.sh"
elif [[ -f /opt/dev/dev.sh ]]; then
  source /opt/dev/dev.sh
elif [ -f ~/src/github.com/burke/minidev/dev.sh ]; then
  source ~/src/github.com/burke/minidev/dev.sh
fi

# Load dev chruby if it exists
[[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }

# Load chruby if not present
if ! which chruby > /dev/null; then
  [[ -f /opt/homebrew/share/chruby/chruby.sh ]] && source /opt/homebrew/share/chruby/chruby.sh
  [[ -f /opt/homebrew/share/chruby/auto.sh ]] && source /opt/homebrew/share/chruby/auto.sh
fi

source ~/src/github.com/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh

if which spin > /dev/null; then
  source <(spin completion)
fi

###############
# Keybindings #
###############
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
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line
fi
bindkey '^A' beginning-of-line                        # [Cmd-LeftArrow] - requires iterm mapping to hex code 0x01
bindkey '^E' end-of-line                              # [Cmd-RightArrow] - requires iterm mapping to hex code 0x05
bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word
if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi
bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi
bindkey "µ" copy-prev-shell-word                    # Alt-m file rename magick

bindkey "˚" history-beginning-search-backward # Alt-K
bindkey "∆" history-beginning-search-forward # Alt-J

zle-dev-open-pr() /opt/dev/bin/dev open pr
zle -N zle-dev-open-pr
bindkey 'ø' zle-dev-open-pr # Alt-O ABC Extended
bindkey 'ʼ' zle-dev-open-pr # Alt-O Canadian English

zle-dev-open-github() /opt/dev/bin/dev open github
zle -N zle-dev-open-github
bindkey '©' zle-dev-open-github # Alt-G ABC Extended & Canadian English

zle-dev-open-shipit() /opt/dev/bin/dev open shipit
zle -N zle-dev-open-shipit
bindkey 'ß' zle-dev-open-shipit # Alt-S ABC Extended & Canadian English

zle-dev-open-app() /opt/dev/bin/dev open app
zle -N zle-dev-open-app
bindkey '®' zle-dev-open-app # Alt-R ABC Extended & Canadian English

##################
# zsh git prompt #
##################

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

source ~/src/github.com/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
