{ system ? builtins.currentSystem
}:

let

glib-networking-overlay = self: super: {
  glib-networking = self.callPackage ./glib-networking.nix {};
};

nginx-overlay =  self: super: {
    nginx-1-22 = (import (builtins.fetchTarball {
      url = https://github.com/NixOS/nixpkgs/archive/dbb62c34bbb5cdf05f1aeab07638b24b0824d605.tar.gz;
      sha256 = "0v9c7j1ay2wk01mcfbc621f5n11bvl26018k3bc3h8wdssppm9ra";
    }) {}).nginx;
  };
z3 = self: super: {
  z3 = super.z3.overrideAttrs (drv: {
    name = "z3-4.8.8";
    version = "4.8.8";
    patches = [];
    src = self.fetchFromGitHub {
      owner = "Z3Prover";
      repo = "z3";
      rev = "ad55a1f1c617a7f0c3dd735c0780fc758424c7f1";
      sha256 = "1rn538ghqwxq0v8i6578j8mflk6fyv0cp4hjfqynzvinjbps56da";
    };
  });
};

haskellOverlay = import ./overrides.nix { inherit (rp) hackGet; };

reflex-platform-func = args: import ./dep/reflex-platform (args // {
  nixpkgsOverlays = (args.nixpkgsOverlays or []) ++ [z3 glib-networking-overlay nginx-overlay];
  haskellOverlays = (args.haskellOverlays or []) ++ [haskellOverlay];
});

rp = reflex-platform-func {};

pkgs = rp.nixpkgs;

gitignoreSrc = pkgs.fetchFromGitHub {
  owner = "hercules-ci";
  repo = "gitignore";
  rev = "f9e996052b5af4032fe6150bba4a6fe4f7b9d698";
  sha256 = "0jrh5ghisaqdd0vldbywags20m2cxpkbbk5jjjmwaw0gr8nhsafv";
};

in {
  inherit reflex-platform-func rp pkgs;
  inherit (rp) hackGet ghc8_10 ghcjs8_10;
  inherit (import gitignoreSrc { inherit (pkgs) lib; }) gitignoreSource;
  callHackageDirect = rp.nixpkgs.haskellPackages.callHackageDirect;
}
