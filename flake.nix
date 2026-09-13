{ description = "A basic flake based on callPackage";

  inputs."nixpkgs".url = github:NixOS/nixpkgs;
  inputs."devkitNix".url = github:bandithedoge/devkitNix;

  outputs = { self, nixpkgs, flake-utils, devkitNix, ... }:
  flake-utils.lib.eachDefaultSystem
    (system:
    let pkgs = import nixpkgs {
      inherit system;
      overlays = [ devkitNix.overlays.default ];
    };
    in
    { packages.default = pkgs.callPackage ./default.nix {};
      devShells.default = pkgs.mkShell.override { stdenv = pkgs.devkitNix.stdenvARM; } {};
    });
}
