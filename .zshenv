export GOPATH=$HOME
export GOBIN=$HOME/gobin
export PATH=$HOME/.yarn/bin:$HOME/bin:$GOBIN:$PATH
export EDITOR=nvim
export KALEIDOSCOPE_DIR=${HOME}/src/github.com/keyboardio/Kaleidoscope
export LC_ALL="en_US.UTF-8"

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
[[ -x /usr/local/bin/brew ]] && eval $(/usr/local/bin/brew shellenv)


if [ -d $HOME/Library/Python/2.7/bin ]; then
  export PATH=$PATH:$HOME/Library/Python/2.7/bin
fi

# cloudplatform: add Shopify clusters to your local kubernetes config
export KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}$HOME/.kube/config