{ pkgs, blocksdsEnv, ... }:

blocksdsEnv.mkDerivation rec {
  pname = "NDStest";
  version = "0.0.1";

  src = ./.;

  makeFlags = [ "NAME=${pname}" ];

  installPhase = ''
    mkdir -p $out
    cp ${pname}.nds $out/
  '';
}
