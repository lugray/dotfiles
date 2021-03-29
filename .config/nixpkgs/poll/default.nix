{ stdenv }:

stdenv.mkDerivation rec {
  name = "poll";

  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    cp poll $out/bin/poll
    chmod +x $out/bin/poll
  '';
}
