export GOPATH=$HOME
export GOBIN=$HOME/gobin
export PATH=$HOME/.yarn/bin:$HOME/bin:$GOBIN:/usr/local/bin:$PATH

if [[ -d /opt/homebrew ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew";
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
  export HOMEBREW_REPOSITORY="/opt/homebrew";
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
fi

# Load ~/.zsh_profile for interactive shells if it exists
if [[ $- == *i* ]] && [[ -f ~/.zsh_profile ]]; then source ~/.zsh_profile; fi

# Load dev if it exists
if [[ -f "$HOME/src/github.com/Shopify/dev/dev.sh" ]]; then
  source "$HOME/src/github.com/Shopify/dev/dev.sh"
elif [[ -f /opt/dev/dev.sh ]]; then
  source /opt/dev/dev.sh
elif [ -f ~/src/github.com/burke/minidev/dev.sh ]; then
  source ~/src/github.com/burke/minidev/dev.sh
fi

# Load chruby if not present
if ! which chruby > /dev/null && [[ -f /usr/local/share/chruby/chruby.sh ]]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
fi

# cloudplatform: add Shopify clusters to your local kubernetes config
export KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}$HOME/.kube/config
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }
