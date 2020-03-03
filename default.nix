{ system ? builtins.currentSystem
}:

let

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

reflex-platform-func = args: import ./dep/reflex-platform (args // {
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

in {
  inherit reflex-platform-func rp pkgs;
  inherit (rp) hackGet ghc8_6 ghcjs8_6;
  inherit (import gitignoreSrc { inherit (pkgs) lib; }) gitignoreSource;
}
