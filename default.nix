{ pkgs, devkitNix, ... }:

devkitNix.stdenvARM.mkDerivation rec {
  pname = "NDStest";
  version = "0.0.1";

  src = ./.;

  makeFlags = [ "TARGET=${pname}" ];

  installPhase = ''
    mkdir -p $out
    cp ${pname}.nds $out/
  '';
}
