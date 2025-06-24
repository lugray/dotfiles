
test -f /Users/lisa.ugray/.rx/shell_config && source /Users/lisa.ugray/.rx/shell_config

echo9() {
  echo "$@" >&9
}
__rx_bin=echo9
__rx "use:~/src/git.fullscript.io/devops/rx/public/darwin_arm64/rx"
