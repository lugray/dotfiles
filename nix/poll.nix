let
  pkgs = import <nixpkgs> {};
in
  pkgs.writeShellScriptBin "poll" ''
    trap "echo -en '\e[?1049l'" EXIT
    echo -en '\e[?1049h'
    until [ "$input" = "q" ]; do
      echo -en '\e[H'
      "$@"
      read -rs -n1 -t1 input
    done
  ''
