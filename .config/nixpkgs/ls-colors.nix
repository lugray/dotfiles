let
  pkgs = import <nixpkgs> {};
  lsColors = pkgs.fetchgit {
    url = "https://github.com/trapd00r/LS_COLORS";
    rev = "da2f061feb4977bc5e3dfdb16ab65d93b3eca1ca";
    sha256 = "1yw4qz152r9jsg4v4n592gngfvwkcrkj68hrhm6n6d0qj6f6qf68";
  };
in
  pkgs.runCommand "ls-colors" {} ''
    mkdir -p $out/bin
    cat << EOF >> $out/bin/ls
    #! ${pkgs.stdenv.shell} -e
    $(${pkgs.coreutils}/bin/dircolors ${lsColors}/LS_COLORS)
    ${pkgs.coreutils}/bin/ls --color=auto -F "\$@"
    EOF
    ${pkgs.coreutils}/bin/chmod +x $out/bin/ls
  ''
