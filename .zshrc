export GOPATH=$HOME
export GOBIN=$HOME/gobin
export PATH=$HOME/.yarn/bin:$HOME/bin:$GOBIN:/usr/local/bin:$PATH

# Load ~/.zsh_profile for interactive shells if it exists
if [[ $- == *i* ]] && [[ -f ~/.zsh_profile ]]; then source ~/.zsh_profile; fi

# Load dev for interactive shells if it exists
if [[ $- == *i* ]] && [[ -f /opt/dev/dev.sh ]]; then source /opt/dev/dev.sh; fi

# Load chruby if not present
if ! which chruby > /dev/null && [[ -f /usr/local/share/chruby/chruby.sh ]]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
fi

# cloudplatform: add Shopify clusters to your local kubernetes config
export KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}$HOME/.kube/config:$HOME/.kube/config.shopify.cloudplatform
