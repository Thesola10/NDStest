{ pkgs, stdenv, blocksdsEnv, ... }:

stdenv.mkDerivation rec {
  pname = "NDStest";
  version = "0.0.1";

  src = ./.;

  makeFlags = [ "NAME=${pname}" ];

  installPhase = ''
    mkdir -p $out
    cp ${pname}.nds $out/
  '';

  WONDERFUL_TOOLCHAIN = blocksdsEnv.WONDERFUL_TOOLCHAIN;
  BLOCKSDS            = blocksdsEnv.BLOCKSDS;
  BLOCKSDSEXT         = blocksdsEnv.BLOCKSDSEXT;
}
