test -f ~/.rx/shell_config && source ~/.rx/shell_config
if [[ -d /Users/lisa.ugray/.rx/completions ]]; then fpath+=/Users/lisa.ugray/.rx/completions; fi
autoload -Uz compinit; compinit
source $HOMEBREW_PREFIX/opt/kube-ps1/share/kube-ps1.sh