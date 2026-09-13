{ pkgs, stdenv, ... }:

stdenv.mkDerivation {
  name = throw "Edit `default.nix' to define package!";

  src = ./.;

  makeFlags = [ "TARGET=" ];

  nativeBuildInputs = with pkgs;
    [
    ];
}
