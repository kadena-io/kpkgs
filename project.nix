{ withHoogle ? false
, kpkgs ? import ./. {}
}:

kpkgs.rp.project ({ pkgs, hackGet, ... }: {
    inherit withHoogle;

    packages = {
      kpkgs = kpkgs.gitignoreSource ./.;
    };

    shells = {
      ghc = ["kpkgs"];
      ghcjs = ["kpkgs"];
    };
  }
)
