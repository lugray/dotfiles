let
  pkgs = import <nixpkgs> {};
in
  pkgs.runCommand "poll" {} ''
    mkdir -p $out/bin
    cat << EOF >> $out/bin/poll
    #! ${pkgs.stdenv.shell}
    echo -en '\e[?1049h' # Enable alternative screen buffer
    echo -en '\e[2J\e[H' # Clear the screen and go to top left
    while true; do
      "\$@"
      read -rs -n1 -t1 input
      if [ "\$input" = "q" ]; then
        break
      fi
      echo -en '\e[H' # Go to top left
    done
    echo -en '\e[?1049l' # Disable alternative screen buffer
    EOF
    ${pkgs.coreutils}/bin/chmod +x $out/bin/poll
  ''
