{ hackGet }: self: super:
let
    pkgs = self.callPackage ({ pkgs }: pkgs) {};
    guardGhcjs = p: if self.ghc.isGhcjs or false then null else p;
    whenGhcjs = f: p: if self.ghc.isGhcjs or false then (f p) else p;
    callHackageDirect = args: self.callHackageDirect args {};

    repos = {
      chainweb-api = hackGet ./dep/chainweb-api;
      chainweb-miner = hackGet ./dep/chainweb-miner;
      chainweb-node = hackGet ./dep/chainweb-node;
      pact = hackGet ./dep/pact;
      signing-api = hackGet ./dep/signing-api;
    };

in with pkgs.haskell.lib; {
  Glob = whenGhcjs dontCheck super.Glob;

  aeson = if self.ghc.isGhcjs or false
    then dontCheck (self.callCabal2nix "aeson" (pkgs.fetchFromGitHub {
        owner = "obsidiansystems";
        repo = "aeson";
        rev = "d6288c431a477f9a6e93aa80454a9e1712127548"; # branch v1450-text-jsstring containing (ToJSVal Value) instance and other fixes
        sha256 = "102hj9b42z1h9p634g9226nvs756djwadrkz9yrb15na671f2xf4";
      }) {})
    else enableCabalFlag (dontCheck (callHackageDirect {
        pkg = "aeson";
        ver = "1.4.5.0";
        sha256 = "0imcy5kkgrdrdv7zkhkjvwpdp4sms5jba708xsap1vl9c2s63n5a";
      })) "cffi";

  ## Pact Overrides ##

  base-compat-batteries = whenGhcjs dontCheck super.base-compat-batteries;
  bound = whenGhcjs dontCheck super.bound;
  bsb-http-chunked = whenGhcjs dontCheck super.bsb-http-chunked;
  bytes = whenGhcjs dontCheck super.bytes;
  extra = whenGhcjs dontCheck super.extra;
  haskeline = guardGhcjs super.haskeline;
  http-date = whenGhcjs dontCheck super.http-date;
  http-media = whenGhcjs dontCheck super.http-media;
  intervals = whenGhcjs dontCheck super.intervals;
  iproute = whenGhcjs dontCheck super.iproute;
  memory = whenGhcjs dontCheck super.memory;
  prettyprinter-ansi-terminal = whenGhcjs dontCheck super.prettyprinter-ansi-terminal;
  prettyprinter-convert-ansi-wl-pprint = whenGhcjs dontCheck super.prettyprinter-convert-ansi-wl-pprint;
  tdigest = whenGhcjs dontCheck super.tdigest;
  temporary = whenGhcjs dontCheck super.temporary;
  text-short = whenGhcjs dontCheck super.text-short; # either hang or take a long time
  unix-time = whenGhcjs dontCheck super.unix-time;
  yet-another-logger = markUnbroken super.yet-another-logger;

  algebraic-graphs = whenGhcjs dontCheck (callHackageDirect {
    pkg = "algebraic-graphs";
    ver = "0.5";
    sha256 = "0z8mgzdis72a9zd9x9f185phqr4bx8s06piggis4rlih1rly61nr";
  });

  hedgehog = callHackageDirect {
    pkg = "hedgehog";
    ver = "1.0.1";
    sha256 = "0h9qwd4gw5n8j8is9kn9mll32c8v6z1dv9mp4fmkmz7k5zi4asjq";
  };

  inspection-testing = guardGhcjs (callHackageDirect {
    pkg = "inspection-testing";
    ver = "0.4.2.2";
    sha256 = "0pis67bwxzn71398bmz5r5w21b3bkm3fxly5ws28w2dp9qkpdh9j";
  });

  sbv = dontCheck (callHackageDirect {
    pkg = "sbv";
    ver = "8.2";
    sha256 = "1isa8p9dnahkljwj0kz10119dwiycf11jvzdc934lnjv1spxkc9k";
  });

  servant = whenGhcjs dontCheck super.servant;   # doctest

  servant-client = dontCheck (callHackageDirect {
    pkg = "servant-client";
    ver = "0.16.0.1";
    sha256 = "1236sldcgvk2zj20cxib9yxrdxz7d1a83jfdnn9mxa272srfq9a9";
  });

  swagger2 = dontCheck super.swagger2;

  # Our own custom fork
  thyme = dontCheck (self.callCabal2nix "thyme" (pkgs.fetchFromGitHub {
    owner = "kadena-io";
    repo = "thyme";
    rev = "6ee9fcb026ebdb49b810802a981d166680d867c9";
    sha256 = "09fcf896bs6i71qhj5w6qbwllkv3gywnn5wfsdrcm0w1y6h8i88f";
  }) {});

  trifecta = dontCheck (callHackageDirect {
    pkg = "trifecta";
    ver = "2.1";
    sha256 = "0hbv8q12rgg4ni679fbx7ac3blzqxj06dw1fyr6ipc8kjpypb049";
  });

  ## Chainweb Overrides ##
  chainweb-storage = self.callCabal2nix "chainweb-storage" (pkgs.fetchFromGitHub {
    owner = "kadena-io";
    repo = "chainweb-storage";
    rev = "17a5fb130926582eff081eeb1b94cb6c7097c67a";
    sha256 = "03ihjgwqpif68870wwsgz1s4yz45zql1slky1lj4ixfxbig06md4";
  }) {};

  connection = callHackageDirect {
    pkg = "connection";
    ver = "0.3.1";
    sha256 = "0qjdz2fxxszbns7cszhnkwm8x8l3xlnad6iydx2snfi416sypiy0";
  };

  digraph = callHackageDirect {
    pkg = "digraph";
    ver = "0.1.0.2";
    sha256 = "1alqdzzlw8ns6hy8vh3ic4ign7jjxxa0cyxkv26zz7k2dihf3hzg";
  };

  generic-lens = dontCheck (callHackageDirect {
    pkg = "generic-lens";
    ver = "1.2.0.1";
    sha256 = "0pkwyrmaj8wqlajb7cnswh7jq4pnvnhkjcl1flhw94gqn0vap50g";
  });

  http2 = callHackageDirect {
    pkg = "http2";
    ver = "2.0.3";
    sha256 = "14bqmxla0id956y37fpfx9v6crwxphbfxkl8v8annrs8ngfbhbr7";
  };

  massiv = callHackageDirect {
    pkg = "massiv";
    ver = "0.4.2.0";
    sha256 = "0md9zs1md32ny9ln0dpw2hw1xka1v67alv68s8xhj0p7fabi5lxm";
  };

  scheduler = callHackageDirect {
    pkg = "scheduler";
    ver = "1.4.2.1";
    sha256 = "0xlcvcwf3n4zbhf9pa3hyzc4ds628aki077564gaf4sdg1gm90qh";
  };

  streaming-events = callHackageDirect {
    pkg = "streaming-events";
    ver = "1.0.0";
    sha256 = "1lwb5cdm4wm0avvq926jj1zyzs1g0mpanzw9kmj1r24clizdw6pm";
  };

  tls = callHackageDirect {
    pkg = "tls";
    ver = "1.5.3";
    sha256 = "1785i2ba4xvqz9k32qn74vk6zwplmj77dz8jqykndb0g79hq1f27";
  };

  tls-session-manager = callHackageDirect {
    pkg = "tls-session-manager";
    ver = "0.0.4";
    sha256 = "03jr0xmzl5bqjw2l59bcpfclji6g4rky8ji86mg60jg7nia5d5l8";
  };

  warp = dontCheck (callHackageDirect {
    pkg = "warp";
    ver = "3.3.6";
    sha256 = "044w7ajkqlwnrpzc4zaqy284ac9wsklyby946jgfpqyjbj87985x";
  });

  warp-tls = callHackageDirect {
    pkg = "warp-tls";
    ver = "3.2.10";
    sha256 = "1zgr83zkb3q4qa03msfnncwxkmvk63gd8sqkbbd1cwhvjragn4mz";
  };

  strict-tuple = callHackageDirect {
    pkg = "strict-tuple";
    ver = "0.1.3";
    sha256 = "1vg0m27phd6yf0pszcy2c2wbqx509fr9gacn34yja521z17cxd8z";
  };

  lens-aeson = whenGhcjs dontCheck (callHackageDirect {
    pkg = "lens-aeson";
    ver = "1.1";
    sha256 = "0bx7ay7dx6ljhy1a6bmjdz52vfwmx8af8sd96p38yc0m9irjz02h";
  });

  streaming-commons = whenGhcjs dontCheck super.streaming-commons;

  # https://github.com/ghcjs/jsaddle/pull/114 widens warp bound
  # tests disabled because webdriver fails to build
  jsaddle-warp = dontCheck (self.callCabal2nix "jsaddle-warp" (pkgs.fetchFromGitHub {
    owner = "obsidiansystems";
    repo = "jsaddle";
    rev = "86b166033186c1724d4d52eeaf0935f0f29fe1ca";
    sha256 = "1m1xxy4l9ii91k1k504qkxh9k1ybprm1m66mkb9dqlwcpyhcccmv";
  } + /jsaddle-warp) {});

  ## chainweb-api ##
  blake2 = dontCheck (callHackageDirect {
    pkg = "blake2";
    ver = "0.3.0";
    sha256 = "0n366qqhz7azh9fgjqvj99b3ni57721a2q5xxlawwmkxrxy36hb2";
  });

  ## Kadena packages ##
  chainweb = self.callCabal2nix "chainweb" repos.chainweb-node {};
  chainweb-api = self.callCabal2nix "chainweb-miner" repos.chainweb-api {};
  chainweb-miner = self.callCabal2nix "chainweb-miner" repos.chainweb-miner {};
  pact = addBuildDepend (self.callCabal2nix "pact" repos.pact {}) pkgs.z3;
  kadena-signing-api = self.callCabal2nix "kadena-signing-api" (repos.signing-api + /kadena-signing-api) {};
}
