{
  lib,
  fetchurl,
  rustPlatform,
  darwin,
  clang,
  llvmPackages,
  stdenv,
  undmg,
  unzip,
  gzip,
  _7zz,
  makeWrapper,
  xar,
  cpio,
}:
let
  version = "126.0.6478.126-1.1";
in
stdenv.mkDerivation rec {
  name = "chromium";
  pname = name;
  inherit version;

  src = fetchurl {
    url = "https://github.com/claudiodekker/ungoogled-chromium-macos/releases/download/${version}/ungoogled-chromium_${version}_${
      if stdenv.isAarch64 then "arm64" else "x86-64"
    }-macos-signed.dmg";
    hash =
      if stdenv.isAarch64 then
        "sha256-fW+5EwxYa9Bwa0jIVSCs8CitjusuYxs4Lc4icABc1ZQ="
      else
        "sha256-px45f0tXBo/gUzXdpb7i7ZtELHLgjhMFDsYw9XhuxOQ=";
  };

  nativeBuildInputs = [
    undmg
    unzip
    gzip
    _7zz
    makeWrapper
    xar
    cpio
    darwin.xattr
  ];

  unpackPhase = ''
    undmg $src || 7zz x -snld $src
  '';

  sourceRoot = "Chromium.app";

  installPhase = ''
    mkdir -p "$out/Applications/${sourceRoot}"
    cp -R . "$out/Applications/${sourceRoot}"

    makeWrapper "$out/Applications/${sourceRoot}/Contents/MacOS/${lib.removeSuffix ".app" sourceRoot}" $out/bin/chromium
  '';

  meta = {
    homepage = "https://github.com/claudiodekker/ungoogled-chromium-macos";
    description = "Codesigned builds of Chromium";
    platforms = lib.platforms.darwin;
    mainProgram = "Chromium";
  };
}
