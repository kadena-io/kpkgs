{ hackGet }: self: super:
let
    pkgs = self.callPackage ({ pkgs }: pkgs) {};
    guardGhcjs = p: if self.ghc.isGhcjs or false then null else p;
    whenGhcjs = f: p: if self.ghc.isGhcjs or false then (f p) else p;
    callHackageDirect = args: self.callHackageDirect args {};

    repos = {
      beamSrc = hackGet ./dep/beam;
    };

in with pkgs.haskell.lib; {
  happy = dontCheck super.happy;

  direct-sqlite = dontCheck (self.callHackageDirect {
    pkg = "direct-sqlite";
    ver = "2.3.27";
    sha256 = "0w8wj3210h08qlws40qhidkscgsil3635zk83kdlj929rbd8khip";
  } {});

  pact-time = dontCheck (self.callHackageDirect {
    pkg = "pact-time";
    ver = "0.2.0.0";
    sha256 = "1cfn74j6dr4279bil9k0n1wff074sdlz6g1haqyyy38wm5mdd7mr";
  } {});

  # sbv requires this even though it is not used in the build (and the hash is invalid)
  tasty-bench = dontCheck (self.callHackageDirect {
    pkg = "tasty-bench";
    ver = "0.3.1";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  } {});

  libBF = doJailbreak (dontCheck (self.callHackageDirect {
    pkg = "libBF";
    ver = "0.6.3";
    sha256 = "0j0i39jb389rnrkkw2xqz10471afxys79nf31hhlqr4fk6ddhjf7";
  } {}));

  hnix = doJailbreak (dontCheck (overrideCabal (self.callHackageDirect {
    pkg = "hnix";
    ver = "0.12.0.1";
    sha256 = "19kqvvrz12g63d5xvw35pchqrgy30hyvjypmwkbnfz358881hvg0";
  } { }) (drv: { libraryHaskellDepends = drv.libraryHaskellDepends ++ [ super.prettyprinter ]; })));

  sbv = dontCheck (self.callHackageDirect {
    pkg = "sbv";
    ver = "9.0";
    sha256 = "14g2qax1vc7q4g78fa562dviqvcd0l52kd5jmgv90g3g3ci15bnl";
  } {});

  # async = doJailbreak (dontCheck (self.callHackageDirect {
  #   pkg = "async";
  #   ver = "2.2.4";
  #   sha256 = "0wjyyqvlvvq75ywpr86myib34z29k7i32rnwcqpwfi0d3p7nx055";
  # } {}));

  # hashable = doJailbreak (dontCheck (self.callHackageDirect {
  #   pkg = "hashable";
  #   ver = "1.3.0.0";
  #   sha256 = "10w1a9175zxy11awir48axanyy96llihk1dnfgypn9qwdnqd9xnx";
  # } {}));

  OneTuple = dontCheck (self.callHackageDirect {
    pkg = "OneTuple";
    ver = "0.3";
    sha256 = "1xs5zmg1dq815gbb35khbj6jp64f7zgk1hfy8pyf7srm22cjd2dz";
  } {});

  th-abstraction = dontCheck (self.callHackageDirect {
    pkg = "th-abstraction";
    ver = "0.4.5.0";
    sha256 = "19nh7a9b4yif6sijp6xns6xlxcr1mcyrqx3cfbp5bdm7mkbda7a9";
  } {});

  microlens-th = dontCheck (self.callHackageDirect {
    pkg = "microlens-th";
    ver = "0.4.3.7";
    sha256 = "0b5ipkfy5dh4j87x6d14as6ch2wl93h74i2vw215b22nd1hf43fm";
  } {});

  jose = dontCheck (self.callHackageDirect {
    pkg = "jose";
    ver = "0.8.3.1";
    sha256 = "0ny1dbh41iq1d88iiy1zjyc67b8pyd3jw4d3h3kly42scx2m0bf9";
  } {});

  text-short = doJailbreak (dontCheck (self.callHackageDirect {
    pkg = "text-short";
    ver = "0.1.5";
    sha256 = "0fyyp9r1qsk16kcdbqm3r4yk5nm22sd4vgzg76cyszbj0cypfvaj";
  } {}));

  yaml = dontCheck (self.callHackageDirect {
    pkg = "yaml";
    ver = "0.11.8.0";
    sha256 = "07jy41hyv3cql5s6pqwz7s9dxldw8gq139lgx5f3pmm3rj50irjx";
  } {});

  # text = dontCheck (self.callHackageDirect {
  #   pkg = "text";
  #   ver = "1.2.4.1";
  #   sha256 = "1mzp5c4yk5ja5w7rb606s5sgc11g475yfr7gxjjiq5qjcwrww64y";
  # } {});

  quickcheck-instances = doJailbreak (dontCheck (self.callHackageDirect {
    pkg = "quickcheck-instances";
    ver = "0.3.25.2";
    sha256 = "18hr1cmgghsmpxjlkc17r2rmm8n9n91ld5y5srysy7fbl0g706px";
  } {}));
  
  # base64-bytestring = doJailbreak (dontCheck (self.callHackageDirect {
  #   pkg = "base64-bytestring";
  #   ver = "1.2.1.0";
  #   sha256 = "10gyx24hmlqlvyn7z3kr37w36fkfb6lm4v27sxi233gcfvssxv9r";
  # } {}));

  base64-bytestring = doJailbreak (dontCheck (self.callHackageDirect {
    pkg = "base64-bytestring";
    ver = "1.0.0.2";
    sha256 = "1xhlkf7wp15g986nx9npkys1gwrg3mj1jwr26s675kr8jdv9rbfj";
  } {}));

  cborg = doJailbreak (dontCheck (self.callHackageDirect {
    pkg = "cborg";
    ver = "0.2.8.0";
    sha256 = "184db0cbvpqx53cf2n1801xj72549w32rvylb0k3vr6kr7kh780p";
  } {}));

  jsaddle = doJailbreak (dontCheck (self.callHackageDirect {
    pkg = "jsaddle";
    ver = "0.9.8.2";
    sha256 = "0xnhzdwwc43632ag1p29f74qqx0ndz5xkp5sr23wpshja7bvzkxj";
  } {}));

  # jsaddle-warp= dontCheck (self.callHackageDirect {
  #   pkg = "jsaddle-warp";
  #   ver = "0.9.8.2";
  #   sha256 = "0xxxxxxxxxxxxxxxxxxxxs6ch2wl93h74i2vw215b22nd1hf43fm";
  # } {});

#  Glob = whenGhcjs dontCheck super.Glob;
#
# aeson = if self.ghc.isGhcjs or false
#   then dontCheck (self.callCabal2nix "aeson" (pkgs.fetchFromGitHub {
#       owner = "obsidiansystems";
#       repo = "aeson";
#       rev = "d6288c431a477f9a6e93aa80454a9e1712127548"; # branch v1450-text-jsstring containing (ToJSVal Value) instance and other fixes
#       sha256 = "102hj9b42z1h9p634g9226nvs756djwadrkz9yrb15na671f2xf4";
#     }) {})
#   else enableCabalFlag (dontCheck (callHackageDirect {
#       pkg = "aeson";
#       ver = "1.4.5.0";
#       sha256 = "0imcy5kkgrdrdv7zkhkjvwpdp4sms5jba708xsap1vl9c2s63n5a";
#     })) "cffi";
aeson = if self.ghc.isGhcjs or false
  then dontCheck (self.callCabal2nix "aeson" (pkgs.fetchFromGitHub {
      owner = "obsidiansystems";
      repo = "aeson";
      rev = "afa2d0b8a3c5bb9ea533929e4c77dd01e8f1fc27"; # branch v1541-text-jsstring containing (ToJSVal Value) instance and other fixes
      sha256 = "0nsmnc5npkig9mhpj0j7yqydp0nkqq370f2lqskgj5z16d4vc0vm";
    }) {})
  else enableCabalFlag (dontCheck (callHackageDirect {
      pkg = "aeson";
      ver = "1.5.4.1";
      sha256 = "1kwhxfxff2jrrlrqmr9m846g0lq2iin32hwl5i8x7wqhscx5swh5";
    })) "cffi";

#  ## Pact Overrides ##
#
#  algebraic-graphs = markUnbroken (dontCheck super.algebraic-graphs);
#  base-compat-batteries = whenGhcjs dontCheck super.base-compat-batteries;
# bound = whenGhcjs dontCheck super.bound;
#  brittany = doJailbreak super.brittany;
#  bsb-http-chunked = whenGhcjs dontCheck super.bsb-http-chunked;
#  bytes = whenGhcjs dontCheck super.bytes;
#  extra = whenGhcjs dontCheck super.extra;
#  haskeline = guardGhcjs super.haskeline;
#  http-date = whenGhcjs dontCheck super.http-date;
#  inspection-testing = guardGhcjs super.inspection-testing;
#  intervals = whenGhcjs dontCheck super.intervals;
#  iproute = whenGhcjs dontCheck super.iproute;
#  memory = whenGhcjs dontCheck super.memory;
#  prettyprinter-ansi-terminal = whenGhcjs dontCheck super.prettyprinter-ansi-terminal;
#  prettyprinter-convert-ansi-wl-pprint = whenGhcjs dontCheck super.prettyprinter-convert-ansi-wl-pprint;
#  tdigest = whenGhcjs dontCheck super.tdigest;
#  temporary = whenGhcjs dontCheck super.temporary;
# text-short = whenGhcjs dontCheck super.text-short; # either hang or take a long time
#  unix-time = whenGhcjs dontCheck super.unix-time;

#  base-orphans = dontCheck (callHackageDirect {
#    pkg = "base-orphans";
#    ver = "0.8.1";
#    sha256 = "1jg06ykz8fsk1vlwih4vjw3kpcysp8nfsv7qjm42y2gfyzn6jvsk";
#  });
#
#  dec = dontCheck (callHackageDirect {
#    pkg = "dec";
#    ver = "0.0.3";
#    sha256 = "11b8g4nm421pr09yfb4zp18yb7sq4wah598fi3p5fb64yy4c2n4s";
#  });
#
#  hedgehog = dontCheck (callHackageDirect {
#    pkg = "hedgehog";
#    ver = "1.0.1";
#    sha256 = "0h9qwd4gw5n8j8is9kn9mll32c8v6z1dv9mp4fmkmz7k5zi4asjq";
#  });
#
websockets = dontCheck (callHackageDirect {
  pkg = "websockets";
  ver = "0.12.7.3";
  sha256 = "0kyf82v1df9kqk7bmy9ib6i1mj6djvgbly5xxmjdcg150z2kj1nd";
});

hspec-megaparsec = dontCheck (callHackageDirect {
  pkg = "hspec-megaparsec";
  ver = "2.2.0";
  sha256 = "0fclj5snkg4r18zjpbgp4ai1lzxkvnrjh0194pi9l4s9g277ranc";
});

http-api-data = doJailbreak (dontCheck (callHackageDirect {
  pkg = "http-api-data";
  ver = "0.4.3";
  sha256 = "049zh2y24hjxsp8pmlyn944grahj001j9qpcx1kxsi6a0c4s7agk";
}));

attoparsec = doJailbreak (dontCheck (callHackageDirect {
  pkg = "attoparsec";
  ver = "0.13.2.5";
  sha256 = "0qwshlgr85mk73mp2j3bnvg2w30gmsqgn13id0baqwylg797hhmi";
}));

attoparsec-iso8601 = dontCheck (callHackageDirect {
  pkg = "attoparsec-iso8601";
  ver = "1.0.2.0";
  sha256 = "108j8wh25k1ws5ggwp05pl4jlzx2scj0dzmisxrsc8cv70rqm114";
});

# http-media = dontCheck (callHackageDirect {
#   pkg = "http-media";
#   ver = "0.8.0.0";
#   sha256 = "080xkljq1iq0i8wagg8kbzbp523p2awa98wpn9i4ph1dq8y8346y";
# });
#
#  insert-ordered-containers = dontCheck (callHackageDirect {
#    pkg = "insert-ordered-containers";
#    ver = "0.2.2";
#    sha256 = "1md93iaxsr4djx1i47zjwddd7pd4j3hzphj7495q7lz7mn8ifz4w";
#  });
#
megaparsec = dontCheck (callHackageDirect {
  pkg = "megaparsec";
  ver = "9.0.0";
  sha256 = "03kqcfpsmi5l4mr6lsmlpks2mp9prf9yy97mmrkclwqpxybdjx2l";
});

modern-uri = dontCheck (callHackageDirect {
  pkg = "modern-uri";
  ver = "0.3.3.0";
  sha256 = "1z1ad9n5h4pjgfbb38fanysrjvf8dhb8s2vfbb0b8w7jmn9rsc2x";
});

# neat-interpolation >= 0.4 breaks Chainweb genesis blocks!
neat-interpolation = dontCheck (callHackageDirect {
  pkg = "neat-interpolation";
  ver = "0.5.1.2";
  sha256 = "0lcgjxw690hyswqxaghf7z08mx5694l7kijyrsjd42yxswajlplx";
});
#
#  pact-time = dontCheck (self.callHackageDirect {
#    pkg = "pact-time";
#    ver = "0.2.0.0";
#    sha256 = "1cfn74j6dr4279bil9k0n1wff074sdlz6g1haqyyy38wm5mdd7mr";
#  } {});
#
#  # prettyprinter > 1.6.0 breaks binary compatibility of Pact payloads
#  # inside Chainweb blocks!
prettyprinter = dontCheck (callHackageDirect {
  pkg = "prettyprinter";
  ver = "1.6.0";
  sha256 = "0f8wqaj3cv3yra938afqf62wrvq20yv9jd048miw5zrfavw824aa";
});
#
#  semialign = callHackageDirect {
#    pkg = "semialign";
#    ver = "1";
#    sha256 = "0cwl7s62sbh3g1ys1lbsp76hz27admylk3prg5gjrqnx4ic9cap6";
#  };
#
#  # https://github.com/reflex-frp/reflex-platform/issues/549
#  singleton-bool =
#    if self.ghc.isGhcjs or false
#    then overrideCabal (self.callCabal2nix "singleton-bool" (pkgs.fetchFromGitHub {
#        owner = "obsidiansystems";
#        repo = "singleton-bool";
#        rev = "bf5c81fff6eaa9ed1286de9d0ecfffa7e0aa85d2";
#        sha256 = "0fzi6f5pl2gg9k8f7k88qyyvjflpcw08905y0vjmbylzc70wsykw";
#      }) {})
#      (drv: {
#        editedCabalFile = null;
#        revision = null;
#      })
#    else dontCheck (callHackageDirect {
#        pkg = "singleton-bool";
#        ver = "0.1.5";
#        sha256 = "1kjn5wgwgxdw2xk32d645v3ss2a70v3bzrihjdr2wbj2l4ydcah1";
#      });
#
servant = dontCheck (callHackageDirect {
  pkg = "servant";
  ver = "0.19";
  sha256 = "0i268m73p54fhzx9f4zbk3dx4mpj07vw3hrzrlxn4hizb885sdr8";
});

servant-client = dontCheck (callHackageDirect {
  pkg = "servant-client";
  ver = "0.19";
  sha256 = "1l0yjal6piigx7makvg8xgn1gz90fjr8kflsaf8ilkvlfrglfqmz";
});

servant-client-core = dontCheck (callHackageDirect {
  pkg = "servant-client-core";
  ver = "0.19";
  sha256 = "0z20rmavxajq2fv7889x17gym4c7hkllmp5xzmw25c9pcjkq96zx";
});

servant-server = dontCheck (callHackageDirect {
  pkg = "servant-server";
  ver = "0.19";
  sha256 = "10flb630f1anrpwd993bmcr94iwj00jbbsr6xppa1s5537wz7hlx";
});
#
#  servant-swagger = dontCheck (callHackageDirect {
#    pkg = "servant-swagger";
#    ver = "1.1.7.1";
#    sha256 = "1ymdcmdi234p9jbwa7rgj1j35n9xnx4kgfjba4gs2r8cnhqwak28";
#  });
#
#  swagger2 = dontCheck (callHackageDirect {
#    pkg = "swagger2";
#    ver = "2.4";
#    sha256 = "1kgajvqbx8627191akn6pz4kiyi24gawvnvkyb7955dy7bnpd9pn";
#  });
#
#  tasty-hedgehog = dontCheck (callHackageDirect {
#    pkg = "tasty-hedgehog";
#    ver = "1.0.0.1";
#    sha256 = "06mffkvscl8r81hjhsvjlyqa843szgv8fays1l9z4jaw2759glsr";
#  });
#
#  # Our own custom fork
#  thyme = dontCheck (self.callCabal2nix "thyme" (pkgs.fetchFromGitHub {
#    owner = "kadena-io";
#    repo = "thyme";
#    rev = "6ee9fcb026ebdb49b810802a981d166680d867c9";
#    sha256 = "09fcf896bs6i71qhj5w6qbwllkv3gywnn5wfsdrcm0w1y6h8i88f";
#  }) {});
#
#  time-compat = dontCheck (callHackageDirect {
#    pkg = "time-compat";
#    ver = "1.9.2.2";
#    sha256 = "11kdcw1g8m9hl6ps9i8hqrcpgidmv0r19sbxcwm1qrp9wf0bfq1y";
#  });
#
#  trifecta = dontCheck (callHackageDirect {
#    pkg = "trifecta";
#    ver = "2.1";
#    sha256 = "0hbv8q12rgg4ni679fbx7ac3blzqxj06dw1fyr6ipc8kjpypb049";
#  });
#
#  unordered-containers = dontCheck (callHackageDirect {
#    pkg = "unordered-containers";
#    ver = "0.2.15.0";
#    sha256 = "101fjg7jsa0mw57clpjwc2vgrdkrnn0vmf4xgagja21ynwwbl2b5";
#  });
#
#  hspec-golden = dontCheck (callHackageDirect {
#    pkg = "hspec-golden";
#    ver = "0.1.0.2";
#    sha256 = "072dfk1l4kwgc95kfkj2v30pybv6f8imx95w6wzxpnv8prvx7jy0";
#  });
#
#  ## Chainweb Overrides ##
#  configuration-tools = dontCheck (callHackageDirect {
#    pkg = "configuration-tools";
#    ver = "0.5.0";
#    sha256 = "178myf00d7612a668wmr5simd3nz8pa2v3m803i8xc1qvzayjnvb";
#  });
#
#  cuckoo = dontBenchmark (dontCheck (callHackageDirect {
#     pkg = "cuckoo";
#     ver = "0.2.1";
#     sha256 = "1dsac9qc90aagcgvznzfjd4wl8wgxhq1m8f5h556ys72nkm1ablx";
#   }));
#
#  digraph = dontCheck (callHackageDirect {
#    pkg = "digraph";
#    ver = "0.2";
#    sha256 = "0gly6ya97bkd7ppw316czwfl7v39jc7vr93qmxqjczxn3msc9vi0";
#  });
#
#  fake = doJailbreak (callHackageDirect {
#    pkg = "fake";
#    ver = "0.1.1.2";
#    sha256 = "1swp4j80761rfb0xiwshf0zal02ykwrbv49iyjay9ivvka367wk9";
#  });
#
#  generic-lens = dontCheck (callHackageDirect {
#    pkg = "generic-lens";
#    ver = "1.2.0.1";
#    sha256 = "0pkwyrmaj8wqlajb7cnswh7jq4pnvnhkjcl1flhw94gqn0vap50g";
#  });
#
#  hedgehog-fn = callHackageDirect {
#    pkg = "hedgehog-fn";
#    ver = "1.0";
#    sha256 = "1dhfyfycy0wakw4j7rr01a7v70yms7dw3h60k5af7pi9v700wyb4";
#  };
#
#  http2 = callHackageDirect {
#    pkg = "http2";
#    ver = "2.0.3";
#    sha256 = "14bqmxla0id956y37fpfx9v6crwxphbfxkl8v8annrs8ngfbhbr7";
#  };
#
#  massiv = callHackageDirect {
#    pkg = "massiv";
#    ver = "0.4.2.0";
#    sha256 = "0md9zs1md32ny9ln0dpw2hw1xka1v67alv68s8xhj0p7fabi5lxm";
#  };
#
#  merkle-log = callHackageDirect {
#    pkg = "merkle-log";
#    ver = "0.1.0.0";
#    sha256 = "10jk274sbvsrr7varxa72jvh54n22qpw7d4p2wy7415bmij3y81p";
#  };
#
#  nonempty-containers = callHackageDirect {
#    pkg = "nonempty-containers";
#    ver = "0.3.1.0";
#    sha256 = "1hnwvhz9w07z2mlq75iz0bysz586d828725k1bx8mjqvc86ncv8m";
#  };
#
#  random-strings = callHackageDirect {
#    pkg = "random-strings";
#    ver = "0.1.1.0";
#    sha256 = "1d70i6hcdxrjnk05x0525lmb8wqzy9n0ipr8qd9fxpba89w24jc5";
#  };
#
#  rocksdb-haskell = dontCheck super.rocksdb-haskell;
#
#  # scheduler test suite fails occasionally on linux
#  scheduler = dontCheck (callHackageDirect {
#    pkg = "scheduler";
#    ver = "1.4.2.1";
#    sha256 = "0xlcvcwf3n4zbhf9pa3hyzc4ds628aki077564gaf4sdg1gm90qh";
#  });
#
#  systemd = callHackageDirect {
#    pkg = "systemd";
#    ver = "1.2.0";
#    sha256 = "1mwrrki3zsc4ncr7psjv9iqkzh7f25c2ch4lf2784fh6q46i997j";
#  };
#
#  tasty-json = callHackageDirect {
#    pkg = "tasty-json";
#    ver = "0.1.0.0";
#    sha256 = "16rbagd4ypbs4scmni4na08f3ycsj4g4w4mlizczpxlc1hfbwy5k";
#  };
#
#  these = doJailbreak (callHackageDirect {
#    pkg = "these";
#    ver = "1.0.1";
#    sha256 = "1b2cdc9d9slxjw5cr4pmplfln5kawj2w74zi92hsmwkffqiycjhz";
#  });
#
#  these-skinny = doJailbreak (callHackageDirect {
#    pkg = "these-skinny";
#    ver = "0.7.4";
#    sha256 = "0ryhnik364xmxcr714jlvl7gp3ys37ibqsvkywzhqi277hq6fh52";
#  });
#
#  tls = callHackageDirect {
#    pkg = "tls";
#    ver = "1.5.3";
#    sha256 = "1785i2ba4xvqz9k32qn74vk6zwplmj77dz8jqykndb0g79hq1f27";
#  };
#
#  tls-session-manager = callHackageDirect {
#    pkg = "tls-session-manager";
#    ver = "0.0.4";
#    sha256 = "03jr0xmzl5bqjw2l59bcpfclji6g4rky8ji86mg60jg7nia5d5l8";
#  };
#
#  wai = dontCheck (callHackageDirect {
#    pkg = "wai";
#    ver = "3.2.2.1";
#    sha256 = "0msyixvsk37qsdn3idqxb4sab7bw4v9657nl4xzrwjdkihy411jf";
#  });
#
#  wai-cors = dontCheck (callHackageDirect {
#    pkg = "wai-cors";
#    ver = "0.2.7";
#    sha256 = "10yhjjkzp0ichf9ijiadliafriwh96f194c2g02anvz451capm6i";
#  });
#
#  wai-middleware-throttle = dontCheck (callHackageDirect {
#    pkg = "wai-middleware-throttle";
#    ver = "0.3.0.1";
#    sha256 = "13pz31pl7bk51brc88jp0gffjx80w35kzzrv248w27d7dc8xc63x";
#  });
#
#  wai-extra = whenGhcjs dontCheck (callHackageDirect {
#    pkg = "wai-extra";
#    ver = "3.0.28";
#    sha256 = "1k470vbn2c852syj15m9xzfjnaraw6cyn35ajf2b67i01ghkshgw";
#  });
#
#  wai-app-static = doJailbreak (whenGhcjs dontCheck (callHackageDirect {
#    pkg = "wai-app-static";
#    ver = "3.1.6.3";
#    sha256 = "00dzhv3cdkmxgid34y7bbrkp9940pcmr2brhl2wal7kp0y999ldp";
#  }));
#
#  warp = dontCheck (callHackageDirect {
#    pkg = "warp";
#    ver = "3.3.6";
#    sha256 = "044w7ajkqlwnrpzc4zaqy284ac9wsklyby946jgfpqyjbj87985x";
#  });
#
#  warp-tls = callHackageDirect {
#    pkg = "warp-tls";
#    ver = "3.2.10";
#    sha256 = "1zgr83zkb3q4qa03msfnncwxkmvk63gd8sqkbbd1cwhvjragn4mz";
#  };
#
#  time-manager = callHackageDirect {
#    pkg = "time-manager";
#    ver = "0.0.0";
#    sha256 = "0z2fxikx5ax2x5bg8mcjg4y6b6irmf0swrnfprrp2xry6j5ji6hx";
#  };
#
#  network-byte-order = whenGhcjs dontCheck (callHackageDirect {
#    pkg = "network-byte-order";
#    ver = "0.1.2.0";
#    sha256 = "1a2kq8rmx5q3l1a3b3jcklm7hy3c3z0x08jnnwfik22sy5a5v2nr";
#  });
#
#  strict-tuple = callHackageDirect {
#    pkg = "strict-tuple";
#    ver = "0.1.3";
#    sha256 = "1vg0m27phd6yf0pszcy2c2wbqx509fr9gacn34yja521z17cxd8z";
#  };
#
#  lens-aeson = whenGhcjs dontCheck (callHackageDirect {
#    pkg = "lens-aeson";
#    ver = "1.1";
#    sha256 = "0bx7ay7dx6ljhy1a6bmjdz52vfwmx8af8sd96p38yc0m9irjz02h";
#  });
#
#  streaming-concurrency = callHackageDirect {
#    pkg = "streaming-concurrency";
#    ver = "0.3.1.3";
#    sha256 = "11mgp53kpdnjnrx3l8z6nhm48rhl5i0sgn0vydqa488xinj3h28a";
#  };
#
#  yet-another-logger = callHackageDirect {
#    pkg = "yet-another-logger";
#    ver = "0.4.0";
#    sha256 = "00fv1gil8jp0qhwc7k4ii2fmfpsx942q3yvz9h7iw0s7hmiyb41k";
#  };
#
#  ## chainweb-miner ##
#  http-client = callHackageDirect {
#    pkg = "http-client";
#    ver = "0.6.4";
#    sha256 = "0p1khv99488g3c59cv6ckvpm77h40hf92pw8kxk29csblawi2vhf";
#  };
#
#  retry = callHackageDirect {
#    pkg = "retry";
#    ver = "0.8.0.1";
#    sha256 = "1hbmcc4nkvz1xh01ijksf2n7aprgz2imafgj1bjmj9m47np7g2j1";
#  };
#
#  rio = callHackageDirect {
#    pkg = "rio";
#    ver = "0.1.12.0";
#    sha256 = "1mwv1y9mrhmm5wii09f3gvy100zp6k9441mszx630ilz1igmypkn";
#  };
#
#  typed-process = callHackageDirect {
#    pkg = "typed-process";
#    ver = "0.2.6.0";
#    sha256 = "17m2n9ffh88nj32xc00d48phaxav92dxisprc42pipgigq7fzs5s";
#  };
#
#  unliftio = callHackageDirect {
#    pkg = "unliftio";
#    ver = "0.2.12";
#    sha256 = "1mlvs28mv269vd9j9l67i7w7kwzlh1zm5fm7nqdr7pmhqdr27ybn";
#  };
#
#  # https://github.com/ghcjs/jsaddle/pull/114 widens warp bound
#  # tests disabled because webdriver fails to build
# jsaddle-warp = dontCheck (self.callCabal2nix "jsaddle-warp" (pkgs.fetchFromGitHub {
#   owner = "obsidiansystems";
#   repo = "jsaddle";
#   rev = "86b166033186c1724d4d52eeaf0935f0f29fe1ca";
#   sha256 = "1m1xxy4l9ii91k1k504qkxh9k1ybprm1m66mkb9dqlwcpyhcccmv";
# } + /jsaddle-warp) {});
#
#  ## chainweb-api ##
#  blake2 = dontCheck (callHackageDirect {
#    pkg = "blake2";
#    ver = "0.3.0";
#    sha256 = "0n366qqhz7azh9fgjqvj99b3ni57721a2q5xxlawwmkxrxy36hb2";
#  });
#
#  ## chainweb-data ##
#  beam-core = self.callCabal2nix "beam-core" (repos.beamSrc + "/beam-core") {};
#  beam-migrate = self.callCabal2nix "beam-migrate" (repos.beamSrc + "/beam-migrate") {};
#  beam-postgres = dontCheck (self.callCabal2nix "beam-postgres" (repos.beamSrc + "/beam-postgres") {});
#
#  # Also used by chainweb-node, but this fork not required
#  streaming-events = dontCheck (self.callCabal2nix "streaming-events" (pkgs.fetchFromGitHub {
#    owner = "kadena-io";
#    repo = "streaming-events";
#    rev = "71e811f18d163cf5c4c8a99ce9a01c4c9eae76f0";
#    sha256 = "1riqi1r1gaa5a3av9a25mc4zvaqzaqzcycccvd7mrybkxs3zcjwj";
#  }) {});
#
#  witherable-class = dontCheck (callHackageDirect {
#    pkg = "witherable-class";
#    ver = "0";
#    sha256 = "1v9rkk040j87bnipljmvccxwz8phpkgnq6vbwdq0l7pf7w3im5wc";
#  });
#
#  ## Other ##
#  versions = dontCheck (callHackageDirect {
#    pkg = "versions";
#    ver = "3.5.3";
#    sha256 = "0fm5bhcxbgx14mb5ccx60vdmy0zl9hci9mh15zcqdqnspl67z67j";
#  });
}
