# NOTE: This file is taken directly from nixpkgs commit: 3ac85d55b4d863d5a78e8bae3b238a3dd6614363 at
#  > nixpkgs/pkgs/development/libraries/glib-networking/default.nix
{ stdenv, fetchurl, meson, ninja, pkgconfig, glib, gettext, python3, gnutls, p11-kit, libproxy, gnome3
, gsettings-desktop-schemas }:

let
  pname = "glib-networking";
  version = "2.58.0";
in
stdenv.mkDerivation rec {
  name = "${pname}-${version}";

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${stdenv.lib.versions.majorMinor version}/${name}.tar.xz";
    sha256 = "0s006gs9nsq6mg31spqha1jffzmp6qjh10y27h0fxf1iw1ah5ymx";
  };

  outputs = [ "out" "dev" ]; # to deal with propagatedBuildInputs

  PKG_CONFIG_GIO_2_0_GIOMODULEDIR = "${placeholder "out"}/lib/gio/modules";

  postPatch = ''
    chmod +x meson_post_install.py # patchShebangs requires executable file
    patchShebangs meson_post_install.py
  '';

  nativeBuildInputs = [
    meson ninja pkgconfig gettext
    python3 # install_script
  ];
  propagatedBuildInputs = [ glib gnutls p11-kit libproxy gsettings-desktop-schemas ];

  doCheck = false; # tests need to access the certificates (among other things)

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = pname;
    };
  };

  meta = with stdenv.lib; {
    description = "Network-related giomodules for glib";
    license = licenses.lgpl2Plus;
    platforms = platforms.unix;
  };
}

