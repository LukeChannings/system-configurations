{
  lib,
  fetchFromGitHub,
  rustPlatform,
  darwin,
  clang,
  llvmPackages,
  stdenv,
}:

rustPlatform.buildRustPackage rec {
  pname = "nu_plugin_plist";
  version = "0.94.0";

  buildInputs = [
    darwin.IOKit
    clang
    llvmPackages.libclang
  ];
  nativeBuildInputs = [
    darwin.IOKit
    llvmPackages.libclang
  ];

  src = fetchFromGitHub {
    owner = "ayax79";
    repo = pname;
    rev = "1b6ce58bedfe4dcfc9d2853f604b62b919acf73f";
    hash = "sha256-iPXVYpAbCMtAzxhNKrID1XMc/65PfkC4m4AxzeiZ8dI=";
  };

  LIBCLANG_PATH = "${llvmPackages.libclang}/lib";

  preBuild = ''
    # From: https://github.com/NixOS/nixpkgs/blob/1fab95f5190d087e66a3502481e34e15d62090aa/pkgs/applications/networking/browsers/firefox/common.nix#L247-L253
    # Set C flags for Rust's bindgen program. Unlike ordinary C
    # compilation, bindgen does not invoke $CC directly. Instead it
    # uses LLVM's libclang. To make sure all necessary flags are
    # included we need to look in a few places.
    export BINDGEN_EXTRA_CLANG_ARGS="$(< ${stdenv.cc}/nix-support/libc-crt1-cflags) \
      $(< ${stdenv.cc}/nix-support/libc-cflags) \
      $(< ${stdenv.cc}/nix-support/cc-cflags) \
      $(< ${stdenv.cc}/nix-support/libcxx-cxxflags) \
      ${lib.optionalString stdenv.cc.isClang "-idirafter ${stdenv.cc.cc}/lib/clang/${lib.getVersion stdenv.cc.cc}/include"} \
      ${lib.optionalString stdenv.cc.isGNU "-isystem ${stdenv.cc.cc}/include/c++/${lib.getVersion stdenv.cc.cc} -isystem ${stdenv.cc.cc}/include/c++/${lib.getVersion stdenv.cc.cc}/${stdenv.hostPlatform.config} -idirafter ${stdenv.cc.cc}/lib/gcc/${stdenv.hostPlatform.config}/${lib.getVersion stdenv.cc.cc}/include"} \
    "

    export LIBCLANG_PATH="${llvmPackages.libclang}/lib"
  '';

  cargoHash = "sha256-mpCQsXzv9Amly5ct1xQ2ObmW84zghPGZLDyuFpUs6Jc=";

  meta = {
    description = "Plugin for handling plist files in nu";
    homepage = "https://github.com/ayax79/nu_plugin_plist";
    license = lib.licenses.mit;
    maintainers = [ ];
  };
}
