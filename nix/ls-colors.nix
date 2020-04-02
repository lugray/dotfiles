let
  pkgs = import <nixpkgs> {};
  lsColors = builtins.fetchGit {
    url = "https://github.com/trapd00r/LS_COLORS";
    rev = "da2f061feb4977bc5e3dfdb16ab65d93b3eca1ca";
  };
in
  pkgs.runCommand "ls-colors" {} ''
    mkdir -p $out/bin
    echo "#! ${pkgs.bash}/bin/bash -e" > $out/bin/ls
    ${pkgs.coreutils}/bin/dircolors ${lsColors}/LS_COLORS >> $out/bin/ls
    echo "${pkgs.coreutils}/bin/ls --color=auto -F \"\$@\"" >> $out/bin/ls
    chmod +x $out/bin/ls
  ''
