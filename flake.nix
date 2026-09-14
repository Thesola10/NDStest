{ description = "A basic flake based on callPackage";

  inputs."nixpkgs".url = github:NixOS/nixpkgs;
  inputs."devkitNix".url = github:bandithedoge/devkitNix;
  inputs."blocksds-nix".url = github:pgattic/blocksds-nix;

  outputs = { self, nixpkgs, flake-utils, devkitNix, blocksds-nix, ... }:
  flake-utils.lib.eachDefaultSystem
    (system:
    let pkgs = import nixpkgs {
          inherit system;
          overlays = [ blocksds-nix.overlays.default ];
        };
        blocksds = pkgs.blocksdsNix.blocksdsSlim;
        blocksdsEnv = blocksds.passthru;
    in
    { packages.default = pkgs.callPackage ./default.nix { inherit blocksdsEnv; };
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          blocksds
          gnumake
          cmake
          python3
        ];

        WONDERFUL_TOOLCHAIN = blocksdsEnv.WONDERFUL_TOOLCHAIN;
        BLOCKSDS            = blocksdsEnv.BLOCKSDS;
        BLOCKSDSEXT         = blocksdsEnv.BLOCKSDSEXT;
      };
    });
}
