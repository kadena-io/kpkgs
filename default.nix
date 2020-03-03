{ rpRef ? "dfac4599b37bbfdb754afa32d25ba4832623277a"
, rpSha ? "03hicg0x77nz4wmwaxnlwf9y0xbypjjdzg3hak756m1qq8vpgc17"
, system ? builtins.currentSystem
}:

let
rpSrc = builtins.fetchTarball {
  url = "https://github.com/reflex-frp/reflex-platform/archive/${rpRef}.tar.gz";
  sha256 = rpSha;
};

z3 = self: super: {
  z3 = super.z3.overrideAttrs (drv: {
    name = "z3-4.8.5";
    version = "4.8.5";
    patches = [];
    src = self.fetchFromGitHub {
      owner = "Z3Prover";
      repo = "z3";
      rev = "e79542cc689d52ec4cb34ce4ae3fbe56e7a0bf70";
      sha256 = "11sy98clv7ln0a5vqxzvh6wwqbswsjbik2084hav5kfws4xvklfa";
    };
  });
};

haskellOverlay = import ./overrides.nix { inherit (rp) hackGet; };

reflex-platform-func = args: import rpSrc (args // {
  nixpkgsOverlays = (args.nixpkgsOverlays or []) ++ [z3];
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

overrideHaskellPackages = orig: {
  buildHaskellPackages =
    orig.buildHaskellPackages.override overrideHaskellPackages;
  overrides = if orig ? overrides
              then pkgs.lib.composeExtensions orig.overrides haskellOverlay
              else haskellOverlay;
};

haskellPackages = compiler: pkgs.haskell.packages.${compiler}.override overrideHaskellPackages;

in {
  inherit reflex-platform-func rp pkgs haskellPackages;
  inherit (rp) hackGet;
  inherit (import gitignoreSrc { inherit (pkgs) lib; }) gitignoreSource;
  ghc865 = haskellPackages "ghc865";
}
