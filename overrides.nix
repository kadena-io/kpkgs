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

  algebraic-graphs = whenGhcjs dontCheck super.algebraic-graphs;
  base-compat-batteries = whenGhcjs dontCheck super.base-compat-batteries;
  bound = whenGhcjs dontCheck super.bound;
  bsb-http-chunked = whenGhcjs dontCheck super.bsb-http-chunked;
  bytes = whenGhcjs dontCheck super.bytes;
  extra = whenGhcjs dontCheck super.extra;
  haskeline = guardGhcjs super.haskeline;
  http-date = whenGhcjs dontCheck super.http-date;
  http-media = whenGhcjs dontCheck super.http-media;
  inspection-testing = guardGhcjs super.inspection-testing;
  intervals = whenGhcjs dontCheck super.intervals;
  iproute = whenGhcjs dontCheck super.iproute;
  memory = whenGhcjs dontCheck super.memory;
  prettyprinter-ansi-terminal = whenGhcjs dontCheck super.prettyprinter-ansi-terminal;
  prettyprinter-convert-ansi-wl-pprint = whenGhcjs dontCheck super.prettyprinter-convert-ansi-wl-pprint;
  tdigest = whenGhcjs dontCheck super.tdigest;
  temporary = whenGhcjs dontCheck super.temporary;
  text-short = whenGhcjs dontCheck super.text-short; # either hang or take a long time
  unix-time = whenGhcjs dontCheck super.unix-time;

  base-orphans = dontCheck (callHackageDirect {
    pkg = "base-orphans";
    ver = "0.8.1";
    sha256 = "1jg06ykz8fsk1vlwih4vjw3kpcysp8nfsv7qjm42y2gfyzn6jvsk";
  });

  dec = dontCheck (callHackageDirect {
    pkg = "dec";
    ver = "0.0.3";
    sha256 = "11b8g4nm421pr09yfb4zp18yb7sq4wah598fi3p5fb64yy4c2n4s";
  });

  hedgehog = dontCheck (callHackageDirect {
    pkg = "hedgehog";
    ver = "1.0.1";
    sha256 = "0h9qwd4gw5n8j8is9kn9mll32c8v6z1dv9mp4fmkmz7k5zi4asjq";
  });

  http-api-data = dontCheck (callHackageDirect {
    pkg = "http-api-data";
    ver = "0.4.1";
    sha256 = "0wqji0raiq3snh7yifmv754sg5zjvw2gisgz1d3d0ljib2sw4jiq";
  });

  insert-ordered-containers = dontCheck (callHackageDirect {
    pkg = "insert-ordered-containers";
    ver = "0.2.2";
    sha256 = "1md93iaxsr4djx1i47zjwddd7pd4j3hzphj7495q7lz7mn8ifz4w";
  });

  megaparsec = dontCheck (callHackageDirect {
    pkg = "megaparsec";
    ver = "7.0.5";
    sha256 = "1wizfz8vdplz3sf81vh33sny6p8ynhlpvjxqjpsym7ssb186h0f1";
  });

  sbv = dontCheck (callHackageDirect {
    pkg = "sbv";
    ver = "8.2";
    sha256 = "1isa8p9dnahkljwj0kz10119dwiycf11jvzdc934lnjv1spxkc9k";
  });


  semialign = callHackageDirect {
    pkg = "semialign";
    ver = "1";
    sha256 = "0cwl7s62sbh3g1ys1lbsp76hz27admylk3prg5gjrqnx4ic9cap6";
  };

  # https://github.com/reflex-frp/reflex-platform/issues/549
  singleton-bool =
    if self.ghc.isGhcjs or false
    then overrideCabal (self.callCabal2nix "singleton-bool" (pkgs.fetchFromGitHub {
        owner = "obsidiansystems";
        repo = "singleton-bool";
        rev = "bf5c81fff6eaa9ed1286de9d0ecfffa7e0aa85d2";
        sha256 = "0fzi6f5pl2gg9k8f7k88qyyvjflpcw08905y0vjmbylzc70wsykw";
      }) {})
      (drv: {
        editedCabalFile = null;
        revision = null;
      })
    else dontCheck (callHackageDirect {
        pkg = "singleton-bool";
        ver = "0.1.5";
        sha256 = "1kjn5wgwgxdw2xk32d645v3ss2a70v3bzrihjdr2wbj2l4ydcah1";
      });

  servant = dontCheck (callHackageDirect {
    pkg = "servant";
    ver = "0.16.2";
    sha256 = "1a83fdcwnlkmyc6fqsrfd26izcgk1jgpdgyqma3l897cnnr62frs";
  });

  servant-client = dontCheck (callHackageDirect {
    pkg = "servant-client";
    ver = "0.16.0.1";
    sha256 = "1236sldcgvk2zj20cxib9yxrdxz7d1a83jfdnn9mxa272srfq9a9";
  });

  servant-client-core = dontCheck (callHackageDirect {
    pkg = "servant-client-core";
    ver = "0.16";
    sha256 = "0panxplcjslsvqxvsabn2fy0fhcqmmr0dqj51hk7bk7yyvgwxklf";
  });

  servant-server = dontCheck (callHackageDirect {
    pkg = "servant-server";
    ver = "0.16.2";
    sha256 = "1klcszpfqy1vn3q1wbqxjghfyddw8wbg4f0ggllqw8qx2f5zp5y1";
  });

  servant-swagger = dontCheck (callHackageDirect {
    pkg = "servant-swagger";
    ver = "1.1.7.1";
    sha256 = "1ymdcmdi234p9jbwa7rgj1j35n9xnx4kgfjba4gs2r8cnhqwak28";
  });

  swagger2 = dontCheck (callHackageDirect {
    pkg = "swagger2";
    ver = "2.4";
    sha256 = "1kgajvqbx8627191akn6pz4kiyi24gawvnvkyb7955dy7bnpd9pn";
  });

  tasty-hedgehog = dontCheck (callHackageDirect {
    pkg = "tasty-hedgehog";
    ver = "1.0.0.1";
    sha256 = "06mffkvscl8r81hjhsvjlyqa843szgv8fays1l9z4jaw2759glsr";
  });

  # Our own custom fork
  thyme = dontCheck (self.callCabal2nix "thyme" (pkgs.fetchFromGitHub {
    owner = "kadena-io";
    repo = "thyme";
    rev = "6ee9fcb026ebdb49b810802a981d166680d867c9";
    sha256 = "09fcf896bs6i71qhj5w6qbwllkv3gywnn5wfsdrcm0w1y6h8i88f";
  }) {});

  time-compat = dontCheck (callHackageDirect {
    pkg = "time-compat";
    ver = "1.9.2.2";
    sha256 = "11kdcw1g8m9hl6ps9i8hqrcpgidmv0r19sbxcwm1qrp9wf0bfq1y";
  });

  trifecta = dontCheck (callHackageDirect {
    pkg = "trifecta";
    ver = "2.1";
    sha256 = "0hbv8q12rgg4ni679fbx7ac3blzqxj06dw1fyr6ipc8kjpypb049";
  });

  unordered-containers = dontCheck (callHackageDirect {
    pkg = "unordered-containers";
    ver = "0.2.10.0";
    sha256 = "16xpq9qb1ipl0mb86rlb3bx29xvgcwirpm2ds0ynxjh0ylwzavkk";
  });

  hspec-golden = dontCheck (callHackageDirect {
    pkg = "hspec-golden";
    ver = "0.1.0.1";
    sha256 = "1fplsb3rb6f3w20cncr0zrjpf7x4kc3njy8l016p5wxxh3hkgdrs";
  });

  ## Chainweb Overrides ##
  chainweb-storage = dontCheck (self.callCabal2nix "chainweb-storage" (pkgs.fetchFromGitHub {
    owner = "kadena-io";
    repo = "chainweb-storage";
    rev = "17a5fb130926582eff081eeb1b94cb6c7097c67a";
    sha256 = "03ihjgwqpif68870wwsgz1s4yz45zql1slky1lj4ixfxbig06md4";
  }) {});

  configuration-tools = dontCheck (callHackageDirect {
    pkg = "configuration-tools";
    ver = "0.4.1";
    sha256 = "1sbn4dbb2y1gwdwjvz5vf6a1g349z0jha5iz4dmp2v67dv86fzs5";
  });

  digraph = dontCheck (callHackageDirect {
    pkg = "digraph";
    ver = "0.1.0.2";
    sha256 = "1alqdzzlw8ns6hy8vh3ic4ign7jjxxa0cyxkv26zz7k2dihf3hzg";
  });

  fake = doJailbreak (callHackageDirect {
    pkg = "fake";
    ver = "0.1.1.2";
    sha256 = "1swp4j80761rfb0xiwshf0zal02ykwrbv49iyjay9ivvka367wk9";
  });

  generic-lens = dontCheck (callHackageDirect {
    pkg = "generic-lens";
    ver = "1.2.0.1";
    sha256 = "0pkwyrmaj8wqlajb7cnswh7jq4pnvnhkjcl1flhw94gqn0vap50g";
  });

  hedgehog-fn = callHackageDirect {
    pkg = "hedgehog-fn";
    ver = "1.0";
    sha256 = "1dhfyfycy0wakw4j7rr01a7v70yms7dw3h60k5af7pi9v700wyb4";
  };

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

  merkle-log = callHackageDirect {
    pkg = "merkle-log";
    ver = "0.1.0.0";
    sha256 = "10jk274sbvsrr7varxa72jvh54n22qpw7d4p2wy7415bmij3y81p";
  };

  nonempty-containers = callHackageDirect {
    pkg = "nonempty-containers";
    ver = "0.3.1.0";
    sha256 = "1hnwvhz9w07z2mlq75iz0bysz586d828725k1bx8mjqvc86ncv8m";
  };

  random-strings = callHackageDirect {
    pkg = "random-strings";
    ver = "0.1.1.0";
    sha256 = "1d70i6hcdxrjnk05x0525lmb8wqzy9n0ipr8qd9fxpba89w24jc5";
  };

  rocksdb-haskell = dontCheck super.rocksdb-haskell;

  scheduler = callHackageDirect {
    pkg = "scheduler";
    ver = "1.4.2.1";
    sha256 = "0xlcvcwf3n4zbhf9pa3hyzc4ds628aki077564gaf4sdg1gm90qh";
  };

  systemd = callHackageDirect {
    pkg = "systemd";
    ver = "1.2.0";
    sha256 = "1mwrrki3zsc4ncr7psjv9iqkzh7f25c2ch4lf2784fh6q46i997j";
  };

  streaming-events = callHackageDirect {
    pkg = "streaming-events";
    ver = "1.0.0";
    sha256 = "1lwb5cdm4wm0avvq926jj1zyzs1g0mpanzw9kmj1r24clizdw6pm";
  };

  these = doJailbreak (callHackageDirect {
    pkg = "these";
    ver = "1.0.1";
    sha256 = "1b2cdc9d9slxjw5cr4pmplfln5kawj2w74zi92hsmwkffqiycjhz";
  });

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

  wai = dontCheck (callHackageDirect {
    pkg = "wai";
    ver = "3.2.2.1";
    sha256 = "0msyixvsk37qsdn3idqxb4sab7bw4v9657nl4xzrwjdkihy411jf";
  });

  wai-cors = dontCheck (callHackageDirect {
    pkg = "wai-cors";
    ver = "0.2.7";
    sha256 = "10yhjjkzp0ichf9ijiadliafriwh96f194c2g02anvz451capm6i";
  });

  wai-middleware-throttle = dontCheck (callHackageDirect {
    pkg = "wai-middleware-throttle";
    ver = "0.3.0.1";
    sha256 = "13pz31pl7bk51brc88jp0gffjx80w35kzzrv248w27d7dc8xc63x";
  });

  wai-extra = whenGhcjs dontCheck (callHackageDirect {
    pkg = "wai-extra";
    ver = "3.0.28";
    sha256 = "1k470vbn2c852syj15m9xzfjnaraw6cyn35ajf2b67i01ghkshgw";
  });

  wai-app-static = doJailbreak (whenGhcjs dontCheck (callHackageDirect {
    pkg = "wai-app-static";
    ver = "3.1.6.3";
    sha256 = "00dzhv3cdkmxgid34y7bbrkp9940pcmr2brhl2wal7kp0y999ldp";
  }));

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

  time-manager = callHackageDirect {
    pkg = "time-manager";
    ver = "0.0.0";
    sha256 = "0z2fxikx5ax2x5bg8mcjg4y6b6irmf0swrnfprrp2xry6j5ji6hx";
  };

  network-byte-order = whenGhcjs dontCheck (callHackageDirect {
    pkg = "network-byte-order";
    ver = "0.1.2.0";
    sha256 = "1a2kq8rmx5q3l1a3b3jcklm7hy3c3z0x08jnnwfik22sy5a5v2nr";
  });

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

  streaming-concurrency = callHackageDirect {
    pkg = "streaming-concurrency";
    ver = "0.3.1.3";
    sha256 = "11mgp53kpdnjnrx3l8z6nhm48rhl5i0sgn0vydqa488xinj3h28a";
  };

  ## chainweb-miner ##
  http-client = callHackageDirect {
    pkg = "http-client";
    ver = "0.6.4";
    sha256 = "0p1khv99488g3c59cv6ckvpm77h40hf92pw8kxk29csblawi2vhf";
  };

  retry = callHackageDirect {
    pkg = "retry";
    ver = "0.8.0.1";
    sha256 = "1hbmcc4nkvz1xh01ijksf2n7aprgz2imafgj1bjmj9m47np7g2j1";
  };

  rio = callHackageDirect {
    pkg = "rio";
    ver = "0.1.12.0";
    sha256 = "1mwv1y9mrhmm5wii09f3gvy100zp6k9441mszx630ilz1igmypkn";
  };

  typed-process = callHackageDirect {
    pkg = "typed-process";
    ver = "0.2.5.0";
    sha256 = "00jgzcqc6n759547ij7s5bfb08q92sq3kfrbzhh5l1ppz5agv9li";
  };

  unliftio = callHackageDirect {
    pkg = "unliftio";
    ver = "0.2.12";
    sha256 = "1mlvs28mv269vd9j9l67i7w7kwzlh1zm5fm7nqdr7pmhqdr27ybn";
  };

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

  ## kadena packages ##
  chainweb = dontCheck (self.callCabal2nix "chainweb" repos.chainweb-node {});
  chainweb-api = self.callCabal2nix "chainweb-miner" repos.chainweb-api {};
  chainweb-miner = self.callCabal2nix "chainweb-miner" repos.chainweb-miner {};
  pact = addBuildDepend (self.callCabal2nix "pact" repos.pact {}) pkgs.z3;
  kadena-signing-api = self.callCabal2nix "kadena-signing-api" (repos.signing-api + /kadena-signing-api) {};
}
